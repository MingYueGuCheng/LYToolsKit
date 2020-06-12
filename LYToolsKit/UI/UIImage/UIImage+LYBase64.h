//
//  UIImage+LYBase64.h
//  LYUI
//
//  Created by 似水灵修 on 16/5/6.
//  Copyright © 2016年 dingli. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface UIImage (LYBase64)

/** 通过base64字符串创建一张图片（同步获取） */
+ (nullable instancetype)ly_imageWithBase64:(NSString *)base64;
/** 通过base64字符串创建一张图片（异步获取） */
+ (void)ly_imageWithBase64:(NSString *)base64 completion:(void (^)(UIImage * _Nullable image))completion;
/** 图片转化为base64字符串 */
- (nullable NSString *)ly_base64;

@end

NS_ASSUME_NONNULL_END
