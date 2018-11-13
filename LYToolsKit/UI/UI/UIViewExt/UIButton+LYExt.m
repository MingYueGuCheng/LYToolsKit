//
//  UIButton+LYExt.m
//  Tools
//
//  Created by 吴浪 on 16/3/11.
//  Copyright © 2016年 吴浪. All rights reserved.
//

#import "UIButton+LYExt.h"

@implementation UIButton (LYExt)

+ (instancetype)ly_ButtonWithNormalImageName:(NSString *)nImageName selecteImageName:(NSString *)sImageName font:(UIFont *)font target:(id)target selector:(SEL)selector {
    UIImage *nImage = nImageName.length ? [UIImage imageNamed:nImageName] : nil;
    UIImage *sImage = sImageName.length ? [UIImage imageNamed:sImageName] : nil;

    UIButton *btn = [self buttonWithType:UIButtonTypeCustom];
    btn.titleLabel.font = font;
    [btn setImage:nImage forState:UIControlStateNormal];
    [btn setImage:sImage forState:UIControlStateSelected];
    [btn addTarget:target action:selector forControlEvents:UIControlEventTouchUpInside];
    return btn;
}

+ (instancetype)ly_ButtonWithNormalImageName:(NSString *)nImageName selecteImageName:(NSString *)sImageName target:(id)target selector:(SEL)selector {
    return [self ly_ButtonWithNormalImageName:nImageName selecteImageName:sImageName font:nil target:target selector:selector];
}

+ (instancetype)ly_ButtonWithTitle:(NSString *)title titleColor:(UIColor *)titleColor font:(UIFont *)font target:(id)target selector:(SEL)selector {
    UIButton *btn = [self ly_ButtonWithNormalImageName:nil selecteImageName:nil font:(UIFont *)font target:target selector:selector];
    [btn setTitle:title forState:UIControlStateNormal];
    [btn setTitleColor:titleColor forState:UIControlStateNormal];
    return btn;
}

@end
