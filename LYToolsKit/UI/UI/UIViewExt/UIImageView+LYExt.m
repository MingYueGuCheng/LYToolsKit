//
//  UIImageView+LYExt.m
//  Tools
//
//  Created by 吴浪 on 16/3/11.
//  Copyright © 2016年 吴浪. All rights reserved.
//

#import "UIImageView+LYExt.h"

@implementation UIImageView (LYExt)

+ (instancetype)ly_ImageViewWithImageNamed:(NSString *)imageNamed {
    UIImage *image = imageNamed.length ? [UIImage imageNamed:imageNamed] : nil;
    UIImageView *imageView = [[self alloc] initWithImage:image] ;
    return imageView;
}

@end
