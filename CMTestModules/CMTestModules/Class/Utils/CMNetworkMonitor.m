//
//  CMNetworkMonitor.m
//  CMTestModuls
//
//  Created by 智借iOS on 2018/7/11.
//  Copyright © 2018年 CrabMan. All rights reserved.
//

#import "CMNetworkMonitor.h"
#include <arpa/inet.h>

#include <net/if.h>

#include <ifaddrs.h>

#include <net/if_dl.h>


static uint32_t CellaulriBytes ;

static uint32_t CellaulroBytes ;


@implementation CMNetworkMonitor


+(NSArray *)cm_get3GFlowIOBytes{
    
    struct ifaddrs *ifa_list= 0, *ifa;
    
    if (getifaddrs(&ifa_list)== -1) {
        
        return 0;
        
    }
    
    
    uint32_t iBytes = 0;
    
    uint32_t oBytes = 0;
  
    for (ifa = ifa_list; ifa; ifa = ifa->ifa_next) {
        
        if (AF_LINK != ifa->ifa_addr->sa_family)
            
            continue;
        
        if (!(ifa->ifa_flags& IFF_UP) &&!(ifa->ifa_flags & IFF_RUNNING))
            
            continue;
        
        if (ifa->ifa_data == 0)
            
            continue;
        
        if (!strcmp(ifa->ifa_name,"pdp_ip0")) {
            
            struct if_data *if_data = (struct if_data*)ifa->ifa_data;
//
//            CellaulriBytes = if_data->ifi_ibytes;
//
//            CellaulroBytes = if_data->ifi_obytes;
            
            iBytes += if_data->ifi_ibytes;
            
            oBytes += if_data->ifi_obytes;
            
            NSLog(@"iBytes is %u, oBytes is %u",iBytes ,oBytes);
            
//            CellaulriBytes = if_data->ifi_ibytes;
//
//            CellaulroBytes = if_data->ifi_obytes;
            
        }
        
    }
    
    freeifaddrs(ifa_list);
    
    return @[@(iBytes) , @(oBytes)];
    
}

+(NSArray *)cm_getWifiInterfaceBytes{
    
    struct ifaddrs *ifa_list = 0, *ifa;
    
    if (getifaddrs(&ifa_list) == -1) {
        
        return 0;
        
    }
    
    uint32_t iBytes = 0;
    
    uint32_t oBytes = 0;
    
    for (ifa = ifa_list; ifa; ifa = ifa->ifa_next) {
        
        if (AF_LINK != ifa->ifa_addr->sa_family)
            
            continue;
        
        if (!(ifa->ifa_flags & IFF_UP) && !(ifa->ifa_flags & IFF_RUNNING))
            
            continue;
        
        if (ifa->ifa_data == 0)
            
            continue;
        
        if (strncmp(ifa->ifa_name, "lo", 2)) {
            
            struct if_data *if_data = (struct if_data *)ifa->ifa_data;
            
            iBytes += if_data->ifi_ibytes;
            
            oBytes += if_data->ifi_obytes;
            
            NSLog(@"%s :iBytes is %d, oBytes is %d", ifa->ifa_name, iBytes, oBytes);
            
        }
    }
    
    freeifaddrs(ifa_list);
    
    return @[@(iBytes) , @(oBytes)];

}

