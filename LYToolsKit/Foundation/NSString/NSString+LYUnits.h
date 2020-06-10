//
//  NSString+LYUnits.h
//  shuaidanbao
//
//  Created by 似水灵修 on 15/9/11.
//  Copyright (c) 2015年 sdb. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface NSString (LYUnits)

/**
 获取数据大小 单位：KB、MB、GB
 @param fileSize 文件字节大小
 @return 数据大小
 @code 感谢@Yi Xu,<youyouapp><CuiYiLong>
 */
+ (instancetype)ly_fileSizeToString:(unsigned long long)fileSize;
+ (instancetype)ly_fileSizeFromData:(NSData *)data;
+ (CGFloat)ly_fileSizeKBFromData:(NSData *)data;
+ (CGFloat)ly_fileSizeMBFromData:(NSData *)data;
+ (CGFloat)ly_fileSizeGBFromData:(NSData *)data;

@end

NS_ASSUME_NONNULL_END
