//
//  UIButton+LYExt.h
//  Tools
//
//  Created by 似水灵修 on 16/3/11.
//  Copyright © 2016年 似水灵修. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface UIButton (LYExt)

/// 快速创建
/// @param nImageName 默认状态图片
/// @param sImageName 选择状态图片
/// @param target 回调对象
/// @param selector 回调方法
+ (instancetype)ly_buttonWithNormalImageName:(nullable NSString *)nImageName
                           selectedImageName:(nullable NSString *)sImageName
                                      target:(nullable id)target
                                    selector:(nullable SEL)selector;

/// 快速创建
/// @param title 标题
/// @param titleColor 标题颜色
/// @param font 标题字体
/// @param target 回调对象
/// @param selector 回调方法
+ (instancetype)ly_buttonWithTitle:(nullable NSString *)title
                        titleColor:(nullable UIColor *)titleColor
                              font:(nullable UIFont *)font
                            target:(nullable id)target
                          selector:(nullable SEL)selector;

@end

NS_ASSUME_NONNULL_END
