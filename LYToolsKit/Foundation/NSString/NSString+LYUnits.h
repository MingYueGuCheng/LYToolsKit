//
//  NSString+LYUnits.h
//  shuaidanbao
//
//  Created by 似水灵修 on 15/9/11.
//  Copyright (c) 2015年 sdb. All rights reserved.
//

@import Foundation;

NS_ASSUME_NONNULL_BEGIN

/// 感谢@Yi Xu,<youyouapp><CuiYiLong>，提供的方法
@interface NSString (LYUnits)

/// 获取数据大小 单位：KB、MB、GB
/// @param fileSize 文件字节大小,单位：字节(B)
+ (instancetype)ly_fileSizeToString:(unsigned long long)fileSize;

/// 获取数据大小 单位：KB、MB、GB
/// @param data 数据
+ (instancetype)ly_fileSizeFromData:(NSData *)data;
+ (CGFloat)ly_fileSizeKBFromData:(NSData *)data;
+ (CGFloat)ly_fileSizeMBFromData:(NSData *)data;
+ (CGFloat)ly_fileSizeGBFromData:(NSData *)data;

@end

NS_ASSUME_NONNULL_END
