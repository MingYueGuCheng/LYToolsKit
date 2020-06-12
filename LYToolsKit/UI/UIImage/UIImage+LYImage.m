//
//  UIImage+LYImage.m
//  LYUI
//
//  Created by 似水灵修 on 2018/11/9.
//

#import "UIImage+LYImage.h"

@implementation UIImage (LYImage)

- (instancetype)ly_waterImageWithLogoImage:(UIImage *)logoImage logoPlace:(LYImageWaterPlace)place logoScale:(CGFloat)scale logoMargin:(CGFloat)margin {
    //创建一个基于位图的上下文
    UIGraphicsBeginImageContextWithOptions(self.size, NO, 0.0);
    //背景
    [self drawInRect:CGRectMake(0, 0, self.size.width, self.size.height)];
    //绘制水印
    CGFloat logoW = logoImage.size.width * (scale ?: 1);
    CGFloat logoH = logoImage.size.height * (scale ?: 1);
    CGFloat logoX, logoY;
    switch (place) {
        case LYImageWaterPlaceCenter:
            logoX = (self.size.width - logoW) * 0.5;
            logoY = (self.size.height - logoH) * 0.5;
            break;
        case LYImageWaterPlaceLeftTop:
            logoX = margin;
            logoY = margin;
            break;
        case LYImageWaterPlaceLeftBottom:
            logoX = margin;
            logoY = self.size.height - logoH - margin;
            break;
        case LYImageWaterPlaceRightTop:
            logoX = self.size.width - logoW - margin;
            logoY = margin;
            break;
        case LYImageWaterPlaceRightBottom:
        default:
            logoX = self.size.width - logoW - margin;
            logoY = self.size.height - logoH - margin;
            break;
    }
    [logoImage drawInRect:CGRectMake(logoX, logoY, logoW, logoH)];
    //取得位图图形上下中的图片
    UIImage *newImage = UIGraphicsGetImageFromCurrentImageContext();
    //结束上下文
    UIGraphicsEndImageContext();
    
    return newImage;
}

- (UIColor *)ly_mostColor {
    int bitmapInfo = kCGBitmapByteOrderDefault | kCGImageAlphaPremultipliedLast;
    //缩小图片，加快计算速度， 但越小误差越大
    CGSize thumbSize = CGSizeMake(50.0, 50.0);
    CGColorSpaceRef colorSpace = CGColorSpaceCreateDeviceRGB();
    CGContextRef context = CGBitmapContextCreate(NULL, thumbSize.width, thumbSize.height, 8, thumbSize.width * 4, colorSpace, bitmapInfo);
    CGRect drawRect = CGRectMake(0, 0, thumbSize.width, thumbSize.height);
    CGContextDrawImage(context, drawRect, self.CGImage);
    CGColorSpaceRelease(colorSpace);
    //取每个点的像素值
    unsigned char *data = CGBitmapContextGetData(context);
    if (data == NULL) {
        return nil;
    }
    NSCountedSet *cls = [NSCountedSet setWithCapacity:thumbSize.width * thumbSize.height];
    for (int x = 0; x < thumbSize.width; x++) {
        for (int y = 0; y< thumbSize.height; y++) {
            int offset = 4 * (x * y);
            
            int red = data[offset];
            int green = data[offset + 1];
            int blue = data[offset + 2];
            int alpha = data[offset + 3];
            
            NSArray *clr = @[@(red), @(green), @(blue), @(alpha)];
            [cls addObject:clr];
        }
    }
    CGContextRelease(context);
    
    __block NSArray *maxColor = nil;
    __block NSUInteger maxCount = 0;
    //找到出现次数最多的那个颜色
    [cls enumerateObjectsUsingBlock:^(id  _Nonnull obj, BOOL * _Nonnull stop) {
        NSUInteger tmpCount = [cls countForObject:obj];
        if (tmpCount > maxCount) {
            maxCount = tmpCount;
            maxColor = obj;
        }
    }];
    
    if (!maxColor) {
        return nil;
    }
    
    return [UIColor colorWithRed:[maxColor[0] intValue] / 255.0 green:[maxColor[1] intValue] / 255.0 blue:[maxColor[2] intValue] / 255.0 alpha:[maxColor[3] intValue] / 255.0];
}

+ (NSString *)ly_theLaunchImageName {
    CGSize viewSize = [UIScreen mainScreen].bounds.size;
    NSString *viewOrientation;
    if ([UIApplication sharedApplication].statusBarOrientation == UIInterfaceOrientationPortraitUpsideDown || [UIApplication sharedApplication].statusBarOrientation == UIInterfaceOrientationPortrait) {
        viewOrientation = @"Portrait";
    } else {
        viewOrientation = @"Landscape";
    }
    __block NSString *launchImage = nil;
    NSArray<NSDictionary *> *imagesDict = [[NSBundle mainBundle] infoDictionary][@"UILaunchImages"];
    [imagesDict enumerateObjectsUsingBlock:^(NSDictionary * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        CGSize imageSize = CGSizeFromString(obj[@"UILaunchImageSize"]);
        if (CGSizeEqualToSize(imageSize, viewSize) && [viewOrientation isEqualToString:obj[@"UILaunchImageOrientation"]]) {
            launchImage = obj[@"UILaunchImageName"];
            *stop = YES;
        }
    }];
    
    return launchImage;
}

+ (instancetype)ly_theLaunchImage {
    NSString *imageName = [self ly_theLaunchImageName];
    UIImage *image;
    if (imageName) {
        image = [UIImage imageNamed:imageName];
    } else {
        image = nil;
    }
    return image;
}

@end


@implementation UIImage (LYQRCode)

- (NSString *)ly_readQRCode {
    CIContext *context = [CIContext contextWithOptions:nil];
    CIDetector *detector = [CIDetector detectorOfType:CIDetectorTypeQRCode context:context options:@{CIDetectorAccuracy:CIDetectorAccuracyHigh}];
    NSArray *features = [detector featuresInImage:self.CIImage];
    
    NSString *result;
    if (features.count) {
        CIQRCodeFeature *feature = [features firstObject];
        result = feature.messageString;
    } else {
        result = nil;
    }
    return result;
}

+ (instancetype)ly_QRCodeWithString:(NSString *)string {
    CIFilter *filter = [CIFilter filterWithName:@"CIQRCodeGenerator"];
    [filter setDefaults];
    
    NSData *data = [string?:@"" dataUsingEncoding:NSUTF8StringEncoding];
    [filter setValue:data forKey:@"inputMessage"];
    CIImage *image = [filter outputImage];
    CGAffineTransform transform = CGAffineTransformMakeScale(5.0f, 5.0f);
    image = [image imageByApplyingTransform: transform];
    UIImage *newImage = [UIImage imageWithCIImage:image scale:[UIScreen mainScreen].scale orientation:UIImageOrientationUp];
    return newImage;
}

@end
