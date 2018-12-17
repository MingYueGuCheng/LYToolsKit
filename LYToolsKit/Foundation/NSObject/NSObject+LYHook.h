//
//  NSObject+LYHook.h
//  LYFoundation
//
//  Created by LY on 2017/10/18.
//  Copyright © 2017年 LY. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface NSObject (LYHook)

/**
 block重写方式实现
 void(*)(id, SEL, ...)
 id(*)(id, SEL, ...)
 @param targetSEL 目标方法选择器
 @param block 该 block 必须返回一个 block，返回的 block 将被当成 targetSEL 的新实现
 @return 是否重写成功
 */
+ (BOOL)ly_OverrideImplement:(SEL)targetSEL block:(id(^)(Class originClass, SEL originSEL, IMP originIMP))block;
/**
 block重写方式实现
 void(*)(id, SEL, ...)
 id(*)(id, SEL, ...)
 @param targetSEL 目标方法选择器
 @param block 该 block 必须返回一个 block，返回的 block 将被当成 targetSEL 的新实现
 @return 是否重写成功
 */
- (BOOL)ly_OverrideImplement:(SEL)targetSEL block:(id(^)(Class originClass, SEL originSEL, IMP originIMP))block;
/**
 hook类方法的实现

 @param origSEL origSEL 需要hook的方法
 @param newSEL newSEL 新实现的方法
 @return return value 是否Hook成功
 */
+ (BOOL)ly_hookOrigMethod:(SEL)origSEL newMethod:(SEL)newSEL;
/**
 hook对象方法的实现

 @param origSEL origSEL 需要hook的方法
 @param newSEL newSEL 新实现的方法
 @return return value 是否Hook成功
 */
- (BOOL)ly_hookOrigMethod:(SEL)origSEL newMethod:(SEL)newSEL;

@end

NS_ASSUME_NONNULL_END
