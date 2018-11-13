//
//  NSString+LYURL.h
//  LYToolsKit
//
//  Created by 吴浪 on 2018/11/12.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

extern NSString *const kLYURLScheme;
extern NSString *const kLYURLHost;
extern NSString *const kLYURLPort;
extern NSString *const kLYURLParams;
extern NSString *const kLYURLQuerys;
extern NSString *const kLYURLPath;
extern NSString *const kLYURLFragment;

@interface NSString (LYURL)

#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Wdocumentation"
/**
 解析URL
 格式如：http://host.name:8888/test/page/?keyA=valueA&keyB=valueB#top
 URL中的 参数表
 @param    kLYURLScheme   如 http
 @param    kLYURLHost     如 host.name
 @param    kLYURLPort     如 8888
 @param    kLYURLParams   如 {keyA:valueA, keyB:valueB}
 @param    kLYURLQuerys   如 [{keyA:valueA}, {keyB:valueB}],含重复
 @param    kLYURLPath     如 /test/page
 @param    kLYURLFragment 如 top
 @return   NSDictionary
 */
- (NSDictionary *)ly_paramsFromURLString;
#pragma clang diagnostic pop

/**
 URL地址Reserved Characters与Unreserved Characters之外的字符做百分号编码。
 编码范围：
 1. UTF-8编码
 2. !*'();:@&=+$,/?%#[ ]除外字符
 */
- (instancetype)ly_stringAllAddingPercentEncoding;
/** 处理字符串中的中文、空格、《》（）【】 */
- (instancetype)ly_stringAddingPercentEscapesChineseSpace;
/**
 根据 string构建 URL实例

 @param string string URL String
 @return return value URL实例
 */
+ (NSURL *)ly_URLWithString:(NSString *)string;

@end

NS_ASSUME_NONNULL_END