+ (NSArray *)cm_getDataCounters{
    
    BOOL   success;
    
    struct ifaddrs *addrs;
    
    const struct ifaddrs *cursor;
    
    const struct if_data *networkStatisc;
    
    
    
    int WiFiSent = 0;
    
    int WiFiReceived = 0;
    
    int WWANSent = 0;
    
    int WWANReceived = 0;
    
    
    
    NSString *name=[[NSString alloc]init];
    
    
    
    success = getifaddrs(&addrs) == 0;
    
    if (success)
        
    {
        
        cursor = addrs;
        
        while (cursor != NULL)
            
        {
            
            name=[NSString stringWithFormat:@"%s",cursor->ifa_name];
            
            NSLog(@"ifa_name %s == %@\n", cursor->ifa_name,name);
            
            // names of interfaces: en0 is WiFi ,pdp_ip0 is WWAN
            
            if (cursor->ifa_addr->sa_family == AF_LINK)
                
            {
                
                if ([name hasPrefix:@"en"])
                    
                {
                    
                    networkStatisc = (const struct if_data *) cursor->ifa_data;
                    
                    WiFiSent+=networkStatisc->ifi_obytes;
                    
                    WiFiReceived+=networkStatisc->ifi_ibytes;
                    
                    NSLog(@"WiFiSent %d ==%d",WiFiSent,networkStatisc->ifi_obytes);
                    
                    NSLog(@"WiFiReceived %d ==%d",WiFiReceived,networkStatisc->ifi_ibytes);
                    
                }
                
                if ([name hasPrefix:@"pdp_ip"])
                    
                {
                    
                    networkStatisc = (const struct if_data *) cursor->ifa_data;
                    
                    WWANSent+=networkStatisc->ifi_obytes;
                    
                    WWANReceived+=networkStatisc->ifi_ibytes;
                    
                    NSLog(@"WWANSent %d ==%d",WWANSent,networkStatisc->ifi_obytes);
                    
                    NSLog(@"WWANReceived %d ==%d",WWANReceived,networkStatisc->ifi_ibytes);
                    
                }
                
            }
            
            cursor = cursor->ifa_next;
            
        }
        
        freeifaddrs(addrs);
        
    }
    
    return [NSArray arrayWithObjects:[NSNumber numberWithInt:WiFiSent], [NSNumber numberWithInt:WiFiReceived],[NSNumber numberWithInt:WWANSent],[NSNumber numberWithInt:WWANReceived], nil];
    
}


+ (NSArray *)cm_networkSpeed {
    
    
    BOOL   success;
    
    struct ifaddrs *addrs;
    
    const struct ifaddrs *cursor;
    
    const struct if_data *networkStatisc;
    
    
    
    int WiFiSent = 0;
    
    int WiFiReceived = 0;
    
    int WWANSent = 0;
    
    int WWANReceived = 0;
    
    
    
    NSString *name=[[NSString alloc]init];
    
    
    
    success = getifaddrs(&addrs) == 0;
    
    if (success)
        
    {
        
        cursor = addrs;
        
        while (cursor != NULL)
            
        {
            
            name=[NSString stringWithFormat:@"%s",cursor->ifa_name];
            
//            NSLog(@"ifa_name %s == %@\n", cursor->ifa_name,name);
            
            // names of interfaces: en0 is WiFi ,pdp_ip0 is WWAN
            
            if (cursor->ifa_addr->sa_family == AF_LINK)
                
            {
                
                if ([name hasPrefix:@"en"])
                    
                {
                    
                    networkStatisc = (const struct if_data *) cursor->ifa_data;
                    
                    WiFiSent+=networkStatisc->ifi_obytes;
                    
                    WiFiReceived+=networkStatisc->ifi_ibytes;
                    
                    NSLog(@"******* WiFiSent %d ********",networkStatisc->ifi_obytes);
                    
                    NSLog(@"******* WiFiReceived %d ********",networkStatisc->ifi_ibytes);
                    
                }
                
                if ([name hasPrefix:@"pdp_ip"])
                    
                {
                    
                    networkStatisc = (const struct if_data *) cursor->ifa_data;
                    
                    WWANSent+=networkStatisc->ifi_obytes;
                    
                    WWANReceived+=networkStatisc->ifi_ibytes;
                    
                    NSLog(@"******** WWANSent %d ********",networkStatisc->ifi_obytes);
                    
                    NSLog(@"******** WWANReceived %d ********",networkStatisc->ifi_ibytes);
                    
                }
                
            }
            
            cursor = cursor->ifa_next;
            
        }
        
        freeifaddrs(addrs);
        
    }
    
    return [NSArray arrayWithObjects:[NSNumber numberWithInt:WiFiSent], [NSNumber numberWithInt:WiFiReceived],[NSNumber numberWithInt:WWANSent],[NSNumber numberWithInt:WWANReceived], nil];
    
    
}



NSString *bytesToAvaiUnit(int bytes) {
    
    if(bytes < 1024) {
        
        return [NSString stringWithFormat:@"%dB", bytes];
    
} else if(bytes >= 1024 && bytes < 1024 * 1024) {

return [NSString stringWithFormat:@"%.1fKB", (double)bytes / 1024];

} else if(bytes >= 1024 * 1024 && bytes < 1024 * 1024 * 1024)  {

return [NSString stringWithFormat:@"%.2fMB", (double)bytes / (1024 * 1024)];

} else {

return [NSString stringWithFormat:@"%.3fGB", (double)bytes / (1024 * 1024 * 1024)];

}

}

@end
