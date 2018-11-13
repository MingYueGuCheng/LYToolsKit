//
//  NSString+LYJS.h
//  shuaidanbao
//
//  Created by 吴浪 on 15/11/17.
//  Copyright © 2015年 sdb. All rights reserved.
//  用于导出常用javascript，做一些简单的页面处理

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface NSString (LYJS)

/**
 禁止点击Web页面的静态链接

 @param disable disable 是否禁止
 @return return value js脚本
 */
+ (instancetype)ly_jsForbidLink:(BOOL)disable;
/** 禁止Web页面复制粘贴 */
+ (instancetype)ly_jsForbidCopy;
/** 禁止Web页面长按弹出菜单与放大镜 */
+ (instancetype)ly_jsForbidMenu;
/** Web页面滚动到顶部 */
+ (instancetype)ly_jsScrollToTop;
/**
 获取cookie

 @param name cookie name
 @return cookie
 */
+ (instancetype)ly_cookieValueWithName:(NSString *)name;
/** Web User Agent */
+ (instancetype)ly_userAgentWeb;

@end

NS_ASSUME_NONNULL_END
