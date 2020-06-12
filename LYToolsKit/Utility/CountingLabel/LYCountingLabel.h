//
//  LYCountingLabel.h
//  shuaidanbao
//
//  Created by 似水灵修 on 15/10/20.
//  Copyright © 2015年 sdb. All rights reserved.
//  倒计时按钮

@import Foundation;
@import UIKit;

typedef NS_ENUM(NSInteger, LYLabelCountingMethod) {
    LYLabelCountingMethodLinear,
    LYLabelCountingMethodEaseInOut,
    LYLabelCountingMethodEaseIn,
    LYLabelCountingMethodEaseOut,
};

typedef NSString* (^LYCountingLabelFormatBlock)(CGFloat value);
typedef NSAttributedString* (^LYCountingLabelAttributedFormatBlock)(CGFloat value);

@interface LYCountingLabel : UILabel

@property (nonatomic, strong) NSString *format;
@property (nonatomic, assign) LYLabelCountingMethod method;
@property (nonatomic, assign) NSTimeInterval animationDuration;

@property (nonatomic, copy) LYCountingLabelFormatBlock formatBlock;
@property (nonatomic, copy) LYCountingLabelAttributedFormatBlock attributedFormatBlock;
@property (nonatomic, copy) void (^completionBlock)(void);

-(void)countFrom:(CGFloat)startValue to:(CGFloat)endValue;
-(void)countFrom:(CGFloat)startValue to:(CGFloat)endValue withDuration:(NSTimeInterval)duration;

-(void)countFromCurrentValueTo:(CGFloat)endValue;
-(void)countFromCurrentValueTo:(CGFloat)endValue withDuration:(NSTimeInterval)duration;

-(void)countFromZeroTo:(CGFloat)endValue;
-(void)countFromZeroTo:(CGFloat)endValue withDuration:(NSTimeInterval)duration;

- (CGFloat)currentValue;

@end

