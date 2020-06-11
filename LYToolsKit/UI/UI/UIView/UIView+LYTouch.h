//
//  UIView+LYTouch.h
//  LYUI
//
//  Created by 似水灵修 on 2018/11/8.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

typedef void(^LYTapActionBlock)(__kindof UIView *view);
typedef void(^LYTapGestureConfig)(UITapGestureRecognizer *tap);

@interface UIView (LYTouch)

- (void)ly_singleTap:(LYTapActionBlock)block;
- (void)ly_tap:(LYTapGestureConfig)config block:(LYTapActionBlock)block;

@end

NS_ASSUME_NONNULL_END
