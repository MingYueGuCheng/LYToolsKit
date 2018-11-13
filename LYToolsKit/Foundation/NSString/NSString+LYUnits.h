//
//  NSString+LYUnits.h
//  shuaidanbao
//
//  Created by 吴浪 on 15/9/11.
//  Copyright (c) 2015年 sdb. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface NSString (LYUnits)

/** 数据大小转换KB、MB、GB */
+ (instancetype)ly_fileSizeToString:(unsigned long long)fileSize;

@end

NS_ASSUME_NONNULL_END
