//
//  LYViewController.m
//  LYToolsKit
//
//  Created by yyly on 11/13/2018.
//  Copyright (c) 2018 yyly. All rights reserved.
//

#import "LYViewController.h"
#import <LYToolsKit/LYToolsKit.h>
#import <objc/runtime.h>

typedef void(^Blick)(void);

@interface LYViewController ()

@end

@implementation LYViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    UIBarButtonItem *btn = [UIBarButtonItem ly_itemWithNormalImageName:@"消息中心-系统" highImageName:@"消息中心-系统" target:self action:@selector(btnClick)];
    self.navigationItem.rightBarButtonItem = btn;

    // Do any additional setup after loading the view, typically from a nib.
    LYHyperlinksButton *btn1 = [LYHyperlinksButton ly_ViewWithColor:[UIColor redColor]];
    [btn1 setTitle:@"啧啧啧" forState:UIControlStateNormal];
    btn1.frame = CGRectMake(50, 100, 50, 50);
    [self.view addSubview:btn1];
    
    [self.class ly_OverrideImplement:@selector(setName:) block:^id _Nonnull(Class  _Nonnull __unsafe_unretained originClass, SEL  _Nonnull originSEL, IMP  _Nonnull originIMP) {
        return ^(id obj, NSString *name) {
            
        };
    }];
    
//    [self ly_hookOrigMethod:@selector(btnClick) newMethod:meth];
//    [self ly_hookOrigMethod:@selector(btnClick) newMethod:@selector(my_btnClick1:)];

}

- (void)btnClick {
    [self.class setName:@"测试"];
}

+ (void)setName:(NSString *)name {
//    [LYHyperlinksButton ]
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
