//
//  NSString+LYJudge.m
//  LYToolsKit
//
//  Created by 似水灵修 on 2018/11/12.
//

#import "NSString+LYJudge.h"

@implementation NSString (LYJudge)

- (BOOL)ly_isPureInt {
    NSScanner *scan = [NSScanner scannerWithString:self];
    scan.charactersToBeSkipped = nil;
    int val;
    return ([scan scanInt:&val] && [scan isAtEnd]);
}

- (BOOL)ly_isPureFloat {
    NSScanner *scan = [NSScanner scannerWithString:self];
    scan.charactersToBeSkipped = nil;
    float val;
    return ([scan scanFloat:&val] && [scan isAtEnd]);
}

@end
