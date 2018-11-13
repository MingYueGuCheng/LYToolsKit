//
//  LYAlertController.m
//  LYUI
//
//  Created by 吴浪 on 2017/3/17.
//  Copyright © 2017年 LY. All rights reserved.
//

#import "LYAlertController.h"

static NSTimeInterval const kShowDurationDefault = 1.5f; //toast默认展示时间
#pragma mark - I.LYAlertActionModel

@interface LYAlertActionModel : NSObject
@property (nonatomic, copy) NSString *title;
@property (nonatomic, assign) UIAlertActionStyle style;
@end
@implementation LYAlertActionModel
- (instancetype)init {
    if (self = [super init]) {
        self.title = @"";
        self.style = UIAlertActionStyleDefault;
    }
    return self;
}
@end

/** 配置AlertAction */
typedef void (^LYAlertActionsConfig)(LYAlertActionBlock actionBlock);
@interface LYAlertController ()
@property (nonatomic, strong) NSMutableArray <LYAlertActionModel *>* ly_alertActionArray;
@end

@implementation LYAlertController

- (void)viewDidLoad {
    [super viewDidLoad];
}

+ (instancetype)ly_alertControllerWithTitle:(NSString *)title message:(NSString *)message preferredStyle:(UIAlertControllerStyle)preferredStyle {
    LYAlertController *alertAC = [self alertControllerWithTitle:title message:message preferredStyle:preferredStyle];
    alertAC.gnh_AlertAnimated = YES;
    alertAC.toastStyleDuration = kShowDurationDefault;
    return alertAC;
}

- (LYAlertActionTitle)addActionDefaultTitle {
    return ^(NSString *title) {
        LYAlertActionModel *model = [[LYAlertActionModel alloc] init];
        model.title = title;
        model.style = UIAlertActionStyleDefault;
        [self.ly_alertActionArray addObject:model];
        return self;
    };
}

- (LYAlertActionTitle)addActionCancelTitle {
    //该block返回值不是本类属性，只是局部变量，不会造成循环引用
    return ^(NSString *title) {
        LYAlertActionModel *model = [[LYAlertActionModel alloc] init];
        model.title = title;
        model.style = UIAlertActionStyleCancel;
        [self.ly_alertActionArray addObject:model];
        return self;
    };
}

- (LYAlertActionTitle)addActionDestructiveTitle {
    return ^(NSString *title) {
        LYAlertActionModel *model = [[LYAlertActionModel alloc] init];
        model.title = title;
        model.style = UIAlertActionStyleDestructive;
        [self.ly_alertActionArray addObject:model];
        return self;
    };
}

- (NSMutableArray<LYAlertActionModel *> *)ly_alertActionArray {
    if (_ly_alertActionArray == nil) {
        _ly_alertActionArray = [NSMutableArray array];
    }
    return _ly_alertActionArray;
}

- (LYAlertActionsConfig)alertActionsConfig {
    return  ^(LYAlertActionBlock actionBlock) {
        if (self.ly_alertActionArray.count > 0) {
            __weak typeof(self) weakself = self;
            [self.ly_alertActionArray enumerateObjectsUsingBlock:^(LYAlertActionModel * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
                if (obj.title) {
                    UIAlertAction *alertAction = [UIAlertAction actionWithTitle:obj.title style:obj.style handler:^(UIAlertAction * _Nonnull action) {
                        if (actionBlock) {
                            __strong typeof(weakself) strongSelf = weakself;
                            actionBlock(idx, action, strongSelf);
                        }
                    }];
                    [self addAction:alertAction];
                }
            }];
        } else {
            NSTimeInterval duration = self.toastStyleDuration;
            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(duration * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                [self dismissViewControllerAnimated:self.gnh_AlertAnimated completion:^{
                    if (self.toastStyleDidDismiss) {
                        self.toastStyleDidDismiss();
                    }
                }];
            });
        }
    };
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end

#pragma mark - III.LYAlertController扩展使用LYAlertController
@implementation UIViewController (LYAlertController)

- (void)ly_showPreferredStyle:(UIAlertControllerStyle)preferredStyle title:(NSString *)title message:(NSString *)message appearanceProcess:(LYAlertAppearanceProcess)appearanceProcess actionsBlock:(LYAlertActionBlock)actionsBlock {
    LYAlertController *alertAC = [LYAlertController ly_alertControllerWithTitle:title message:message preferredStyle:preferredStyle];

    //配置alert action
    if (appearanceProcess) {
        appearanceProcess(alertAC);
    }
    //配置action 响应
    alertAC.alertActionsConfig(actionsBlock);
    //弹出视图
    [self presentViewController:alertAC animated:alertAC.gnh_AlertAnimated completion:^{
        if (alertAC.alertDidShow) {
            alertAC.alertDidShow();
        }
    }];
}

- (void)ly_showAlertWithTitle:(NSString *)title message:(NSString *)message appearanceProcess:(LYAlertAppearanceProcess)appearanceProcess actionsBlock:(LYAlertActionBlock)actionsBlock {
    [self ly_showPreferredStyle:UIAlertControllerStyleAlert title:title message:message appearanceProcess:appearanceProcess actionsBlock:actionsBlock];
}

- (void)ly_showSheetWithTitle:(NSString *)title message:(NSString *)message appearanceProcess:(LYAlertAppearanceProcess)appearanceProcess actionsBlock:(LYAlertActionBlock)actionsBlock {
    [self ly_showPreferredStyle:UIAlertControllerStyleActionSheet title:title message:message appearanceProcess:appearanceProcess actionsBlock:actionsBlock];
}
@end
