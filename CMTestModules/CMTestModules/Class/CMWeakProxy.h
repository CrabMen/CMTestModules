//
//  CMWeakProxy.h
//  CMTestModuls
//
//  Created by 智借iOS on 2018/7/9.
//  Copyright © 2018年 CrabMan. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface CMWeakProxy : NSProxy

@property (nullable, nonatomic, weak, readonly) id cm_target;

/**
 Creates a new weak proxy for target.
 
 @param target Target object.
 
 @return A new proxy object.
 */
- (instancetype)initWithTarget:(id)target;

/**
 Creates a new weak proxy for target.
 
 @param target Target object.
 
 @return A new proxy object.
 */
+ (instancetype)cm_proxyWithTarget:(id)target;

@end


NS_ASSUME_NONNULL_END
