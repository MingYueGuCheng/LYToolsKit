//
//  UIButton+LYDelay.h
//  LYUI
//
//  Created by 似水灵修 on 2018/11/8.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface UIButton (LYDelay)

/// 点击间隔时长，默认：0.5s
@property (nonatomic, assign) NSTimeInterval ly_clickTimeInterval;
/// 激活点击间隔，默认：NO
@property (nonatomic, assign) BOOL ly_enabledClickInterval;

@end

NS_ASSUME_NONNULL_END
