//
//  UIButton+LYDelay.h
//  LYUI
//
//  Created by 吴浪 on 2018/11/8.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface UIButton (LYDelay)

@property (nonatomic, assign) NSTimeInterval ly_clickTimeInterval;/**< 点击时间间隔，默认：0.5s */
@property (nonatomic, assign) BOOL ly_enabledClickInterval;/**< 启用点击间隔，默认：NO */

@end

NS_ASSUME_NONNULL_END
