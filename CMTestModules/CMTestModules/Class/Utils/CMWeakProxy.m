//
//  CMWeakProxy.m
//  CMTestModuls
//
//  Created by 智借iOS on 2018/7/9.
//  Copyright © 2018年 CrabMan. All rights reserved.
//

#import "CMWeakProxy.h"

@implementation CMWeakProxy

- (instancetype)initWithTarget:(id)target {
    _cm_target = target;
    return self;
}

+ (instancetype)cm_proxyWithTarget:(id)target {
    return [[CMWeakProxy alloc] initWithTarget:target];
}

- (id)forwardingTargetForSelector:(SEL)selector {
    return _cm_target;
}

- (void)forwardInvocation:(NSInvocation *)invocation {
    void *null = NULL;
    [invocation setReturnValue:&null];
}

- (NSMethodSignature *)methodSignatureForSelector:(SEL)selector {
    return [NSObject instanceMethodSignatureForSelector:@selector(init)];
}

- (BOOL)respondsToSelector:(SEL)aSelector {
    return [_cm_target respondsToSelector:aSelector];
}

- (BOOL)isEqual:(id)object {
    return [_cm_target isEqual:object];
}

- (NSUInteger)hash {
    return [_cm_target hash];
}

- (Class)superclass {
    return [_cm_target superclass];
}

- (Class)class {
    return [_cm_target class];
}

- (BOOL)isKindOfClass:(Class)aClass {
    return [_cm_target isKindOfClass:aClass];
}

- (BOOL)isMemberOfClass:(Class)aClass {
    return [_cm_target isMemberOfClass:aClass];
}

- (BOOL)conformsToProtocol:(Protocol *)aProtocol {
    return [_cm_target conformsToProtocol:aProtocol];
}

- (BOOL)isProxy {
    return YES;
}

- (NSString *)description {
    return [_cm_target description];
}

- (NSString *)debugDescription {
    return [_cm_target debugDescription];
}

@end
