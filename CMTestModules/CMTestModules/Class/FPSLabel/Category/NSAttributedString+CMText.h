//
//  NSAttributedString+CMText.h
//  CMTestModuls
//
//  Created by 智借iOS on 2018/7/9.
//  Copyright © 2018年 CrabMan. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreFoundation/CoreFoundation.h>
#import <UIKit/UIKit.h>
#import <CoreText/CoreText.h>
@interface NSAttributedString (CMText)

@end





@interface NSMutableAttributedString (CMText)



- (void)cm_setAttributes:(NSDictionary *)attributes;

- (void)cm_setAttribute:(NSString *)name value:(id)value ;

- (void)cm_setAttribute:(NSString *)name value:(id)value range:(NSRange)range ;

- (void)cm_removeAttributesInRange:(NSRange)range ;



- (void)cm_setColor:(UIColor *)color range:(NSRange)range ;

- (void)cm_setBackgroundColor:(UIColor *)backgroundColor range:(NSRange)range ;

- (void)cm_setStrokeWidth:(NSNumber *)strokeWidth range:(NSRange)range ;

- (void)cm_setStrokeColor:(UIColor *)strokeColor range:(NSRange)range ;

- (void)cm_setShadow:(NSShadow *)shadow range:(NSRange)range ;

@property (nullable, nonatomic, strong, readwrite) UIFont *font;
- (void)cm_setFont:(nullable UIFont *)font range:(NSRange)range;

@end
