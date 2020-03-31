//
//  ABWatchSessionManager.h
//  ABCameraKit_Example
//
//  Created by Abenx on 2020/3/31.
//  Copyright © 2020 rushairer. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <WatchConnectivity/WatchConnectivity.h>

NS_ASSUME_NONNULL_BEGIN

@protocol WCSessionDelegate;

@interface ABWatchSessionManager : NSObject

@property (nonatomic, strong) NSMutableArray<id <WCSessionDelegate>> *delegates;
@property (nonatomic, assign, readonly) BOOL isValidSession __WATCHOS_UNAVAILABLE;
@property (nonatomic, strong, readonly) WCSession *session;

+ (ABWatchSessionManager *)sharedInstance;

- (void)startSession;

@end

NS_ASSUME_NONNULL_END
