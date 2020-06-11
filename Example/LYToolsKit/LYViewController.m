//
//  LYViewController.m
//  LYToolsKit
//
//  Created by yyly on 11/13/2018.
//  Copyright (c) 2018 yyly. All rights reserved.
//

#import "LYViewController.h"
#import <LYToolsKit/LYToolsKit.h>
@import ObjectiveC.runtime;

typedef void(^Blick)(void);

@interface LYViewController ()
@property (nonatomic, strong) UIButton *linkBtn;
@property (nonatomic, strong) UILabel *countLabel;
@end

@implementation LYViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    NSString *str = [[NSDate date] ly_currentTimeString];
    
    UIBarButtonItem *btn = [UIBarButtonItem ly_itemWithNormalImageName:@"消息中心-系统" highImageName:@"消息中心-系统" target:self action:@selector(btnClick)];
    self.navigationItem.rightBarButtonItem = btn;

    UIImage *image = [UIImage ly_theLaunchImage];
//    // Do any additional setup after loading the view, typically from a nib.
    LYHyperlinksButton *btn1 = [LYHyperlinksButton ly_viewWithColor:[UIColor redColor]];
    [btn1 setTitle:@"啧啧啧" forState:UIControlStateNormal];
    [self.view addSubview:btn1];
    self.linkBtn = btn1;

    [self.class ly_overrideImplement:@selector(setName:) block:^id _Nonnull(Class  _Nonnull __unsafe_unretained originClass, SEL  _Nonnull originSEL, IMP  _Nonnull originIMP) {
        return ^(id obj, NSString *name) {
            self.title = name;
        };
    }];
    
    LYCountingLabel *countLabel = [[LYCountingLabel alloc] init];
    [self.view addSubview:countLabel];
    self.countLabel = countLabel;
    
//    [self ly_hookOrigMethod:@selector(btnClick) newMethod:meth];
//    [self ly_hookOrigMethod:@selector(btnClick) newMethod:@selector(my_btnClick1:)];
}

- (void)viewDidLayoutSubviews {
    [super viewDidLayoutSubviews];
    self.linkBtn.frame = CGRectMake(30, 100, 100, 40);
    self.countLabel.frame = CGRectMake(30, 150, 100, 40);
}

- (void)btnClick {
    [self.class setName:@"测试"];
}

+ (void)setName:(NSString *)name {
}

- (void)my_btnClick:(id)btn {
    [self my_btnClick:btn];
}

- (void)my_btnClick1:(id)btn {
    [self my_btnClick1:btn];
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
