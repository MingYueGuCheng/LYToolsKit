//
//  NSString+LYCoding.h
//  茗玥古城
//
//  Created by 似水灵修 on 13-11-11.
//  Copyright (c) 2013年 MingYueGuCheng. All rights reserved.
//

@import Foundation;

NS_ASSUME_NONNULL_BEGIN
/**
 *  终端测试指令
 *
 *  BASE64编码(abc)
 *  $ echo -n abc | base64
 *
 *  BASE64解码(YWJj，abc的编码)
 *  $ echo -n YWJj | base64 -D
 */
@interface NSString(LYBase64)

- (instancetype)ly_base64Encode;
- (instancetype)ly_base64Decode;

@end

/**
 *  终端测试指令
 *  加密abc字符串:
 *  MD5:
 *  $ echo -n abc | openssl md5
 *  SHA1:
 *  $ echo -n abc | openssl sha1
 *  SHA256:
 *  $ echo -n abc | openssl sha -sha256
 *  SHA512:
 *  $ echo -n abc | openssl sha -sha512
 */
@interface NSString(LYHash)

- (instancetype)ly_md5String;
- (instancetype)ly_sha1String;
- (instancetype)ly_sha256String;
- (instancetype)ly_sha512String;

@end

NS_ASSUME_NONNULL_END
