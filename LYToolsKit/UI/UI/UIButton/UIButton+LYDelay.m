//
//  UIButton+LYDelay.m
//  LYUI
//
//  Created by 似水灵修 on 2018/11/8.
//

#import "UIButton+LYDelay.h"
#import <objc/runtime.h>

static NSTimeInterval const kDefaultClickTimeInterval = 0.5; /** 按钮默认点击时间间隔 */
static NSString *const kClickTimeInterval = @"clickTimeInterval";
static NSString *const kIsIgnoreEvent = @"isIgnoreEvent";
static NSString *const kEnabledClickInterval = @"enabledClickInterval";

@interface UIButton ()
@property (nonatomic, assign) BOOL isIgnoreEvent;
@end
@implementation UIButton (LYDelay)

- (void)setLy_clickTimeInterval:(NSTimeInterval)clickTimeInterval {
    objc_setAssociatedObject(self, (__bridge const void *)(kClickTimeInterval), @(clickTimeInterval), OBJC_ASSOCIATION_ASSIGN);
}

- (NSTimeInterval)ly_clickTimeInterval {
    NSTimeInterval durationTime = [objc_getAssociatedObject(self, (__bridge const void *)(kClickTimeInterval)) doubleValue];
    return durationTime > 0?: kDefaultClickTimeInterval;
}

- (void)setIsIgnoreEvent:(BOOL)isIgnoreEvent {
    objc_setAssociatedObject(self, (__bridge const void *)(kIsIgnoreEvent), @(isIgnoreEvent), OBJC_ASSOCIATION_ASSIGN);
}

- (BOOL)isIgnoreEvent {
    return [objc_getAssociatedObject(self, (__bridge const void *)(kIsIgnoreEvent)) boolValue];
}

- (void)setLy_enabledClickInterval:(BOOL)enabledClickInterval {
    objc_setAssociatedObject(self, (__bridge const void * _Nonnull)(kEnabledClickInterval), @(enabledClickInterval), OBJC_ASSOCIATION_ASSIGN);
}

- (BOOL)ly_enabledClickInterval {
    return [objc_getAssociatedObject(self, (__bridge const void * _Nonnull)(kEnabledClickInterval)) boolValue];
}

- (void)my_sendAction:(SEL)action to:(id)target forEvent:(UIEvent *)event {
    if (!self.ly_enabledClickInterval || [self filterSpecifiedButtonType:self]) {
        [self my_sendAction:action to:target forEvent:event];
    } else {
        if (self.isIgnoreEvent) {
            return;
        } else {
            self.isIgnoreEvent = YES;
            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(self.ly_clickTimeInterval * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                self.isIgnoreEvent = NO;
            });
            [self my_sendAction:action to:target forEvent:event];
        }
    }
}

- (BOOL)filterSpecifiedButtonType:(UIButton *)btn {
    NSArray<NSString *> *filterButtons = @[@"CAMFlipButton", @"CUShutterButton"];
    __block BOOL isFilter = NO;
    [filterButtons enumerateObjectsUsingBlock:^(NSString * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        Class cls = NSClassFromString(obj);
        if (cls && [obj isKindOfClass:cls]) {
            isFilter = YES;
            *stop = YES;
        }
    }];
    return isFilter;
}

+ (void)load {
    SEL originalSelector = @selector(sendAction:to:forEvent:);
    SEL swizzledSelector = @selector(my_sendAction:to:forEvent:);
    
    Method originalMethod = class_getInstanceMethod(self, originalSelector);
    Method swizzledMethod = class_getInstanceMethod(self, swizzledSelector);
    
    BOOL addMyMethod = class_addMethod(self, originalSelector, method_getImplementation(swizzledMethod), method_getTypeEncoding(swizzledMethod));
    if (addMyMethod) {
        class_replaceMethod(self, swizzledSelector, method_getImplementation(originalMethod), method_getTypeEncoding(originalMethod));
    } else {
        method_exchangeImplementations(originalMethod, swizzledMethod);
    }
}

@end
