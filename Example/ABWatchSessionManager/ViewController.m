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

@interface ViewController ()

@property (nonatomic, strong) IBOutlet UIButton *actionButton;
@property (nonatomic, strong) IBOutlet UIButton *retryButton;

@property (nonatomic, strong) IBOutlet UILabel *infoLabel;

@end

@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    [self checkWatch];
}

- (void)checkWatch
{
    if ([ABWatchSessionManager sharedInstance].isValidSession) {
        self.actionButton.enabled = YES;
        self.infoLabel.hidden = NO;
    } else {
        self.actionButton.enabled = NO;
        self.infoLabel.hidden = YES;
    }
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

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
