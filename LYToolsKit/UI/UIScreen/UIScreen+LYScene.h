//
//  UIScene+LYScene.h
//  LYUI
//
//  Created by 似水灵修 on 2020/7/2.
//  Copyright © 2020 LY. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface UIScreen (LYScene)

@property (nonatomic, assign, readonly, class) CGFloat ly_navigationBarHeight;
@property (nonatomic, assign, readonly, class) CGFloat ly_statusBarHeight;
@property (nonatomic, assign, readonly, class) CGFloat ly_tabBarHeight;

@end

NS_ASSUME_NONNULL_END
