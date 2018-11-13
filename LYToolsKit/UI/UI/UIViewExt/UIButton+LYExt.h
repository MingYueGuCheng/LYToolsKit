//
//  UIButton+LYExt.h
//  Tools
//
//  Created by 吴浪 on 16/3/11.
//  Copyright © 2016年 吴浪. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface UIButton (LYExt)

/**  快速创建
 *  @param  nImageName  默认状态图片名
 *  @param  sImageName  选择状态图片名
 *  @param  font        字体
 *  @param  target      回调对象
 *  @param  selector    回调方法
 *  @return 返回Button对象
 */
+ (instancetype)ly_ButtonWithNormalImageName:(nullable NSString *)nImageName
                            selecteImageName:(nullable NSString *)sImageName
                                        font:(nullable UIFont *)font
                                      target:(nullable id)target
                                    selector:(nullable SEL)selector;
/**  快速创建
 *  @param  nImageName  默认状态图片名
 *  @param  sImageName  选择状态图片名
 *  @param  target      回调对象
 *  @param  selector    回调方法
 *  @return 返回Button对象
 */
+ (instancetype)ly_ButtonWithNormalImageName:(nullable NSString *)nImageName
                            selecteImageName:(nullable NSString *)sImageName
                                      target:(nullable id)target
                                    selector:(nullable SEL)selector;

/**
 快速创建
 
 @param title       默认状态title
 @param titleColor  默认状态titleColor
 @param font        字体
 @param target      回调对象
 @param selector    回调方法
 @return button对象
 */
+ (instancetype)ly_ButtonWithTitle:(nullable NSString *)title
                        titleColor:(nullable UIColor *)titleColor
                              font:(nullable UIFont *)font
                            target:(nullable id)target
                          selector:(nullable SEL)selector;

@end

NS_ASSUME_NONNULL_END
