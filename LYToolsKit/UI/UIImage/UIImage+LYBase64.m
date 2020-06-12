//
//  UIImage+LYBase64.m
//  LYUI
//
//  Created by 似水灵修 on 16/5/6.
//  Copyright © 2016年 dingli. All rights reserved.
//

#import "UIImage+LYBase64.h"

@implementation UIImage (LYBase64)

+ (instancetype)ly_imageWithBase64:(NSString *)base64 {
    UIImage *image = nil;
    if (base64.length) {
        NSData *decodeImageData = [[NSData alloc] initWithBase64EncodedString:base64 options:NSDataBase64DecodingIgnoreUnknownCharacters];
        if (decodeImageData) {
            image = [self imageWithData:decodeImageData];
        }
    }
    return image;
}

+ (void)ly_imageWithBase64:(NSString *)base64 completion:(void (^)(UIImage * _Nullable))completion {
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        UIImage *image = [self ly_imageWithBase64:base64];
        if (completion) {
            dispatch_async(dispatch_get_main_queue(), ^{
                completion(image);
            });
        }
    });
}

- (NSString *)ly_base64 {
    NSData *data = UIImageJPEGRepresentation(self, 1.0f);
    NSString *encodeImageStr = [data base64EncodedStringWithOptions:0];
    return encodeImageStr;
}

@end
