//
//  LYCountingLabel.m
//  shuaidanbao
//
//  Created by 似水灵修 on 15/10/20.
//  Copyright © 2015年 sdb. All rights reserved.
//

#import "LYCountingLabel.h"

#pragma mark - LYLabelCounter

static CGFloat kLabelCounterRate = 3.0;

@protocol LYLabelCounter<NSObject>

-(CGFloat)update:(CGFloat)t;

@end

@interface LYLabelCounterLinear : NSObject<LYLabelCounter>

@end

@interface LYLabelCounterEaseIn : NSObject<LYLabelCounter>

@end

@interface LYLabelCounterEaseOut : NSObject<LYLabelCounter>

@end

@interface LYLabelCounterEaseInOut : NSObject<LYLabelCounter>

@end

@implementation LYLabelCounterLinear

-(CGFloat)update:(CGFloat)t
{
    return t;
}

@end

@implementation LYLabelCounterEaseIn

-(CGFloat)update:(CGFloat)t
{
    return powf(t, kLabelCounterRate);
}

@end

@implementation LYLabelCounterEaseOut

-(CGFloat)update:(CGFloat)t{
    return 1.0-powf((1.0-t), kLabelCounterRate);
}

@end

@implementation LYLabelCounterEaseInOut

-(CGFloat) update: (CGFloat) t
{
	int sign =1;
	int r = (int) kLabelCounterRate;
	if (r % 2 == 0)
		sign = -1;
	t *= 2;
	if (t < 1)
		return 0.5f * powf(t, kLabelCounterRate);
	else
		return sign * 0.5f * (powf(t-2, kLabelCounterRate) + sign * 2);
}

@end

#pragma mark - LYCountingLabel

@interface LYCountingLabel ()

@property CGFloat startingValue;
@property CGFloat destinationValue;
@property NSTimeInterval progress;
@property NSTimeInterval lastUpdate;
@property NSTimeInterval totalTime;
@property CGFloat easingRate;

@property (nonatomic, strong) CADisplayLink *timer;
@property (nonatomic, strong) id<LYLabelCounter> counter;

@end

@implementation LYCountingLabel

-(void)countFrom:(CGFloat)value to:(CGFloat)endValue {
    if (self.animationDuration == 0.0f) {
        self.animationDuration = 2.0f;
    }
    
    [self countFrom:value to:endValue withDuration:self.animationDuration];
}

-(void)countFrom:(CGFloat)startValue to:(CGFloat)endValue withDuration:(NSTimeInterval)duration {
    self.startingValue = startValue;
    self.destinationValue = endValue;
    
    // remove any (possible) old timers
    [self.timer invalidate];
    self.timer = nil;
    
    if (duration == 0.0) {
        // No animation
        [self setTextValue:endValue];
        [self runCompletionBlock];
        return;
    }

    self.easingRate = 3.0f;
    self.progress = 0;
    self.totalTime = duration;
    self.lastUpdate = [NSDate timeIntervalSinceReferenceDate];

    if(self.format == nil)
        self.format = @"%d";

    switch(self.method) {
        case LYLabelCountingMethodLinear:
            self.counter = [[LYLabelCounterLinear alloc] init];
            break;
        case LYLabelCountingMethodEaseIn:
            self.counter = [[LYLabelCounterEaseIn alloc] init];
            break;
        case LYLabelCountingMethodEaseOut:
            self.counter = [[LYLabelCounterEaseOut alloc] init];
            break;
        case LYLabelCountingMethodEaseInOut:
            self.counter = [[LYLabelCounterEaseInOut alloc] init];
            break;
    }

    CADisplayLink *timer = [CADisplayLink displayLinkWithTarget:self selector:@selector(updateValue:)];
    timer.frameInterval = 2;
    [timer addToRunLoop:[NSRunLoop mainRunLoop] forMode:NSDefaultRunLoopMode];
    [timer addToRunLoop:[NSRunLoop mainRunLoop] forMode:UITrackingRunLoopMode];
    self.timer = timer;
}

- (void)countFromCurrentValueTo:(CGFloat)endValue {
    [self countFrom:[self currentValue] to:endValue];
}

- (void)countFromCurrentValueTo:(CGFloat)endValue withDuration:(NSTimeInterval)duration {
    [self countFrom:[self currentValue] to:endValue withDuration:duration];
}

- (void)countFromZeroTo:(CGFloat)endValue {
    [self countFrom:0.0f to:endValue];
}

- (void)countFromZeroTo:(CGFloat)endValue withDuration:(NSTimeInterval)duration {
    [self countFrom:0.0f to:endValue withDuration:duration];
}

- (void)updateValue:(NSTimer *)timer {
    // update progress
    NSTimeInterval now = [NSDate timeIntervalSinceReferenceDate];
    self.progress += now - self.lastUpdate;
    self.lastUpdate = now;
    
    if (self.progress >= self.totalTime) {
        [self.timer invalidate];
        self.timer = nil;
        self.progress = self.totalTime;
    }
    
    [self setTextValue:[self currentValue]];
    
    if (self.progress == self.totalTime) {
        [self runCompletionBlock];
    }
}

- (void)setTextValue:(CGFloat)value {
    if (self.attributedFormatBlock != nil) {
        self.attributedText = self.attributedFormatBlock(value);
    } else if(self.formatBlock != nil) {
        self.text = self.formatBlock(value);
    } else {
        // check if counting with ints - cast to int
        if([self.format rangeOfString:@"%(.*)d" options:NSRegularExpressionSearch].location != NSNotFound || [self.format rangeOfString:@"%(.*)i"].location != NSNotFound) {
            self.text = [NSString stringWithFormat:self.format, (int)value];
        } else {
            self.text = [NSString stringWithFormat:self.format, value];
        }
    }
}

- (void)setFormat:(NSString *)format {
    _format = format;
    // update label with new format
    [self setTextValue:self.currentValue];
}

- (void)runCompletionBlock {
    if (self.completionBlock) {
        self.completionBlock();
        self.completionBlock = nil;
    }
}

- (CGFloat)currentValue {
    if (self.progress >= self.totalTime) {
        return self.destinationValue;
    }
    
    CGFloat percent = self.progress / self.totalTime;
    CGFloat updateVal = [self.counter update:percent];
    return self.startingValue + (updateVal * (self.destinationValue - self.startingValue));
}

@end
