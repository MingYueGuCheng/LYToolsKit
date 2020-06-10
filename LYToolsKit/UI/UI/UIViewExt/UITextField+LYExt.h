//
//  UITextField+LYExt.h
//  Tools
//
//  Created by 似水灵修 on 16/3/11.
//  Copyright © 2016年 似水灵修. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface UITextField (LYExt)

/**  快速创建
 *
 *  @param  placeholder  占位符
 *  @param  font     字体大小
 *
 *  @return 返回TextField对象
 */
+ (instancetype)ly_TextFieldWithPlaceholder:(nullable NSString *)placeholder font:(nullable UIFont *)font;

@end

NS_ASSUME_NONNULL_END
