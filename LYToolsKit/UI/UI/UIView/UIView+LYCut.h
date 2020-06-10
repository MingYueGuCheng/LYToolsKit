//
//  UIView+LYCut.h
//  shuaidanbao
//
//  Created by 似水灵修 on 15/12/28.
//  Copyright © 2015年 sdb. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface UIView (LYCut)

/** 裁剪View的某几个角 */
- (instancetype)ly_cutWithCornerRadius:(CGFloat)radius rectCorner:(UIRectCorner)rectCorner;

@end


@interface UIView (LYScreenshot)

/** 视图截屏 */
- (UIImage *)ly_captureScreenshot;

@end

NS_ASSUME_NONNULL_END
