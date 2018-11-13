//
//  UIColor+LYHex.m
//  LYUI
//
//  Created by 吴浪 on 16/5/12.
//  Copyright © 2016年 dingli. All rights reserved.
//

#import "UIColor+LYString.h"

@implementation UIColor (LYString)

- (CGColorSpaceModel)ly_spaceModel {
    return CGColorSpaceGetModel(CGColorGetColorSpace(self.CGColor));
}

- (BOOL)isLy_canProvideRGBComponents {
    switch (self.ly_spaceModel) {
        case kCGColorSpaceModelRGB:
        case kCGColorSpaceModelMonochrome:
            return YES;
        default:
            return NO;
    }
}

- (BOOL)ly_red:(CGFloat *)red green:(CGFloat *)green blue:(CGFloat *)blue alpha:(CGFloat *)alpha {
    const CGFloat *components = CGColorGetComponents(self.CGColor);
    
    CGFloat r,g,b,a;
    
    switch (self.ly_spaceModel) {
        case kCGColorSpaceModelMonochrome:
            r = g = b = components[0];
            a = components[1];
            break;
        case kCGColorSpaceModelRGB:
            r = components[0];
            g = components[1];
            b = components[2];
            a = components[3];
            break;
        default:    // We don't know how to handle this model
            return NO;
    }
    
    if (red) *red = r;
    if (green) *green = g;
    if (blue) *blue = b;
    if (alpha) *alpha = a;
    
    return YES;
}

- (CGFloat)ly_red {
    NSAssert(self.isLy_canProvideRGBComponents, @"Must be an RGB color to use -red");
    const CGFloat *c = CGColorGetComponents(self.CGColor);
    return c[0];
}

- (CGFloat)ly_green {
    NSAssert(self.isLy_canProvideRGBComponents, @"Must be an RGB color to use -green");
    const CGFloat *c = CGColorGetComponents(self.CGColor);
    if (self.ly_spaceModel == kCGColorSpaceModelMonochrome) return c[0];
    return c[1];
}

- (CGFloat)ly_blue {
    NSAssert(self.isLy_canProvideRGBComponents, @"Must be an RGB color to use -blue");
    const CGFloat *c = CGColorGetComponents(self.CGColor);
    if (self.ly_spaceModel == kCGColorSpaceModelMonochrome) return c[0];
    return c[2];
}

- (CGFloat)ly_white {
    NSAssert(self.ly_spaceModel == kCGColorSpaceModelMonochrome, @"Must be a Monochrome color to use -white");
    const CGFloat *c = CGColorGetComponents(self.CGColor);
    return c[0];
}

- (CGFloat)ly_alpha {
    return CGColorGetAlpha(self.CGColor);
}

- (UInt32)ly_rgbHex {
    NSAssert(self.isLy_canProvideRGBComponents, @"Must be a RGB color to use rgbHex");
    
    CGFloat r,g,b,a;
    if (![self ly_red:&r green:&g blue:&b alpha:&a]) return 0;
    
    r = MIN(MAX(self.ly_red, 0.0f), 1.0f);
    g = MIN(MAX(self.ly_green, 0.0f), 1.0f);
    b = MIN(MAX(self.ly_blue, 0.0f), 1.0f);
    
    return (((int)roundf(r * 255)) << 16)
    | (((int)roundf(g * 255)) << 8)
    | (((int)roundf(b * 255)));
}

- (NSString *)ly_stringFromColor {
    NSAssert(self.isLy_canProvideRGBComponents, @"Must be an RGB color to use -stringFromColor");
    NSString *result;
    switch (self.ly_spaceModel) {
        case kCGColorSpaceModelRGB:
            result = [NSString stringWithFormat:@"{%0.3f, %0.3f, %0.3f, %0.3f}", self.ly_red, self.ly_green, self.ly_blue, self.ly_alpha];
            break;
        case kCGColorSpaceModelMonochrome:
            result = [NSString stringWithFormat:@"{%0.3f, %0.3f}", self.ly_white, self.ly_alpha];
            break;
        default:
            result = nil;
    }
    return result;
}

- (NSString *)ly_hexStringFromColor {
    return [NSString stringWithFormat:@"%0.6lX", (long)self.ly_rgbHex];
}

@end

@implementation UIColor (LYHex)
+ (instancetype)ly_colorWithHexString:(NSString *)hex {
   return [self ly_colorWithHexString:hex alpha:1.0];
}

+ (instancetype)ly_colorWithHexString:(NSString *)hex alpha:(CGFloat)alpha {
    NSString *cString = [[hex stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]] uppercaseString];
    
    // String should be 6 or 8 characters
    if ([cString length] < 6) {
        return [UIColor clearColor];
    }
    // strip 0X if it appears
    if ([cString hasPrefix:@"0X"] || [cString hasPrefix:@"0x"]) {
        cString = [cString substringFromIndex:2];
    }
    if ([cString hasPrefix:@"#"]) {
        cString = [cString substringFromIndex:1];
    }
    if ([cString length] != 6) {
        return [UIColor clearColor];
    }
    // Separate into r, g, b substrings
    NSRange range;
    range.location = 0;
    range.length = 2;
    NSString *rString = [cString substringWithRange:range];
    
    range.location = 2;
    NSString *gString = [cString substringWithRange:range];
    
    range.location = 4;
    NSString *bString = [cString substringWithRange:range];
    
    // Scan values
    unsigned int r, g, b;
    [[NSScanner scannerWithString:rString] scanHexInt:&r];
    [[NSScanner scannerWithString:gString] scanHexInt:&g];
    [[NSScanner scannerWithString:bString] scanHexInt:&b];
    
    return [UIColor colorWithRed:((CGFloat) r / 255.0f)
                           green:((CGFloat) g / 255.0f)
                            blue:((CGFloat) b / 255.0f)
                           alpha:alpha];
    
}

@end
