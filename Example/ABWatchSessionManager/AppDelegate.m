//
//  AppDelegate.m
//  ABWatchSessionManager
//
//  Created by rushairer on 03/31/2020.
//  Copyright (c) 2020 rushairer. All rights reserved.
//

#import "AppDelegate.h"
#import <ABWatchSessionManager/ABWatchSessionManager.h>

@implementation AppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    // Override point for customization after application launch.
    
    [[ABWatchSessionManager sharedInstance] startSession];
    return YES;
}

- (void)applicationWillResignActive:(UIApplication *)application
{
    [self sendMessageToWatch:@"BYE"];
}

- (void)applicationDidEnterBackground:(UIApplication *)application
{
    [self sendMessageToWatch:@"BYE"];
}

- (void)applicationWillEnterForeground:(UIApplication *)application
{
    [self sendMessageToWatch:@"PING"];
}

- (void)applicationDidBecomeActive:(UIApplication *)application
{
    [self sendMessageToWatch:@"PING"];
}

- (void)applicationWillTerminate:(UIApplication *)application
{
    [self sendMessageToWatch:@"BYE"];
}

- (void)sendMessageToWatch:(NSString *)message
{
    [[ABWatchSessionManager sharedInstance].session sendMessage:[NSDictionary dictionaryWithObjectsAndKeys:message, @"MSG", nil]
                                                   replyHandler:^(NSDictionary<NSString *,id> * _Nonnull replyMessage) {
        NSLog(@"replyMessage: %@", replyMessage);
    } errorHandler:^(NSError * _Nonnull error) {
        NSLog(@"%@", [error description]);
    }];
}

@end
