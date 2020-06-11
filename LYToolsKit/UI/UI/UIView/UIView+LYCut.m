//
//  UIView+LY.m
//  shuaidanbao
//
//  Created by 似水灵修 on 15/12/28.
//  Copyright © 2015年 sdb. All rights reserved.
//

#import "UIView+LYCut.h"

@implementation UIView (LYCut)

- (instancetype)ly_cutWithCornerRadius:(CGFloat)radius rectCorner:(UIRectCorner)rectCorner {
    UIBezierPath *maskPath = [UIBezierPath bezierPathWithRoundedRect:self.bounds byRoundingCorners:rectCorner cornerRadii:CGSizeMake(radius, radius)];
    CAShapeLayer *maskLayer = [[CAShapeLayer alloc] init];
    maskLayer.frame = self.bounds;
    maskLayer.path = maskPath.CGPath;
    self.layer.mask = maskLayer;
    return self;
}

@end

@implementation UIView (LYScreenshot)

/** 视图截屏 */
- (UIImage *)ly_captureScreenshot {
    //开启位图图形上下文
    UIGraphicsBeginImageContextWithOptions(self.frame.size, NO, 0.0);
    //屏幕截屏
    [self.layer renderInContext:UIGraphicsGetCurrentContext()];
    //取图
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    //结束上下文
    UIGraphicsEndImageContext();
    return image;
}

@end
