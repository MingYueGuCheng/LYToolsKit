//
//  LYTouchTrace.h
//
//  茗玥古城
//
//  Created by 似水灵修 on 13-11-11.
//  Copyright (c) 2013年 MingYueGuCheng. All rights reserved.
//  显示操作轴迹

/**
 * 使用方法
 * 1、在int main(int argc, char * argv[])方法里添加如下：
     return UIApplicationMain(argc, argv, NSStringFromClass([LYTouchTrace class]), NSStringFromClass([AppDelegate class]));
 * 2、在- (BOOL)application: didFinishLaunchingWithOptions:方法里添加如下：
     LYTouchTrace *touchApplication = (LYTouchTrace *)application;
     touchApplication.alwaysShowTouches = YES;
 *
 */

#import <UIKit/UIKit.h>

@interface LYTouchTrace : UIApplication
@property (nonatomic, assign) CGFloat touchHue;
@property (nonatomic, assign) BOOL showTouches;
@property (nonatomic, assign) BOOL alwaysShowTouches; /**< 默认YES */
@property (nonatomic, assign) BOOL showTouchesWhenKeyboardShown;
@property (nonatomic, copy) NSString *touchImageName;

@end
