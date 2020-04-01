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
}

- (void)applicationDidEnterBackground:(UIApplication *)application
{
}

- (void)applicationWillEnterForeground:(UIApplication *)application
{
}

- (void)applicationDidBecomeActive:(UIApplication *)application
{
}

- (void)applicationWillTerminate:(UIApplication *)application
{
}

@end
