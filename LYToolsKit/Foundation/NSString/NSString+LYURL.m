//
//  NSString+LYURL.m
//  LYToolsKit
//
//  Created by 似水灵修 on 2018/11/12.
//

#import "NSString+LYURL.h"

NSString *const kLYURLScheme = @"SCHEME";
NSString *const kLYURLHost = @"HOST";
NSString *const kLYURLPort = @"PORT";
NSString *const kLYURLParams = @"PARAMS";
NSString *const kLYURLQuerys = @"QUERYS";
NSString *const kLYURLPath = @"PATH";
NSString *const kLYURLFragment = @"FRAGMENT";

@implementation NSString (LYURL)

+ (NSURL *)ly_URLWithString:(NSString *)string {
    NSURL *url;
    if (string && [string isKindOfClass:[NSString class]] && string.length) {
        url = [NSURL URLWithString:string];
    } else {
        url = nil;
    }
    return url;
}

- (NSDictionary *)ly_paramsFromURLString {
    NSString *urlStr = [self ly_stringAddingPercentEscapesChineseSpace];
    if (urlStr.length) {
        NSURLComponents *urlComponent = [NSURLComponents componentsWithString:urlStr];
        
        NSMutableDictionary *params = [NSMutableDictionary dictionary];
        params[kLYURLScheme] = urlComponent.scheme;
        params[kLYURLHost] = urlComponent.host;
        params[kLYURLPort] = urlComponent.port;
        params[kLYURLPath] = urlComponent.path;
        params[kLYURLFragment] = urlComponent.fragment;
        
        __block NSMutableDictionary *paramDict = [NSMutableDictionary dictionary];
        __block NSMutableArray *queryArray = [NSMutableArray array];
        [urlComponent.queryItems enumerateObjectsUsingBlock:^(NSURLQueryItem * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
            NSMutableDictionary *dict = [NSMutableDictionary dictionary];
            dict[obj.name] = obj.value;
            [queryArray addObject:dict];
            [paramDict addEntriesFromDictionary:dict];
        }];
        params[kLYURLParams] = paramDict;
        params[kLYURLQuerys] = queryArray;
        
        return [params copy];
    }
    
    return nil;
}

- (instancetype)ly_stringAllAddingPercentEncoding {
    return [self stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet characterSetWithCharactersInString:@"!*'();:@&=+$,/?%#[ ]"].invertedSet];
}

- (instancetype)ly_stringAddingPercentEscapesChineseSpace {
    if (!self.length) {
        return self;
    }
    
    NSString *regex = @".*[\u4e00-\u9fa5《》（）【】].*";
    NSPredicate *pre = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", regex];
    
    __block NSString *urlStr = [self copy];
    BOOL isIllegal = [pre evaluateWithObject:urlStr];
    if (isIllegal) {
        __block NSMutableDictionary *keyValueDict = [NSMutableDictionary dictionary];
        NSString *regex = @"[\u4e00-\u9fa5《》（）【】]";
        NSRegularExpression *regular = [NSRegularExpression regularExpressionWithPattern:regex options:NSRegularExpressionCaseInsensitive error:NULL];
        [regular enumerateMatchesInString:urlStr options:NSMatchingReportProgress range:NSMakeRange(0, urlStr.length) usingBlock:^(NSTextCheckingResult * _Nullable result, NSMatchingFlags flags, BOOL * _Nonnull stop) {
            if (result) {
                NSString *kv = [urlStr substringWithRange:result.range];
                keyValueDict[kv] = [kv stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet URLQueryAllowedCharacterSet]];
            }
        }];
        
        [keyValueDict enumerateKeysAndObjectsUsingBlock:^(id  _Nonnull key, id  _Nonnull obj, BOOL * _Nonnull stop) {
            urlStr = [urlStr stringByReplacingOccurrencesOfString:key withString:obj];
        }];
    }
    
    return [urlStr stringByReplacingOccurrencesOfString:@" " withString:@""];
}
/**
 url拼接参数
 
 @param url url
 @param params 参数
 @param cover YES：覆盖已经存在的参数；NO：跳过已经存在的参数；
 @return url
 */
+ (instancetype)ly_stringURL:(NSString *)url appendParams:(NSDictionary<NSString *, NSString *> *)params cover:(BOOL)cover {
    if (![url isKindOfClass:[NSString class]]) {
        return nil;
    }
    
    url = [url ly_stringAddingPercentEscapesChineseSpace];
    if (!url.length) {
        return nil;
    }
    
    if (!params.count) {
        return url;
    }
    
    NSURLComponents *urlComponent = [NSURLComponents componentsWithString:url];
    __block NSMutableArray *queryItems = [urlComponent.queryItems mutableCopy];
    if (!queryItems) {
        queryItems = [NSMutableArray array];
    }
    
    [params enumerateKeysAndObjectsUsingBlock:^(NSString * _Nonnull key, NSString * _Nonnull obj, BOOL * _Nonnull stop) {
        if ([obj isKindOfClass:[NSString class]]) {
            __block NSUInteger existIndex = NSNotFound;
            [urlComponent.queryItems enumerateObjectsWithOptions:NSEnumerationReverse usingBlock:^(NSURLQueryItem * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
                if ([key isEqualToString:obj.name]) {
                    existIndex = idx;
                    *stop = YES;
                }
            }];
            if (existIndex == NSNotFound) {
                NSURLQueryItem *item = [NSURLQueryItem queryItemWithName:key value:obj];
                [queryItems addObject:item];
            } else {
                if (cover) {
                    NSURLQueryItem *item = queryItems[existIndex];
                    queryItems[existIndex] = [NSURLQueryItem queryItemWithName:item.name value:obj];
                }
            }
        }
    }];
    
    if (queryItems.count) {
        urlComponent.queryItems = queryItems;
    }
    
    return urlComponent.string;
}

+ (instancetype)ly_stringURL:(NSString *)url appendParams:(NSDictionary<NSString *, NSString *> *)params {
    return [self ly_stringURL:url appendParams:params cover:YES];
}

+ (instancetype)ly_stringURL:(NSString *)url appendNotExistParams:(NSDictionary<NSString *, NSString *> *)params {
    return [self ly_stringURL:url appendParams:params cover:NO];
}

@end
