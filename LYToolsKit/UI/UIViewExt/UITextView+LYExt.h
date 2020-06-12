//
//  UITextView+LYExt.h
//  LYUI
//
//  Created by 似水灵修 on 16/7/5.
//  Copyright © 2016年 LY. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface UITextView (LYExt)

/// 快速创建
/// @param text 标题
/// @param font 标题字体
/// @param textColor 标题颜色
/// @param delegate 代理
+ (instancetype)ly_textViewWithText:(nullable NSString *)text
                               font:(nullable UIFont *)font
                          textColor:(nullable UIColor *)textColor
                           delegate:(nullable id<UITextViewDelegate>)delegate;

@end

NS_ASSUME_NONNULL_END
