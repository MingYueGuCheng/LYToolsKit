//
//  LYCoverView.h
//  LYUI
//
//  Created by 吴浪 on 16/6/7.
//  Copyright © 2016年 LY. All rights reserved.
//  遮罩层

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface LYCoverView : UIView

/** 遮罩层

 @param view 需要被展示的视图,默认:居中,可通过Masonry修改位置
 @param inView view展示在inView中
 @return 遮罩层
 */
+ (instancetype)showView:(UIView *)view inView:(UIView *)inView;
/** 取消遮罩层 */
- (void)disMiss;

@property (nonatomic, strong) UIColor *coverColor; /**< 遮罩层颜色 */
@property (nonatomic, assign) BOOL touchDisMiss; /**< 触摸阴影层消失,默认=YES */
@property (nonatomic, copy) void (^touchDidDisMiss)(void); /**< touchDisMiss=YES 时有效 */

@end

NS_ASSUME_NONNULL_END
