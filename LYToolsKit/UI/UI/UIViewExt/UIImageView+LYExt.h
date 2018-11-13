//
//  UIImageView+LYExt.h
//  Tools
//
//  Created by 吴浪 on 16/3/11.
//  Copyright © 2016年 吴浪. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface UIImageView (LYExt)

/** 快速创建
 *
 *  @param  imageNamed 图片名
 *
 *  @return 返回ImageView对象
 */
+ (instancetype)ly_ImageViewWithImageNamed:(nullable NSString *)imageNamed;

@end

NS_ASSUME_NONNULL_END
