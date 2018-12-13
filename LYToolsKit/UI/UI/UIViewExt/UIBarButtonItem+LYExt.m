//
//  UIBarButtonItem+Item.m
//  茗玥古城
//
//  Created by 似水灵修 on 13-11-11.
//  Copyright (c) 2013年 MingYueGuCheng. All rights reserved.
//  

#import "UIBarButtonItem+LYExt.h"

@implementation UIBarButtonItem (LYExt)

/**
 *  设置导航栏按钮
 *
 *  @param nImageName 普通状态图片
 *  @param hImageName 高亮状态图片
 *  @param action     响应事件
 */
+ (UIBarButtonItem *)ly_itemWithNormalImageName:(NSString *)nImageName highImageName:(NSString *)hImageName target:(id)target action:(SEL)action {
    UIImage *nImage = nImageName.length ? [UIImage imageNamed:nImageName] : nil;
    UIImage *hImage = hImageName.length ? [UIImage imageNamed:hImageName] : nil;
    
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    [btn setBackgroundImage:nImage forState:UIControlStateNormal];
    [btn setBackgroundImage:hImage forState:UIControlStateHighlighted];
    [btn addTarget:target action:action forControlEvents:UIControlEventTouchUpInside];
    return [[UIBarButtonItem alloc] initWithCustomView:btn];
}

@end
