//
//  LYUIMacro.h
//  LYUI
//
//  Created by 似水灵修 on 2018/11/11.
//

#ifndef LYUIMacro_h
#define LYUIMacro_h

#ifdef __OBJC__

#pragma mark - System Component Size
#define kScreenBounds ([UIScreen mainScreen].bounds)
#define kScreenWidth  ([UIScreen mainScreen].bounds.size.width)
#define kScreenHeight ([UIScreen mainScreen].bounds.size.height)

#define kNavigationBarHeight (UIScreen.ly_navigationBarHeight)
#define kStatusBarHeight (UIScreen.ly_statusBarHeight)
#define kTabBarHeight (UIScreen.ly_tabBarHeight)


#endif

#endif /* LYUIMacro_h */
