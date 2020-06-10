//
//  UIColor+LYHex.h
//  LYUI
//
//  Created by 似水灵修 on 16/5/12.
//  Copyright © 2016年 dingli. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface UIColor (LYString)

@property (nonatomic, readonly) CGColorSpaceModel ly_spaceModel;
@property (nonatomic, readonly, getter=isLy_canProvideRGBComponents) BOOL ly_canProvideRGBComponents;
@property (nonatomic, readonly) CGFloat ly_red; // Only valid if canProvideRGBComponents is YES
@property (nonatomic, readonly) CGFloat ly_green; // Only valid if canProvideRGBComponents is YES
@property (nonatomic, readonly) CGFloat ly_blue; // Only valid if canProvideRGBComponents is YES
@property (nonatomic, readonly) CGFloat ly_white; // Only valid if colorSpaceModel == kCGColorSpaceModelMonochrome
@property (nonatomic, readonly) CGFloat ly_alpha;
@property (nonatomic, readonly) UInt32 ly_rgbHex;

/** {r, g, b, a} */
- (NSString *)ly_stringFromColor;
/** 16进制值 */
- (NSString *)ly_hexStringFromColor;

@end


@interface UIColor (LYHex)

/** 将16进制颜色值如#000000转换成UIColor */
+ (instancetype)ly_colorWithHexString:(NSString *)hex;
+ (instancetype)ly_colorWithHexString:(NSString *)hex alpha:(CGFloat)alpha;

@end

NS_ASSUME_NONNULL_END
