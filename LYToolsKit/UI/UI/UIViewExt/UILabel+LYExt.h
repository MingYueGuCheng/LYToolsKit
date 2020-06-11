//
//  UILabel+LYExt.h
//  Tools
//
//  Created by 似水灵修 on 16/3/11.
//  Copyright © 2016年 似水灵修. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface UILabel (LYExt)

/// 快速创建
/// @param title 标题
/// @param font 标题字体
/// @param titleColor 标题颜色
+ (instancetype)ly_labelWithTitle:(nullable NSString *)title
                             font:(nullable UIFont *)font
                       titleColor:(nullable UIColor *)titleColor;

@end

NS_ASSUME_NONNULL_END
