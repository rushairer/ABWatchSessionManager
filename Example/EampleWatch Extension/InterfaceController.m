//
//  InterfaceController.m
//  EampleWatch Extension
//
//  Created by Abenx on 2020/3/31.
//  Copyright © 2020 rushairer. All rights reserved.
//

#import "InterfaceController.h"
#import <ABWatchSessionManager/ABWatchSessionManager.h>


@interface InterfaceController ()<WCSessionDelegate>

@property (weak, nonatomic) IBOutlet WKInterfaceLabel *statusLabel;

@end


@implementation InterfaceController

- (void)awakeWithContext:(id)context {
    [super awakeWithContext:context];
    
    [[ABWatchSessionManager sharedInstance] addDelegateObject:self];
}

- (void)willActivate {
    [super willActivate];
}

- (void)didDeactivate {
    [super didDeactivate];
}

- (void)disconnected
{
    [self.statusLabel setText:@"Disconnected"];
    [self.statusLabel setTextColor:[UIColor darkGrayColor]];
}

- (void)connecting
{
    [self.statusLabel setText:@"Connecting"];
    [self.statusLabel setTextColor:[UIColor whiteColor]];
}

#pragma mark - private methods

- (void)sendMessageToPhone:(NSString *)message
{
    [[ABWatchSessionManager sharedInstance].session sendMessage:[NSDictionary dictionaryWithObjectsAndKeys:message, @"MSG", nil]
                                                   replyHandler:^(NSDictionary<NSString *,id> * _Nonnull replyMessage) {
        NSLog(@"replyMessage: %@", replyMessage);
    } errorHandler:^(NSError * _Nonnull error) {
        NSLog(@"%@", [error description]);
    }];
}

#pragma mark - WCSessionDelegate

- (void)session:(WCSession *)session didReceiveMessage:(NSDictionary<NSString *,id> *)message replyHandler:(void (^)(NSDictionary<NSString *,id> * _Nonnull))replyHandler
{
    NSString *msg = [[message objectForKey:@"MSG"] description];
    
    if ([msg isEqualToString:@"BYE"]) {
        [self disconnected];
    } else if ([msg isEqualToString:@"PING"]) {
        [self connecting];
        
    } else if (![msg isEqualToString:@"DONE"]) {
        replyHandler([NSDictionary dictionaryWithObjectsAndKeys:@"DONE", @"MSG", nil]);
    }
}

- (void)session:(nonnull WCSession *)session activationDidCompleteWithState:(WCSessionActivationState)activationState error:(nullable NSError *)error {
    if (activationState == WCSessionActivationStateNotActivated) {
    }
}

@end



