//
//  LYViewController.m
//  LYToolsKit
//
//  Created by yyly on 11/13/2018.
//  Copyright (c) 2018 yyly. All rights reserved.
//

#import "LYViewController.h"
#import <LYToolsKit/LYToolsKit.h>

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
}

- (void)btnClick {
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
