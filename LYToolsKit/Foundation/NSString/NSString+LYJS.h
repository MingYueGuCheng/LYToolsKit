//
//  NSString+LYJS.h
//  shuaidanbao
//
//  Created by 似水灵修 on 15/11/17.
//  Copyright © 2015年 sdb. All rights reserved.
//  用于导出常用javascript，做一些简单的页面处理

@import Foundation;

NS_ASSUME_NONNULL_BEGIN

@interface NSString (LYJS)

/// 禁止Web页面的静态链接点击事件
/// @param disable 禁止
+ (instancetype)ly_jsForbidLink:(BOOL)disable;

/// 禁止Web页面的复制粘贴功能
+ (instancetype)ly_jsForbidCopy;

/// 禁止Web页面的长按弹出菜单与放大镜功能
+ (instancetype)ly_jsForbidMenu;

/// Web页面滚动到顶部
+ (instancetype)ly_jsScrollToTop;

/// 获取cookie
/// @param name cookie name
+ (instancetype)ly_cookieValueWithName:(NSString *)name;

/// Web User Agent
+ (instancetype)ly_userAgent;

@end

NS_ASSUME_NONNULL_END
