//
//  CMNetworkMonitor.h
//  CMTestModuls
//
//  Created by 智借iOS on 2018/7/11.
//  Copyright © 2018年 CrabMan. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CMNetworkMonitor : NSObject

+ (NSArray *)cm_getDataCounters;

+ (NSArray *)cm_networkSpeed;

+(NSArray *)cm_get3GFlowIOBytes;

+(NSArray *)cm_getWifiInterfaceBytes;
@end
