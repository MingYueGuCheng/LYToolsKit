//
//  NSString+LYJudge.h
//  LYToolsKit
//
//  Created by 似水灵修 on 2018/11/12.
//

@import Foundation;

NS_ASSUME_NONNULL_BEGIN

@interface NSString (LYJudge)

/// 整型
- (BOOL)ly_isPureInt;

/// 浮点型
- (BOOL)ly_isPureFloat;

@end

NS_ASSUME_NONNULL_END
