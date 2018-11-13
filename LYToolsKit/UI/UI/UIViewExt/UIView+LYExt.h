//
//  UIView+LYExt.m
//  茗玥古城
//
//  Created by 似水灵修 on 13-11-11.
//  Copyright (c) 2013年 MingYueGuCheng. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface UIView (LYExt)

// getter方法：获取距离self所在坐标系中，x轴或y轴距离
// setter方法：只有在self的frame确定的情况下使用
@property (assign, nonatomic) CGFloat top;
@property (assign, nonatomic) CGFloat bottom;
@property (assign, nonatomic) CGFloat left;
@property (assign, nonatomic) CGFloat right;

// 简化UIView的frame属性设置
@property (nonatomic, assign) CGFloat x;
@property (nonatomic, assign) CGFloat y;
@property (nonatomic, assign) CGFloat centerX;
@property (nonatomic, assign) CGFloat centerY;

@property (nonatomic, assign) CGFloat width;
@property (nonatomic, assign) CGFloat height;

@property (nonatomic, assign) CGSize size;
@property (nonatomic, assign) CGPoint origin;

/** 快速创建 */
+ (instancetype)ly_ViewWithColor:(nullable UIColor *)color;

@end

NS_ASSUME_NONNULL_END
