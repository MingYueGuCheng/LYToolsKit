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
@property (nonatomic, strong) UIButton *hoverBtn;

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
//    countLabel.format = @"%d";
    countLabel.formatBlock = ^NSString *(CGFloat value) {
        return [self countNumAndChangeformat:(int)value];
    };
    [countLabel countFrom:100000 to:1 withDuration:20];
    [self.view addSubview:countLabel];
    self.countLabel = countLabel;
    
    LYHoverButton *hoverButton = [LYHoverButton buttonWithType:UIButtonTypeCustom];
    hoverButton.backgroundColor = UIColor.redColor;
    hoverButton.frame = CGRectMake(30, 200, 80, 40);
    [self.view addSubview:hoverButton];
    self.hoverBtn = hoverButton;
//    [self ly_hookOrigMethod:@selector(btnClick) newMethod:meth];
//    [self ly_hookOrigMethod:@selector(btnClick) newMethod:@selector(my_btnClick1:)];
}

- (NSString *)countNumAndChangeformat:(int)tmpNum {
    NSString *num = [NSString stringWithFormat:@"%d", tmpNum];
    
    int count = 0;
    long long int a = num.longLongValue;
    while (a != 0) {
        count++;
        a /= 10;
    }
    NSMutableString *string = [NSMutableString stringWithString:num];
    NSMutableString *newstring = [NSMutableString string];
    while (count > 3) {
        count -= 3;
        NSRange rang = NSMakeRange(string.length - 3, 3);
        NSString *str = [string substringWithRange:rang];
        [newstring insertString:str atIndex:0];
        [newstring insertString:@"," atIndex:0];
        [string deleteCharactersInRange:rang];
    }
    [newstring insertString:string atIndex:0];
    return newstring;
}

- (void)viewDidLayoutSubviews {
    [super viewDidLayoutSubviews];
    self.linkBtn.frame = CGRectMake(30, 100, 100, 40);
    self.countLabel.frame = CGRectMake(30, 150, 200, 40);
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
