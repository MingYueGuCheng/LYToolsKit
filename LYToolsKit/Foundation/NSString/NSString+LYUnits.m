//
//  NSString+LYUnits.m
//  shuaidanbao
//
//  Created by 似水灵修 on 15/9/11.
//  Copyright (c) 2015年 sdb. All rights reserved.
//

#import "NSString+LYUnits.h"

@implementation NSString (LYUnits)

+ (instancetype)ly_fileSizeToString:(unsigned long long)fileSize {
    NSInteger KB = 1024;
    NSInteger MB = pow(KB, 2);
    NSInteger GB = pow(KB, 3);
    
    if (fileSize < 10) {
        return @"0 B";
    }else if (fileSize < KB) {
        return [NSString stringWithFormat:@"%.1f B", (CGFloat)fileSize];
    }else if (fileSize < MB) {
        return [NSString stringWithFormat:@"%.1f KB", ((CGFloat)fileSize) / KB];
    }else if (fileSize < GB) {
        return [NSString stringWithFormat:@"%.1f MB", ((CGFloat)fileSize) / MB];
    }else {
        return [NSString stringWithFormat:@"%.1f GB", ((CGFloat)fileSize) / GB];
    }
}

+ (instancetype)ly_fileSizeFromData:(NSData *)data {
   return [self ly_fileSizeToString:data.length];
}

+ (CGFloat)ly_fileSizeKBFromData:(NSData *)data {
    return data.length / (1024 * 0.1);
}

+ (CGFloat)ly_fileSizeMBFromData:(NSData *)data {
    return data.length / (pow(1024, 2) * 0.1);
}

+ (CGFloat)ly_fileSizeGBFromData:(NSData *)data {
    return data.length / (pow(1024, 3) * 0.1);
}

@end
