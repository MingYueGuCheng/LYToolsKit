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
