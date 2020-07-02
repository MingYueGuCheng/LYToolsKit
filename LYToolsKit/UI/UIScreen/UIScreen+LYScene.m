//
//  UIScene+LYScene.m
//  LYUI
//
//  Created by 似水灵修 on 2020/7/2.
//  Copyright © 2020 LY. All rights reserved.
//

#import "UIScreen+LYScene.h"
#import "UIDevice+LYHardware.h"

static CGFloat const kNavigationBarHeight_t = 44.0;
static CGFloat const kStatusBarHeight_t = 20.0;
static CGFloat const kStatusBarHeight_iPhoneX_t = 44.0;
static CGFloat const kTabBarHeight_t = 49.0;

static CGFloat navigationBarHeight_t = 0.0;
static CGFloat statusBarHeight_t = 0.0;
static CGFloat tabBarHeight_t = 0.0;

@implementation UIScreen (LYScene)

+ (CGFloat)ly_navigationBarHeight {
    if (navigationBarHeight_t < 1) {
        navigationBarHeight_t = kNavigationBarHeight_t;
    }
    return navigationBarHeight_t;
}

+ (CGFloat)ly_statusBarHeight {
    if (statusBarHeight_t < 1) {
        if ([UIDevice ly_hasFringeScreen]) {
            statusBarHeight_t = kStatusBarHeight_iPhoneX_t;
        } else {
            statusBarHeight_t = kStatusBarHeight_t;
        }
    }
    return statusBarHeight_t;
}

+ (CGFloat)ly_tabBarHeight {
    if (tabBarHeight_t < 1) {
        if ([UIDevice ly_hasFringeScreen]) {
            tabBarHeight_t = kTabBarHeight_t + 34.0;
        } else {
            tabBarHeight_t = kTabBarHeight_t;
        }
    }
    return tabBarHeight_t;
}

@end
