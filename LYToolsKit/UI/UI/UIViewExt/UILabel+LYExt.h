//
//  UILabel+LYExt.h
//  Tools
//
//  Created by 吴浪 on 16/3/11.
//  Copyright © 2016年 吴浪. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface UILabel (LYExt)

/**  快速创建
 *
 *  @param  title       title
 *  @param  font    字体大小
 *  @param  titleColor  字体颜色
 *
 *  @return 返回Label对象
 */
+ (instancetype)ly_LabelWithTitle:(nullable NSString *)title
                             font:(nullable UIFont *)font
                       titleColor:(nullable UIColor *)titleColor;

@end

NS_ASSUME_NONNULL_END
