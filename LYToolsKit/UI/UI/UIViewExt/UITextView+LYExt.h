//
//  UITextView+LYExt.h
//  LYUI
//
//  Created by 吴浪 on 16/7/5.
//  Copyright © 2016年 LY. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface UITextView (LYExt)
/**  快速创建
 *  @param  text         文本
 *  @param  font     字体大小
 *  @param  delegate     代理
 *  @return 返回TextView对象
 */
+ (instancetype)ly_TextViewWithText:(nullable NSString *)text
                               font:(nullable UIFont *)font
                          textColor:(nullable UIColor *)textColor
                           delegate:(nullable id<UITextViewDelegate>)delegate;

@end

NS_ASSUME_NONNULL_END
