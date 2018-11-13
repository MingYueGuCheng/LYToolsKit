//
//  NSString+LYJS.m
//  shuaidanbao
//
//  Created by 吴浪 on 15/11/17.
//  Copyright © 2015年 sdb. All rights reserved.
//

#import "NSString+LYJS.h"

@implementation NSString (LYJS)

- (instancetype)ly_jsLump {
    if (self.length) {
        NSString *js = [self copy];
        NSString *lump = [NSString stringWithFormat:@" \
                          ;(function(window, document, undefined) { \
                            %@ \
                          })(window, document);", js];
        return lump;
    } else {
        return nil;
    }
}

+ (instancetype)ly_jsForbidLink:(BOOL)disable {
    NSString *enable;
    if (disable) {
        enable = @"false";
    }else {
        enable = @"true";
    }
    NSString *js = [NSString stringWithFormat:@"function doLinkAll(action) { var aLabels = document.getElementsByTagName('a'); for (var i = 0; i < aLabels.length; i++) { if (action) { if (aLabels[i].rel) { aLabels[i].setAttribute('href', aLabels[i].ref); } } else { aLabels[i].setAttribute('rel', aLabels[i].href); aLabels[i].removeAttribute('href'); } } } doLinkAll(%@);", enable];
    return [js ly_jsLump];
}

+ (instancetype)ly_jsForbidCopy {
    NSString *js = @"document.documentElement.style.webkitUserSelect='none';";
    return [js ly_jsLump];
}

+ (instancetype)ly_jsForbidMenu {
    // 禁止选择CSS
    // CSS选中样式取消
    NSString *js = @"var style = document.getElementById('LY_style_user'); \
                     var style = style || document.createElement('style'); \
                     style.type = 'text/css'; \
                     style.id = 'LY_style_user'; \
                     var cssContent=document.createTextNode('body{-webkit-user-select:none;-webkit-user-drag:none;-webkit-touch-callout:none;}'); \
                     style.appendChild(cssContent); \
                     document.body.appendChild(style);";
    return [js ly_jsLump];
}

+ (instancetype)ly_jsScrollToTop {
    NSString *js = @"window.scrollTo(0, 0);";
    return [js ly_jsLump];
}

+ (instancetype)ly_cookieValueWithName:(NSString *)name {
    NSString *jsString = [NSString stringWithFormat:
                          @"function ly_GetCookie(name) {"
                              "var arr,reg=new RegExp('(^| )'+name+'=([^;]*)(;|$)');"
                              "if(arr=document.cookie.match(reg)) {"
                                    "return unescape(arr[2]);"
                              "} else {"
                                    "return null;"
                              "}"
                          "};ly_GetCookie('%@');", name];
    return jsString;
}

+ (instancetype)ly_userAgentWeb {
    return @"navigator.userAgent";
}

@end
