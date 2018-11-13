//
//  UIImage+LYImage.h
//  LYUI
//
//  Created by 吴浪 on 2018/11/9.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

typedef NS_ENUM(NSUInteger, LYImageWaterPlace) {
    LYImageWaterPlaceCenter,
    LYImageWaterPlaceLeftTop,
    LYImageWaterPlaceLeftBottom,
    LYImageWaterPlaceRightTop,
    LYImageWaterPlaceRightBottom,
};
@interface UIImage (LYImage)

/**
 图片打水印

 @param logoImage logoImage 水印标识
 @param place place 水印位置
 @param scale scale 水印放缩大小
 @param margin margin 水印距离边缘值
 @return return value 有水印的图片
 */
- (instancetype)ly_waterImageWithLogoImage:(UIImage *)logoImage
                                 logoPlace:(LYImageWaterPlace)place
                                 logoScale:(CGFloat)scale
                                logoMargin:(CGFloat)margin;
/** 获取图片的主色调 */
- (UIColor *)ly_mostColor;
/** 获取App启动图片 */
+ (instancetype)ly_theLaunchImage;

@end


@interface UIImage (LYQRCode)

/** 识别二维码 */
- (NSString *)ly_readQRCode;

/** 生成二维码 */
+ (instancetype)ly_QRCodeWithString:(NSString *)string;

@end

NS_ASSUME_NONNULL_END
