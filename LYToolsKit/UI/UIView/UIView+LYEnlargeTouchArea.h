//
//  UIView+EnlargeTouchArea.h
//  LYUI
//
//  Created by ly on 2018/1/12.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface UIView (LYEnlargeTouchArea)

/** 扩展点击区域（正值缩小，负值扩大） */
- (void)ly_enlargeEdgeWithTop:(CGFloat)top left:(CGFloat)left bottom:(CGFloat)bottom right:(CGFloat)right;

@end

NS_ASSUME_NONNULL_END
