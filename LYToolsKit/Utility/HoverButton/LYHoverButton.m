//
//  LYHoverButton.m
//  LY
//
//  Created by 似水灵修 on 2017/12/1.
//  Copyright © 2017年 LY. All rights reserved.
//

#import "LYHoverButton.h"

@interface LYHoverButton ()

@property (nonatomic, strong) UIPanGestureRecognizer *pan;

@end

@implementation LYHoverButton

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        [self setupUI];
    }
    return self;
}

- (void)setupUI {
    self.autoAdhereBorder = YES;
    self.autoTransparent = YES;
    self.showsTouchWhenHighlighted = true;
    
    self.pan = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(pan:)];
    [self addGestureRecognizer:self.pan];
}

- (void)pan:(UIPanGestureRecognizer *)gesture {
    UIView *touchView = gesture.view;
    if (!touchView) {
        return;
    }
    
    UIView *touchSuperView = touchView.superview;
    if (!touchSuperView) {
        return;
    }
    self.alpha = 1.0;
    
    CGFloat kWidth = touchSuperView.bounds.size.width;
    CGFloat kHeight = touchSuperView.bounds.size.height;
    
    CGFloat touchViewHalfH = touchView.frame.size.height * 0.5;
    CGFloat touchViewHalfW = touchView.frame.size.width * 0.5;
    
    CGPoint point = [gesture translationInView:touchSuperView];
    
    CGFloat centerX = touchView.center.x + point.x;
    CGFloat centerY = touchView.center.y + point.y;
    //防止拽出视图区域
    if (centerX - (touchViewHalfW + self.showEdgeInsets.left) < 0) {
        centerX = touchViewHalfW + self.showEdgeInsets.left;
    }
    if (centerX + (touchViewHalfW + self.showEdgeInsets.right) > kWidth) {
        centerX = kWidth - (touchViewHalfW + self.showEdgeInsets.right);
    }
    if (centerY - (touchViewHalfH + self.showEdgeInsets.top) < 0) {
        centerY = touchViewHalfH + self.showEdgeInsets.top;
    }
    if (centerY + (touchViewHalfH + self.showEdgeInsets.bottom) > kHeight) {
        centerY = kHeight - (touchViewHalfH + self.showEdgeInsets.bottom);
    }
    
    if (self.autoAdhereBorder && (gesture.state == UIGestureRecognizerStateEnded || gesture.state == UIGestureRecognizerStateCancelled)) {
        if ((centerX - kWidth * 0.5) <= 0) {
            centerX = touchViewHalfW + self.showEdgeInsets.left;
        }
        if ((centerX + kWidth * 0.5) > kWidth) {
            centerX = kWidth - (touchViewHalfW + self.showEdgeInsets.right);
        }
        [UIView animateWithDuration:0.5 delay:0.0 options:UIViewAnimationOptionCurveEaseOut animations:^{
            touchView.center = CGPointMake(centerX, centerY);
        } completion:^(BOOL finished) {
            [gesture setTranslation:CGPointZero inView:touchSuperView];
            [self autoTransparentView];
        }];
    } else {
        touchView.center = CGPointMake(centerX, centerY);
        [gesture setTranslation:CGPointZero inView:touchSuperView];
    }
}

- (void)autoTransparentView {
    if (self.autoTransparent) {
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            [UIView animateWithDuration:0.5 animations:^{
                self.alpha = 0.5;
            }];
        });
    }
}

@end
