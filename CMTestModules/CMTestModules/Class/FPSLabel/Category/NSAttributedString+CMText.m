//
//  NSAttributedString+CMText.m
//  CMTestModuls
//
//  Created by 智借iOS on 2018/7/9.
//  Copyright © 2018年 CrabMan. All rights reserved.
//

#import "NSAttributedString+CMText.h"


@implementation NSAttributedString (CMText)


@end

@implementation NSMutableAttributedString (CMText)


- (void)cm_setAttributes:(NSDictionary *)attributes {
    if (attributes == (id)[NSNull null]) attributes = nil;
    
    
    [self setAttributes:@{} range:NSMakeRange(0, self.length)];
    
    
    
    [attributes enumerateKeysAndObjectsUsingBlock:^(id key, id obj, BOOL *stop) {
        [self cm_setAttribute:key value:obj];
    }];
}

- (void)cm_setAttribute:(NSString *)name value:(id)value {
    [self cm_setAttribute:name value:value range:NSMakeRange(0, self.length)];
}

- (void)cm_setAttribute:(NSString *)name value:(id)value range:(NSRange)range {
    if (!name || [NSNull isEqual:name]) return;
    if (value && ![NSNull isEqual:value]) [self addAttribute:name value:value range:range];
    else [self removeAttribute:name range:range];
}

- (void)cm_removeAttributesInRange:(NSRange)range {
    [self setAttributes:nil range:range];
}


#pragma mark - Property Setter

- (void)cm_setColor:(UIColor *)color range:(NSRange)range {
    [self cm_setAttribute:(id)kCTForegroundColorAttributeName value:(id)color.CGColor range:range];
    [self cm_setAttribute:NSForegroundColorAttributeName value:color range:range];
}

- (void)cm_setBackgroundColor:(UIColor *)backgroundColor range:(NSRange)range {
    [self cm_setAttribute:NSBackgroundColorAttributeName value:backgroundColor range:range];
}

- (void)cm_setStrokeWidth:(NSNumber *)strokeWidth range:(NSRange)range {
    [self cm_setAttribute:NSStrokeWidthAttributeName value:strokeWidth range:range];
}

- (void)cm_setStrokeColor:(UIColor *)strokeColor range:(NSRange)range {
    [self cm_setAttribute:(id)kCTStrokeColorAttributeName value:(id)strokeColor.CGColor range:range];
    [self cm_setAttribute:NSStrokeColorAttributeName value:strokeColor range:range];
}

- (void)cm_setShadow:(NSShadow *)shadow range:(NSRange)range {
    [self cm_setAttribute:NSShadowAttributeName value:shadow range:range];
}



- (void)setFont:(UIFont *)font {

    [self cm_setFont:font range:NSMakeRange(0, self.length)];
    
}


- (void)cm_setFont:(UIFont *)font range:(NSRange)range {
    /*
     In iOS7 and later, UIFont is toll-free bridged to CTFontRef,
     although Apple does not mention it in documentation.
     
     In iOS6, UIFont is a wrapper for CTFontRef, so CoreText can alse use UIfont,
     but UILabel/UITextView cannot use CTFontRef.
     
     We use UIFont for both CoreText and UIKit.
     */
    [self cm_setAttribute:NSFontAttributeName value:font range:range];
}

@end
