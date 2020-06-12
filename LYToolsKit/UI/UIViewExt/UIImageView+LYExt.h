//
//  UIImageView+LYExt.h
//  Tools
//
//  Created by 似水灵修 on 16/3/11.
//  Copyright © 2016年 似水灵修. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface UIImageView (LYExt)

/// 快速创建
/// @param imageName 图片
+ (instancetype)ly_imageViewWithImageName:(nullable NSString *)imageName;

@end

NS_ASSUME_NONNULL_END
