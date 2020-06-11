//
//  UIImageView+LYExt.m
//  Tools
//
//  Created by 似水灵修 on 16/3/11.
//  Copyright © 2016年 似水灵修. All rights reserved.
//

#import "UIImageView+LYExt.h"

@implementation UIImageView (LYExt)

+ (instancetype)ly_imageViewWithImageName:(NSString *)imageName {
    UIImage *image = imageName.length ? [UIImage imageNamed:imageName] : nil;
    return [[self alloc] initWithImage:image] ;
}

@end
