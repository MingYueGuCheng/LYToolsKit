//
//  UIView+LYTouch.m
//  LYUI
//
//  Created by 似水灵修 on 2018/11/8.
//

#import "UIView+LYTouch.h"
#import <objc/runtime.h>

static NSString *const kSingleTap = @"singleTap";

@implementation UIView (LYTouch)

- (void)ly_singleTapped:(LYSingleTappedActionBlock)block {
    [self ly_singleTappedGesture:nil block:block];
}

- (void)ly_singleTappedGesture:(LYSingleTappedGestureConfig)config block:(LYSingleTappedActionBlock)block {
    UITapGestureRecognizer *tapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(ly_singleTap:)];
    if (config) {
        config(tapGesture);
    }
    [self addGestureRecognizer:tapGesture];
    
    objc_setAssociatedObject(self, (__bridge const void * _Nonnull)(kSingleTap), [block copy], OBJC_ASSOCIATION_COPY_NONATOMIC);
    self.userInteractionEnabled = YES;
}

- (void)ly_singleTap:(UITapGestureRecognizer *)tap {
    LYSingleTappedActionBlock block = objc_getAssociatedObject(self, (__bridge const void * _Nonnull)(kSingleTap));
    if (block) {
        block(self);
    }
}

@end
