//
//  LYAlertController.h
//  LYUI
//
//  Created by 似水灵修 on 2017/3/17.
//  Copyright © 2017年 LY. All rights reserved.
//

#import <UIKit/UIKit.h>

/**
示例:self(UIViewController对象)
[self ly_showAlertWithTitle:@"温馨提示" message:@"使用实例" appearanceProcess:^(LYAlertController *alertMaker) {
    alertMaker
    .addActionCancelTitle(@"取消")
    .addActionDefaultTitle(@"确定");
} actionsBlock:^(NSInteger index, UIAlertAction *action, LYAlertController *alertMaker) {
    if (0 == index) {
        //取消
    } else if (1 == index) {
        //确定
    } else {
        //未知
    }
}];
*/

NS_ASSUME_NONNULL_BEGIN

@class LYAlertController;

/**
 alert按钮执行回调
 
 @param index 按钮index(根据添加action的顺序)
 @param action UIAlertAction对象
 @param alertMaker LYAlertController对象
 */
typedef void (^LYAlertActionBlock)(NSInteger index, UIAlertAction *action, LYAlertController *alertMaker);

/**
 alertAction 配置链
 
 @param title 标题
 @return LYAlertController对象
 */
typedef LYAlertController *_Nonnull(^LYAlertActionTitle)(NSString *title);

#pragma mark - I.LYAlertController
@interface LYAlertController : UIAlertController
/**
 *  设置toast模式展示时间：如果alert未添加任何按钮，将会以toast样式展开，这里设置展示时间，默认1.5s
 */
@property (nonatomic, assign) NSTimeInterval toastStyleDuration;
@property (nonatomic, copy) void (^toastStyleDidDismiss)(void); /** toastStyle关闭后 */
@property (nonatomic, assign) BOOL ly_alertAnimated; /** 弹框展示与消失动画，默认YES */
@property (nonatomic, copy) void (^alertDidShow)(void); /** alert弹出后 */
/**
 链式构造alert视图按钮，添加alertAction按钮，默认样式
 
 @return 链式 block
 */
- (LYAlertActionTitle)addActionDefaultTitle;

/**
 链式构造alert视图按钮，添加alertAction按钮，取消样式，（注意：一个alert只能添加一次该样式）
 
 @return 链式 block
 */
- (LYAlertActionTitle)addActionCancelTitle;

/**
 链式构造alert视图按钮，添加alertAction按钮，警告样式
 
 @return 链式 block
 */
- (LYAlertActionTitle)addActionDestructiveTitle;
@end

#pragma mark - II.LYAlertController扩展使用LYAlertController

/** alert构造
 
 @param alertMaker LYAlertController对象
 */
typedef void (^LYAlertAppearanceProcess)(LYAlertController *alertMaker);

@interface UIViewController (LYAlertController)

/** alert弹框
 
 @param title               title
 @param message             message
 @param appearanceProcess   alert配置过程
 @param actionsBlock        alert点击响应回调
 */
- (void)ly_showAlertWithTitle:(nullable NSString *)title
                      message:(nullable NSString *)message
            appearanceProcess:(nullable LYAlertAppearanceProcess)appearanceProcess
                 actionsBlock:(nullable LYAlertActionBlock)actionsBlock;
/** sheet弹框
 
 @param title               title
 @param message             message
 @param appearanceProcess   alert配置过程
 @param actionsBlock        alert点击响应回调
 */
- (void)ly_showSheetWithTitle:(nullable NSString *)title
                      message:(nullable NSString *)message
            appearanceProcess:(nullable LYAlertAppearanceProcess)appearanceProcess
                 actionsBlock:(nullable LYAlertActionBlock)actionsBlock;

@end

NS_ASSUME_NONNULL_END
