//
//  UITextField+LYExt.m
//  Tools
//
//  Created by 似水灵修 on 16/3/11.
//  Copyright © 2016年 似水灵修. All rights reserved.
//

#import "UITextField+LYExt.h"

@implementation UITextField (LYExt)

+ (instancetype)ly_TextFieldWithPlaceholder:(NSString *)placeholder font:(UIFont *)font {
    UITextField *textField = [[self alloc] init];
    textField.placeholder = placeholder;
    textField.font = font;
    return textField;
}

@end
