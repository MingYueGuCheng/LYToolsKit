//
//  UIView+LYTouch.h
//  LYUI
//
//  Created by 吴浪 on 2018/11/8.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

typedef void(^LYSingleTappedActionBlock)(UIView *view);
typedef void(^LYSingleTappedGestureConfig)(UITapGestureRecognizer *tap);

@interface UIView (LYTouch)

- (void)ly_singleTapped:(LYSingleTappedActionBlock)block;
- (void)ly_singleTappedGesture:(nullable LYSingleTappedGestureConfig)config block:(LYSingleTappedActionBlock)block;

@end

NS_ASSUME_NONNULL_END
