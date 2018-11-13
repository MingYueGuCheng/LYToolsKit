//
//  NSObject+LYHook.m
//  LYFoundation
//
//  Created by LY on 2017/10/18.
//  Copyright © 2017年 LY. All rights reserved.
//

#import "NSObject+LYHook.h"
#import <objc/runtime.h>

@implementation NSObject (LYHook)

+ (BOOL)ly_hookOrigMethod:(SEL)origSEL newMethod:(SEL)newSEL {
    Method originalMethod = class_getClassMethod(self, origSEL);
    Method swizzledMethod = class_getClassMethod(self, newSEL);
    
    if (!originalMethod || !swizzledMethod) {
        return NO;
    }
    
    BOOL didAddMethod = class_addMethod(self, origSEL, method_getImplementation(swizzledMethod), method_getTypeEncoding(swizzledMethod));
    
    if (didAddMethod) {
        class_replaceMethod(self, newSEL, method_getImplementation(originalMethod), method_getTypeEncoding(originalMethod));
    } else {
        method_exchangeImplementations(originalMethod, swizzledMethod);
    }
    return YES;
}

- (BOOL)ly_hookOrigMethod:(SEL)origSEL newMethod:(SEL)newSEL {
    Method originalMethod = class_getInstanceMethod(self.class, origSEL);
    Method swizzledMethod = class_getInstanceMethod(self.class, newSEL);
    
    if (!originalMethod || !swizzledMethod) {
        return NO;
    }

    BOOL didAddMethod = class_addMethod(self.class, origSEL, method_getImplementation(swizzledMethod), method_getTypeEncoding(swizzledMethod));
    
    if (didAddMethod) {
        class_replaceMethod(self.class, newSEL, method_getImplementation(originalMethod), method_getTypeEncoding(originalMethod));
    } else {
        method_exchangeImplementations(originalMethod, swizzledMethod);
    }
    return YES;
}

@end
