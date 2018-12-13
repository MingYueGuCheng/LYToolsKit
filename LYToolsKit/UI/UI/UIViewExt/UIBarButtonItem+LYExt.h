//
//  UIBarButtonItem+LYExt.h
//  茗玥古城
//
//  Created by 似水灵修 on 13-11-11.
//  Copyright (c) 2013年 MingYueGuCheng. All rights reserved.

#import <UIKit/UIKit.h>

@interface UIBarButtonItem (LYExt)
/**
 快速创建

 @param nImageName 普通状态图片
 @param hImageName 高亮状态图片
 @param target 回调对象
 @param action 回调方法
 @return 返回BarButtonItem对象
 */
+ (UIBarButtonItem *)ly_itemWithNormalImageName:(NSString *)nImageName
                                  highImageName:(NSString *)hImageName
                                         target:(id)target
                                         action:(SEL)action;
@end
