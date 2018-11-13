//
//  NSString+LYURL.m
//  LYToolsKit
//
//  Created by 吴浪 on 2018/11/12.
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

@end
