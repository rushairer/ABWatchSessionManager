//
//  ABWatchSessionManager.m
//  ABCameraKit_Example
//
//  Created by Abenx on 2020/3/31.
//  Copyright © 2020 rushairer. All rights reserved.
//

#import "ABWatchSessionManager.h"

@interface ABWatchSessionManager()<WCSessionDelegate>

@property (nonatomic, weak) WCSession *session;

@end

@implementation ABWatchSessionManager

+ (ABWatchSessionManager *)sharedInstance
{
    static ABWatchSessionManager *sharedInstance = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sharedInstance = [[ABWatchSessionManager alloc] init];
    });
    return sharedInstance;
}

+ (id)allocWithZone:(NSZone *)zone
{
    static ABWatchSessionManager *sharedInstance = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sharedInstance = [super allocWithZone:zone];
    });
    return sharedInstance;
}

- (instancetype)init {
    self = [super init];
    if(self) {
    }
    return self;
}

- (id)copy {
    return self;
}

- (id)mutableCopy {
    return self;
}

- (BOOL)willDealloc {
    return NO;
}

- (void)startSession
{
    self.session.delegate = self;
    [self.session activateSession];
}

- (BOOL)isValidSession __WATCHOS_UNAVAILABLE
{
    if (self.session.isPaired && self.session.watchAppInstalled) {
        return YES;
    } else {
        return NO;
    }
}

- (WCSession *)session
{
    if ([WCSession isSupported]) {
        return [WCSession defaultSession];
    } else {
        return nil;
    }
}

#pragma mark - WCSessionDelegate

- (void)session:(WCSession *)session activationDidCompleteWithState:(WCSessionActivationState)activationState error:(nullable NSError *)error __IOS_AVAILABLE(9.3) __WATCHOS_AVAILABLE(2.2)
{
    [self.delegates enumerateObjectsUsingBlock:^(id<WCSessionDelegate> delegate, NSUInteger idx, BOOL * _Nonnull stop) {
        if ([delegate conformsToProtocol:@protocol(WCSessionDelegate)] && [delegate respondsToSelector:@selector(session:activationDidCompleteWithState:error:)]) {
            [delegate session:session activationDidCompleteWithState:activationState error:error];
        }
    }];
}

#pragma mark -  iOS App State For Watch

- (void)sessionDidBecomeInactive:(WCSession *)session __IOS_AVAILABLE(9.3) __WATCHOS_UNAVAILABLE
{
    [self.delegates enumerateObjectsUsingBlock:^(id<WCSessionDelegate> delegate, NSUInteger idx, BOOL * _Nonnull stop) {
        if ([delegate conformsToProtocol:@protocol(WCSessionDelegate)] && [delegate respondsToSelector:@selector(sessionDidBecomeInactive:)]) {
            [delegate sessionDidBecomeInactive:session];
        }
    }];
}

- (void)sessionDidDeactivate:(WCSession *)session __IOS_AVAILABLE(9.3) __WATCHOS_UNAVAILABLE
{
    [self.delegates enumerateObjectsUsingBlock:^(id<WCSessionDelegate> delegate, NSUInteger idx, BOOL * _Nonnull stop) {
        if ([delegate conformsToProtocol:@protocol(WCSessionDelegate)] && [delegate respondsToSelector:@selector(sessionDidDeactivate:)]) {
            [delegate sessionDidDeactivate:session];
        }
    }];
}

#pragma mark - optional following

- (void)sessionWatchStateDidChange:(WCSession *)session __WATCHOS_UNAVAILABLE
{
    [self.delegates enumerateObjectsUsingBlock:^(id<WCSessionDelegate> delegate, NSUInteger idx, BOOL * _Nonnull stop) {
        if ([delegate conformsToProtocol:@protocol(WCSessionDelegate)] && [delegate respondsToSelector:@selector(sessionWatchStateDidChange:)]) {
            [delegate sessionWatchStateDidChange:session];
        }
    }];
}
- (void)sessionCompanionAppInstalledDidChange:(WCSession *)session __IOS_UNAVAILABLE __WATCHOS_AVAILABLE(6.0)
{
    [self.delegates enumerateObjectsUsingBlock:^(id<WCSessionDelegate> delegate, NSUInteger idx, BOOL * _Nonnull stop) {
        if ([delegate conformsToProtocol:@protocol(WCSessionDelegate)] && [delegate respondsToSelector:@selector(sessionCompanionAppInstalledDidChange:)]) {
            [delegate sessionCompanionAppInstalledDidChange:session];
        }
    }];
}

#pragma mark - Interactive Messaging
- (void)sessionReachabilityDidChange:(WCSession *)session
{
    [self.delegates enumerateObjectsUsingBlock:^(id<WCSessionDelegate> delegate, NSUInteger idx, BOOL * _Nonnull stop) {
        if ([delegate conformsToProtocol:@protocol(WCSessionDelegate)] && [delegate respondsToSelector:@selector(sessionReachabilityDidChange:)]) {
            [delegate sessionReachabilityDidChange:session];
        }
    }];
}

