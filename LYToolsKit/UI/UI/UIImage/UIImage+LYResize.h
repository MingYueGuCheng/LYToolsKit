//
//  UIImage+LYResize.h
//  LYUI
//
//  Created by 似水灵修 on 2018/11/8.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface UIImage (LYAlpha)

/** 图像是否有 alpha 通道 */
- (BOOL)ly_hasAlpha;
/** 返回给定图像的副本, 如果图像没有alpha通道, 则添加alpha通道 */
- (instancetype)ly_imageWithAlpha;
/**
 透明边框图像

 @param borderSize 边框大小
 @return 图像
 */
- (instancetype)ly_transparentBorderImage:(NSUInteger)borderSize;

@end


@interface UIImage (LYResize)

/** 裁剪 */
- (instancetype)ly_croppedImage:(CGRect)bounds;
/**
 缩略图， 图片 wdith = thumbnailSize + borderSize * 2

 @param thumbnailSize 缩略图图像
 @param borderSize 透明边框
 @param cornerRadius 圆角
 @param quality 质量
 @return 图片
 */
- (instancetype)ly_thumbnailImage:(NSInteger)thumbnailSize
                transparentBorder:(NSUInteger)borderSize
                     cornerRadius:(NSUInteger)cornerRadius
             interpolationQuality:(CGInterpolationQuality)quality;
/**
 调整图像大小

 @param newSize newSize 新的大小
 @param quality quality 质量
 @return 新的图像
 */
- (instancetype)ly_resizedImage:(CGSize)newSize
         interpolationQuality:(CGInterpolationQuality)quality;
/**
 调整图像大小

 @param contentMode contentMode 图像内容模式
 @param size size 图像大小
 @param quality quality 质量
 @return return value 新的图像
 */
- (instancetype)ly_resizedImageWithContentMode:(UIViewContentMode)contentMode
                                          size:(CGSize)size
                          interpolationQuality:(CGInterpolationQuality)quality;
/**
 调整图像宽、高在指定范围内

 @param imgLength imgLength 范围数值
 @return return value 新图像
 */
- (instancetype)ly_scaleImageWithImgLength:(CGFloat)imgLength;

/** 修复图像方向 */
- (instancetype)ly_fixOrientation;

@end


@interface UIImage (LYRoundedCorner)

/**
 裁剪图像

 @param cornerSize cornerSize 圆角
 @param borderSize borderSize 边框
 @return return value 图像
 */
- (instancetype)ly_roundedCornerImage:(NSInteger)cornerSize borderSize:(NSInteger)borderSize;

@end


typedef NS_ENUM(NSUInteger, LYStretchableImageStyle) {
    LYStretchableImageStyleCenter,
    LYStretchableImageStyleLeftTop,
    LYStretchableImageStyleLeftBottom,
    LYStretchableImageStyleRightTop,
    LYStretchableImageStyleRightBottom,
};

@interface UIImage (LYStretchable)

/** 返回一张可自由拉伸的图片,以中心点为扩展点 */
- (instancetype)ly_stretchableImageByStyle:(LYStretchableImageStyle)style;

@end


@interface UIImage (LYCompress)

/** 压缩图片到指定字节范围 */
- (NSData *)ly_compressImageToByte:(NSInteger)maxLength;

@end


@interface UIImage (LYTintColor)

/**
 纯色图片改变颜色
 
 @param color 颜色
 @return image
 */
- (instancetype)ly_imagePureChangeColor:(UIColor *)color;
/**
 非纯色图片改变颜色
 
 @param color 颜色
 @return image
 */
- (instancetype)ly_imageGradientChangeColor:(UIColor *)color;

@end

NS_ASSUME_NONNULL_END
