//
//  UIDevice+LYHardware.m
//  LYUI
//
//  Created by 吴浪 on 2018/11/9.
//

#import "UIDevice+LYHardware.h"
#import "LYReachability.h"
#import <sys/utsname.h>
#import <sys/sysctl.h>
#include <net/if.h>
#include <net/if_dl.h>
@import CoreTelephony;

@implementation UIDevice (LYHardware)

+ (NSString *)ly_hwMchine {
    struct utsname systemInfo;
    uname(&systemInfo);
    return [NSString stringWithCString:systemInfo.machine encoding:NSUTF8StringEncoding];
}

+ (BOOL)ly_hasFringeScreen {
    if (@available(iOS 11.0, *)) {
        return !UIEdgeInsetsEqualToEdgeInsets([[UIApplication sharedApplication].windows.firstObject safeAreaInsets], UIEdgeInsetsZero);
    } else {
        return NO;
    }
}


+ (NSUInteger)ly_sysInfo:(uint)typeSpecific {
    size_t size = sizeof(int);
    int result;
    int mib[2] = {CTL_HW, typeSpecific};
    sysctl(mib, 2, &result, &size, NULL, 0);
    return (NSUInteger)result;
}

+ (NSUInteger)ly_cpuFrequency {
   return [self ly_sysInfo:HW_CPU_FREQ];
}

+ (NSUInteger)ly_busFrequency {
    return [self ly_sysInfo:HW_BUS_FREQ];
}

+ (NSUInteger)ly_cpuCount {
    return [self ly_sysInfo:HW_NCPU];
}

+ (NSUInteger)ly_totalMemory {
    return [self ly_sysInfo:HW_PHYSMEM];
}

+ (NSUInteger)ly_userMemory {
    return [self ly_sysInfo:HW_USERMEM];
    
}

+ (NSUInteger)ly_maxSocketBufferSize {
    return [self ly_sysInfo:KIPC_MAXSOCKBUF];
}


+ (NSUInteger)ly_totalDiskSpace {
    NSDictionary *fAttributes = [[NSFileManager defaultManager] attributesOfFileSystemForPath:NSHomeDirectory() error:NULL];
    return [[fAttributes objectForKey:NSFileSystemSize] unsignedIntegerValue];
}

+ (NSUInteger)ly_freeDiskSpace {
    NSDictionary *fAttributes = [[NSFileManager defaultManager] attributesOfFileSystemForPath:NSHomeDirectory() error:NULL];
    return [[fAttributes objectForKey:NSFileSystemFreeSize] unsignedIntegerValue];
}


+ (NSString *)ly_macAddress {
    int                 mib[6];
    size_t              len;
    char                *buf;
    unsigned char       *ptr;
    struct if_msghdr    *ifm;
    struct sockaddr_dl  *sdl;
    
    mib[0] = CTL_NET;
    mib[1] = AF_ROUTE;
    mib[2] = 0;
    mib[3] = AF_LINK;
    mib[4] = NET_RT_IFLIST;
    
    if ((mib[5] = if_nametoindex("en0")) == 0) {
        printf("Error: if_nametoindex error\n");
        return NULL;
    }
    
    if (sysctl(mib, 6, NULL, &len, NULL, 0) < 0) {
        printf("Error: sysctl, take 1\n");
        return NULL;
    }
    
    if ((buf = malloc(len)) == NULL) {
        printf("Error: Memory allocation error\n");
        return NULL;
    }
    
    if (sysctl(mib, 6, buf, &len, NULL, 0) < 0) {
        printf("Error: sysctl, take 2\n");
        free(buf); // Thanks, Remy "Psy" Demerest
        return NULL;
    }
    
    ifm = (struct if_msghdr *)buf;
    sdl = (struct sockaddr_dl *)(ifm + 1);
    ptr = (unsigned char *)LLADDR(sdl);
    NSString *outstring = [NSString stringWithFormat:@"%02X:%02X:%02X:%02X:%02X:%02X", *ptr, *(ptr+1), *(ptr+2), *(ptr+3), *(ptr+4), *(ptr+5)];
    
    free(buf);
    return outstring;
}

+ (LYNetworkType)ly_networkType {
    LYNetworkType networkType;
    LYReachability *reach = [LYReachability reachabilityWithHostName:@"www.apple.com"];
    switch ([reach currentReachabilityStatus]) {
        case LYNetworkStatusNotReachable:
            networkType = LYNetworkTypeNoNetwork;
            break;
        case LYNetworkStatusReachableViaWiFi:
            networkType = LYNetworkTypeWiFi;
            break;
        case LYNetworkStatusReachableViaWWAN:
        {
            CTTelephonyNetworkInfo *info = [[CTTelephonyNetworkInfo alloc] init];
            NSString *currentStatus = info.currentRadioAccessTechnology;
            if ([currentStatus isEqualToString:CTRadioAccessTechnologyGPRS]) {
                networkType = LYNetworkTypeWWANGPRS;
            } else if ([currentStatus isEqualToString:CTRadioAccessTechnologyEdge]) {
                networkType = LYNetworkTypeWWANEDGE;
            } else if ([currentStatus isEqualToString:CTRadioAccessTechnologyWCDMA] ||
                       [currentStatus isEqualToString:CTRadioAccessTechnologyCDMAEVDORev0] ||
                       [currentStatus isEqualToString:CTRadioAccessTechnologyCDMAEVDORevA] ||
                       [currentStatus isEqualToString:CTRadioAccessTechnologyCDMAEVDORevB]) {
                networkType = LYNetworkTypeWWAN3G;
            } else if ([currentStatus isEqualToString:CTRadioAccessTechnologyHSDPA]) {
                networkType = LYNetworkTypeWWANHSDPA;
            } else if ([currentStatus isEqualToString:CTRadioAccessTechnologyHSUPA]) {
                networkType = LYNetworkTypeWWANHSUPA;
            } else if ([currentStatus isEqualToString:CTRadioAccessTechnologyCDMA1x]) {
                networkType = LYNetworkTypeWWAN2G;
            } else if ([currentStatus isEqualToString:CTRadioAccessTechnologyeHRPD]) {
                networkType = LYNetworkTypeWWANHRPD;
            } else if ([currentStatus isEqualToString:CTRadioAccessTechnologyLTE]) {
                networkType = LYNetworkTypeWWAN4G;
            } else {
                networkType = LYNetworkTypeWWAN;
            }
        }
            break;
        default:
            networkType = LYNetworkTypeUnknown;
            break;
    }
    return networkType;
}

@end
