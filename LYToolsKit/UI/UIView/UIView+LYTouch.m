//
//  UIView+LYTouch.m
//  LYUI
//
//  Created by 似水灵修 on 2018/11/8.
//

#import "UIView+LYTouch.h"
@import ObjectiveC.runtime;

static NSString *const kSingleTap = @"singleTap";

@implementation UIView (LYTouch)

- (void)ly_singleTap:(LYTapActionBlock)block {
    [self ly_tapGestureConfig:nil block:block];
}

- (void)ly_tap:(LYTapGestureConfig)config block:(LYTapActionBlock)block {
    [self ly_tapGestureConfig:config block:block];
}

- (void)ly_tapGestureConfig:(LYTapGestureConfig)config block:(LYTapActionBlock)block {
    UITapGestureRecognizer *tapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(ly_singleTapAction:)];
    if (config) {
        config(tapGesture);
    }
    [self addGestureRecognizer:tapGesture];
    
    objc_setAssociatedObject(self, (__bridge const void * _Nonnull)(kSingleTap), [block copy], OBJC_ASSOCIATION_COPY_NONATOMIC);
    self.userInteractionEnabled = YES;
}

- (void)ly_singleTapAction:(UITapGestureRecognizer *)tap {
    LYTapActionBlock block = objc_getAssociatedObject(self, (__bridge const void * _Nonnull)(kSingleTap));
    if (block) {
        block(self);
    }
}

@end
