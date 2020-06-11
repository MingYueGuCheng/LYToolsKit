//
//  LYSmallCache.m
//  GeiNiHua
//
//  Created by 似水灵修 on 2017/5/17.
//  Copyright © 2017年 LY. All rights reserved.
//

#import "LYSmallCache.h"

@interface LYSmallCache ()
@property (nonatomic, strong) NSCache *cache;

@end

@implementation LYSmallCache

+ (instancetype)shared {
    static id instance = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        instance = [[self alloc] init];
    });
    return instance;
}

+ (void)setObjc:(id)objc forKey:(NSString *)key {
    [[LYSmallCache shared].cache setObject:objc forKey:key];
}

- (NSCache *)cache {
    if (!_cache) {
        _cache = [[NSCache alloc] init];
        _cache.countLimit = 1000;
    }
    return _cache;
}

+ (id)objcForKey:(NSString *)key ofClass:(nullable Class)cls{
    id objc = [[LYSmallCache shared].cache objectForKey:key];
    if (cls != nil) {
        if ([objc isKindOfClass:cls]) {
        } else {
            objc ? [self removeObjcForKey:key] : nil;
            objc = nil;
        }
    } else {
    }
    return objc;
}

+ (id)fetchObjcForKey:(NSString *)key
              ofClass:(Class)cls
           failToFind:(LYSmallCacheFailToFind)failToFind {
    id objc = [LYSmallCache objcForKey:key ofClass:cls];
    if (!objc && failToFind) {
        objc = failToFind(cls, key);
        if (objc) {
            [LYSmallCache setObjc:objc forKey:key];
        } else {
            [LYSmallCache removeObjcForKey:key];
        }
    }
    return objc;
}

+ (void)removeObjcForKey:(NSString *const)key {
    [[LYSmallCache shared].cache removeObjectForKey:key];
}

+ (void)removeAllObjcs {
    [[LYSmallCache shared].cache removeAllObjects];
}

@end

