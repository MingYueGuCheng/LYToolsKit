//
//  UIButton+LYExt.m
//  Tools
//
//  Created by 似水灵修 on 16/3/11.
//  Copyright © 2016年 似水灵修. All rights reserved.
//

#import "UIButton+LYExt.h"

@implementation UIButton (LYExt)

+ (instancetype)ly_buttonWithNormalImageName:(NSString *)nImageName selectedImageName:(NSString *)sImageName target:(id)target selector:(SEL)selector {
    UIImage *nImage = nImageName.length ? [UIImage imageNamed:nImageName] : nil;
    UIImage *sImage = sImageName.length ? [UIImage imageNamed:sImageName] : nil;

    UIButton *btn = [self buttonWithType:UIButtonTypeCustom];
    [btn setImage:nImage forState:UIControlStateNormal];
    [btn setImage:sImage forState:UIControlStateSelected];
    [btn addTarget:target action:selector forControlEvents:UIControlEventTouchUpInside];
    return btn;
}

+ (instancetype)ly_buttonWithTitle:(NSString *)title titleColor:(UIColor *)titleColor font:(UIFont *)font target:(id)target selector:(SEL)selector {
    UIButton *btn = [self buttonWithType:UIButtonTypeCustom];
    btn.titleLabel.font = font;
    [btn addTarget:target action:selector forControlEvents:UIControlEventTouchUpInside];
    [btn setTitle:title forState:UIControlStateNormal];
    [btn setTitleColor:titleColor forState:UIControlStateNormal];
    return btn;
}

@end
