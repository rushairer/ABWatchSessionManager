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

@end


@implementation InterfaceController

- (void)awakeWithContext:(id)context {
    [super awakeWithContext:context];

    [[ABWatchSessionManager sharedInstance].delegates addObject:self];
}

- (void)willActivate {
    // This method is called when watch view controller is about to be visible to user
    [super willActivate];
}

- (void)didDeactivate {
    // This method is called when watch view controller is no longer visible
    [super didDeactivate];
}

#pragma mark - WCSessionDelegate

- (void)session:(WCSession *)session didReceiveMessage:(NSDictionary<NSString *,id> *)message replyHandler:(void (^)(NSDictionary<NSString *,id> * _Nonnull))replyHandler
{
    NSString *msg = [[message objectForKey:@"MSG"] description];
    NSLog(@"MSG:%@", msg);
    if (![msg isEqualToString:@"DONE"]) {
        replyHandler([NSDictionary dictionaryWithObjectsAndKeys:@"DONE", @"MSG", nil]);
    }
}


- (void)session:(nonnull WCSession *)session activationDidCompleteWithState:(WCSessionActivationState)activationState error:(nullable NSError *)error {
    if (activationState == WCSessionActivationStateNotActivated) {
    }
}

@end



