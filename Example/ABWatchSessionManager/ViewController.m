//
//  ViewController.m
//  ABWatchSessionManager
//
//  Created by rushairer on 03/31/2020.
//  Copyright (c) 2020 rushairer. All rights reserved.
//

#import "ViewController.h"
#import <ABWatchSessionManager/ABWatchSessionManager.h>
#import <HealthKit/HealthKit.h>

@interface ViewController ()<WCSessionDelegate>

@property (nonatomic, weak) IBOutlet UIButton *actionButton;
@property (nonatomic, weak) IBOutlet UIButton *retryButton;

@property (nonatomic, weak) IBOutlet UILabel *infoLabel;

@end

@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    [[ABWatchSessionManager sharedInstance] addDelegateObject:self];
    
    [self checkWatch];
}

#pragma mark - private methods

- (void)checkWatch
{
    if ([ABWatchSessionManager sharedInstance].isValidSession && [ABWatchSessionManager sharedInstance].session.isReachable) {
        [self connecting];
    } else {
        [self disconnected];
    }
}

- (void)disconnected
{
    self.actionButton.enabled = NO;
    self.infoLabel.hidden = YES;
}

- (void)connecting
{
    self.actionButton.enabled = YES;
    self.infoLabel.hidden = NO;
}

- (void)startWatchApp
{
    if (@available(iOS 10.0, *)) {
        HKHealthStore *healthStore = [[HKHealthStore alloc] init];
        HKWorkoutConfiguration *config = [[HKWorkoutConfiguration alloc] init];
        [healthStore startWatchAppWithWorkoutConfiguration:config completion:^(BOOL success, NSError * _Nullable error) {
        }];
    } else {
        // Fallback on earlier versions
    }
}

#pragma mark - events

- (IBAction)actionButtonDidClick:(UIButton *)sender
{
    [[ABWatchSessionManager sharedInstance].session sendMessage:[NSDictionary dictionaryWithObjectsAndKeys:@"PING", @"MSG", nil]
                                                   replyHandler:^(NSDictionary<NSString *,id> * _Nonnull replyMessage) {
        NSLog(@"replyMessage: %@", replyMessage);
    } errorHandler:^(NSError * _Nonnull error) {
        NSLog(@"%@", [error description]);
    }];
}

- (IBAction)retryButtonDidClick:(UIButton *)sender
{
    [self checkWatch];
    [self startWatchApp];
}


#pragma mark - WCSessionDelegate

- (void)session:(nonnull WCSession *)session activationDidCompleteWithState:(WCSessionActivationState)activationState error:(nullable NSError *)error {
    
}

- (void)sessionDidBecomeInactive:(nonnull WCSession *)session {
    
}

- (void)sessionDidDeactivate:(nonnull WCSession *)session {
    
}
- (void)sessionReachabilityDidChange:(WCSession *)session
{
    if (session.isReachable) {
        dispatch_async(dispatch_get_main_queue(), ^{
            [self connecting];
        });
    } else {
        dispatch_async(dispatch_get_main_queue(), ^{
            [self disconnected];
        });
    }
}

@end
