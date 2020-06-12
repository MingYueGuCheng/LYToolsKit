//
//  UIDevice+LYHardware.h
//  LYUI
//
//  Created by 似水灵修 on 2018/11/9.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

typedef NS_ENUM(NSUInteger, LYNetworkType) {
    LYNetworkTypeUnknown,
    LYNetworkTypeNoNetwork,
    LYNetworkTypeWiFi,
    LYNetworkTypeWWAN,/**< 通过GPRS连接 */
    LYNetworkTypeWWAN2G,
    LYNetworkTypeWWANGPRS,
    LYNetworkTypeWWANEDGE,/**< 2.75G EDGE */
    LYNetworkTypeWWAN3G,
    LYNetworkTypeWWANHSDPA,/**< 3.5G HSDPA */
    LYNetworkTypeWWANHSUPA,/**< 3.5G HSUPA */
    LYNetworkTypeWWANHRPD,/**< 3.75G HRPD */
    LYNetworkTypeWWAN4G,
};

typedef NS_ENUM(NSUInteger, LYOperatorType) {
    LYOperatorTypeUnKnown,
    LYOperatorTypeChinaMobile,/**< 移动运营商 */
    LYOperatorTypeChinaUnicom,/**< 联通运营商 */
    LYOperatorTypeChinaTelecom,/**< 电信运营商 */
    LYOperatorTypeChinaTietong,/**< 铁通运营商 */
};

@interface UIDevice (LYHardware)

/** Hardware type */
+ (NSString *)ly_hwMchine;
/** ‘刘海’屏幕 */
+ (BOOL)ly_hasFringeScreen;

+ (NSUInteger)ly_cpuFrequency;
+ (NSUInteger)ly_busFrequency;
+ (NSUInteger)ly_cpuCount;
+ (NSUInteger)ly_totalMemory;
+ (NSUInteger)ly_userMemory;
+ (NSUInteger)ly_maxSocketBufferSize;

+ (NSUInteger)ly_totalDiskSpace;
+ (NSUInteger)ly_freeDiskSpace;

+ (NSString *)ly_macAddress;

+ (LYNetworkType)ly_networkType;
+ (LYOperatorType)ly_operatorType;

+ (nullable NSString *)ly_bundleSeedID;

@end

NS_ASSUME_NONNULL_END
