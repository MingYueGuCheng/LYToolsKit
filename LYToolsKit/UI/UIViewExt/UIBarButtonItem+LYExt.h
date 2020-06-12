//
//  UIBarButtonItem+LYExt.h
//  茗玥古城
//
//  Created by 似水灵修 on 13-11-11.
//  Copyright (c) 2013年 MingYueGuCheng. All rights reserved.

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface UIBarButtonItem (LYExt)

/// 快速创建
/// @param nImageName 普通状态图片
/// @param hImageName 高亮状态图片
/// @param target 回调对象
/// @param action 回调方法
+ (instancetype)ly_itemWithNormalImageName:(nullable NSString *)nImageName
                             highImageName:(nullable NSString *)hImageName
                                    target:(nullable id)target
                                    action:(nullable SEL)action;

@end

NS_ASSUME_NONNULL_END
