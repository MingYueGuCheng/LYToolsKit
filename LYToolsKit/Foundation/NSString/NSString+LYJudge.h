//
//  NSString+LYJudge.h
//  LYToolsKit
//
//  Created by 似水灵修 on 2018/11/12.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface NSString (LYJudge)

/** 判断整形 */
- (BOOL)ly_isPureInt;
/** 判断浮点形 */
- (BOOL)ly_isPureFloat;

@end

NS_ASSUME_NONNULL_END
