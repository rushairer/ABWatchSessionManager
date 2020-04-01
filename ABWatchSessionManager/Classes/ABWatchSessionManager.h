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

typedef id<WCSessionDelegate> _Nullable (^WeakDelegate)(void);

@interface ABWatchSessionManager : NSObject

@property (nonatomic, strong, readonly) NSMutableArray<WeakDelegate> *delegates;

#if TARGET_OS_IOS
@property (nonatomic, assign, readonly) BOOL isValidSession __WATCHOS_UNAVAILABLE;
#endif

@property (nonatomic, strong, readonly) WCSession *session;

+ (ABWatchSessionManager *)sharedInstance;

- (void)startSession;
- (void)addDelegateObject:(id <WCSessionDelegate>)delegate;
- (void)removeDelegateObject:(id <WCSessionDelegate>)delegate;

- (void)sendMessage:(NSDictionary<NSString *, id> *)message replyHandler:(nullable void (^)(NSDictionary<NSString *, id> *replyMessage))replyHandler errorHandler:(nullable void (^)(NSError *error))errorHandler;
- (void)sendMessageData:(NSData *)data replyHandler:(nullable void (^)(NSData *replyMessageData))replyHandler errorHandler:(nullable void (^)(NSError *error))errorHandler;

@end

NS_ASSUME_NONNULL_END
