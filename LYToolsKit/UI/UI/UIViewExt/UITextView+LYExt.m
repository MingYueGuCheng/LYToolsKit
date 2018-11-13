//
//  UITextView+LYExt.m
//  LYUI
//
//  Created by 吴浪 on 16/7/5.
//  Copyright © 2016年 LY. All rights reserved.
//

#import "UITextView+LYExt.h"

@implementation UITextView (LYExt)

+ (instancetype)ly_TextViewWithText:(NSString *)text font:(UIFont *)font textColor:(UIColor *)textColor delegate:(id<UITextViewDelegate>)delegate {
    UITextView *textView = [[self alloc] init];
    textView.text = text;
    textView.textColor = textColor;
    textView.delegate = delegate;
    textView.font = font;
    return textView;
}

@end