- (void)session:(WCSession *)session didReceiveMessage:(NSDictionary<NSString *, id> *)message
{
    [self.delegates enumerateObjectsUsingBlock:^(id<WCSessionDelegate> delegate, NSUInteger idx, BOOL * _Nonnull stop) {
        if ([delegate conformsToProtocol:@protocol(WCSessionDelegate)] && [delegate respondsToSelector:@selector(session:didReceiveMessage:)]) {
            [delegate session:session didReceiveMessage:message];
        }
    }];
}

- (void)session:(WCSession *)session didReceiveMessage:(NSDictionary<NSString *, id> *)message replyHandler:(void(^)(NSDictionary<NSString *, id> *replyMessage))replyHandler
{
    [self.delegates enumerateObjectsUsingBlock:^(id<WCSessionDelegate> delegate, NSUInteger idx, BOOL * _Nonnull stop) {
        if ([delegate conformsToProtocol:@protocol(WCSessionDelegate)] && [delegate respondsToSelector:@selector(session:didReceiveMessage:replyHandler:)]) {
            [delegate session:session didReceiveMessage:message replyHandler:replyHandler];
        }
    }];
}

- (void)session:(WCSession *)session didReceiveMessageData:(NSData *)messageData
{
    [self.delegates enumerateObjectsUsingBlock:^(id<WCSessionDelegate> delegate, NSUInteger idx, BOOL * _Nonnull stop) {
        if ([delegate conformsToProtocol:@protocol(WCSessionDelegate)] && [delegate respondsToSelector:@selector(session:didReceiveMessageData:)]) {
            [delegate session:session didReceiveMessageData:messageData];
        }
    }];
}

- (void)session:(WCSession *)session didReceiveMessageData:(NSData *)messageData replyHandler:(void(^)(NSData *replyMessageData))replyHandler
{
    [self.delegates enumerateObjectsUsingBlock:^(id<WCSessionDelegate> delegate, NSUInteger idx, BOOL * _Nonnull stop) {
        if ([delegate conformsToProtocol:@protocol(WCSessionDelegate)] && [delegate respondsToSelector:@selector(session:didReceiveMessageData:replyHandler:)]) {
            [delegate session:session didReceiveMessageData:messageData replyHandler:replyHandler];
        }
    }];
}

#pragma mark - Background Transfers

- (void)session:(WCSession *)session didReceiveApplicationContext:(NSDictionary<NSString *, id> *)applicationContext
{
    [self.delegates enumerateObjectsUsingBlock:^(id<WCSessionDelegate> delegate, NSUInteger idx, BOOL * _Nonnull stop) {
        if ([delegate conformsToProtocol:@protocol(WCSessionDelegate)] && [delegate respondsToSelector:@selector(session:didReceiveApplicationContext:)]) {
            [delegate session:session didReceiveApplicationContext:applicationContext];
        }
    }];
}

- (void)session:(WCSession * __nonnull)session didFinishUserInfoTransfer:(WCSessionUserInfoTransfer *)userInfoTransfer error:(nullable NSError *)error
{
    
}

- (void)session:(WCSession *)session didReceiveUserInfo:(NSDictionary<NSString *, id> *)userInfo
{
    [self.delegates enumerateObjectsUsingBlock:^(id<WCSessionDelegate> delegate, NSUInteger idx, BOOL * _Nonnull stop) {
        if ([delegate conformsToProtocol:@protocol(WCSessionDelegate)] && [delegate respondsToSelector:@selector(session:didReceiveUserInfo:)]) {
            [delegate session:session didReceiveUserInfo:userInfo];
        }
    }];
}

- (void)session:(WCSession *)session didFinishFileTransfer:(WCSessionFileTransfer *)fileTransfer error:(nullable NSError *)error
{
    [self.delegates enumerateObjectsUsingBlock:^(id<WCSessionDelegate> delegate, NSUInteger idx, BOOL * _Nonnull stop) {
        if ([delegate conformsToProtocol:@protocol(WCSessionDelegate)] && [delegate respondsToSelector:@selector(session:didFinishFileTransfer:error:)]) {
            [delegate session:session didFinishFileTransfer:fileTransfer error:error];
        }
    }];
}

- (void)session:(WCSession *)session didReceiveFile:(WCSessionFile *)file
{
    [self.delegates enumerateObjectsUsingBlock:^(id<WCSessionDelegate> delegate, NSUInteger idx, BOOL * _Nonnull stop) {
        if ([delegate conformsToProtocol:@protocol(WCSessionDelegate)] && [delegate respondsToSelector:@selector(session:didReceiveFile:)]) {
            [delegate session:session didReceiveFile:file];
        }
    }];
}

#pragma mark - getters and setters

- (void)addDelegatesObject:(__weak id <WCSessionDelegate>)object
{
    if ([object conformsToProtocol:@protocol(WCSessionDelegate)]) {
        [_delegates addObject:object];
    }
}

@end
