//
//  NSObject+LYHook.m
//  LYFoundation
//
//  Created by LY on 2017/10/18.
//  Copyright © 2017年 LY. All rights reserved.
//

#import "NSObject+LYHook.h"
@import ObjectiveC.runtime;

@implementation NSObject (LYHook)

/**
 *  用 block 重写某个 class 的指定方法
 *  @param targetClass 要重写的 class
 *  @param targetSelector 要重写的 class 里的实例方法，注意如果该方法不存在于 targetClass 里，则什么都不做
 *  @param implementBlock 该 block 必须返回一个 block，返回的 block 将被当成 targetSelector 的新实现，所以要在内部自己处理对 super 的调用，以及对当前调用方法的 self 的 class 的保护判断（因为如果 targetClass 的 targetSelector 是继承自父类的，targetClass 内部并没有重写这个方法，则我们这个函数最终重写的其实是父类的 targetSelector，所以会产生预期之外的 class 的影响，例如 targetClass 传进来  UIButton.class，则最终可能会影响到 UIView.class），implementationBlock 的参数里第一个为你要修改的 class，也即等同于 targetClass，第二个参数为你要修改的 selector，也即等同于 targetSelector，第三个参数是 targetSelector 原本的实现，由于 IMP 可以直接当成 C 函数调用，所以可利用它来实现“调用 super”的效果，但由于 targetSelector 的参数个数、参数类型、返回值类型，都会影响 IMP 的调用写法，所以这个调用只能由业务自己写。
 */
CG_INLINE BOOL overrideImplement(Class targetClass, SEL targetSelector, BOOL isClassMethod, id(^implementBlock)(Class originClass, SEL originSEL, IMP originIMP)) {
    Method originMethod;
    if (isClassMethod) {
        originMethod = class_getClassMethod(targetClass, targetSelector);
    } else {
        originMethod = class_getInstanceMethod(targetClass, targetSelector);
    }
    if (!originMethod || !implementBlock) {
        return NO;
    }
    IMP originIMP = method_getImplementation(originMethod);
    method_setImplementation(originMethod, imp_implementationWithBlock(implementBlock(targetClass, targetSelector, originIMP)));
    return YES;
}

+ (BOOL)ly_overrideImplement:(SEL)targetSEL block:(id  _Nonnull (^)(Class  _Nonnull __unsafe_unretained, SEL _Nonnull, IMP _Nonnull))block {
    return overrideImplement(self, targetSEL, YES, block);
}

- (BOOL)ly_overrideImplement:(SEL)targetSEL block:(id  _Nonnull (^)(Class  _Nonnull __unsafe_unretained, SEL _Nonnull, IMP _Nonnull))block {
    return overrideImplement(self.class, targetSEL, NO, block);
}


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
