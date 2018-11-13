//
//  UIView+LYEnlargeTouchArea.m
//  LYUI
//
//  Created by ly on 2018/1/12.
//

#import "UIView+LYEnlargeTouchArea.h"
#import <objc/runtime.h>

@implementation UIView (LYEnlargeTouchArea)

static char topKey;
static char rightKey;
static char bottomKey;
static char leftKey;

- (void)ly_enlargeEdgeWithTop:(CGFloat)top left:(CGFloat)left bottom:(CGFloat)bottom right:(CGFloat)right {
    objc_setAssociatedObject(self, &topKey, [NSNumber numberWithFloat:top], OBJC_ASSOCIATION_COPY_NONATOMIC);
    objc_setAssociatedObject(self, &rightKey, [NSNumber numberWithFloat:right], OBJC_ASSOCIATION_COPY_NONATOMIC);
    objc_setAssociatedObject(self, &bottomKey, [NSNumber numberWithFloat:bottom], OBJC_ASSOCIATION_COPY_NONATOMIC);
    objc_setAssociatedObject(self, &leftKey, [NSNumber numberWithFloat:left], OBJC_ASSOCIATION_COPY_NONATOMIC);
}

- (CGRect)enlargedRect {
    CGFloat top = [objc_getAssociatedObject(self, &topKey) floatValue];
    CGFloat right = [objc_getAssociatedObject(self, &rightKey) floatValue];
    CGFloat bottom = [objc_getAssociatedObject(self, &bottomKey) floatValue];
    CGFloat left = [objc_getAssociatedObject(self, &leftKey) floatValue];
    UIEdgeInsets edge = UIEdgeInsetsMake(top, left, bottom, right);
    
    if (UIEdgeInsetsEqualToEdgeInsets(edge, UIEdgeInsetsZero)) {
        return self.bounds;
    } else {
        return CGRectMake(CGRectGetMinX(self.bounds) + edge.left,
                          CGRectGetMinY(self.bounds) + edge.top,
                          self.bounds.size.width - (edge.left + edge.right),
                          self.bounds.size.height - (edge.top + edge.bottom));
    }
}

- (BOOL)pointInside:(CGPoint)point withEvent:(UIEvent*)event {
    return CGRectContainsPoint([self enlargedRect], point);
}

@end
