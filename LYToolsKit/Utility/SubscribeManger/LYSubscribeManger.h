//
//  LYSubscribeManger.h
//  Pods
//
//  Created by 似水灵修 on 2019/10/30.
//

@import Foundation;

NS_ASSUME_NONNULL_BEGIN

typedef void(^LYSubscribeTrigger)(NSObject *subject,  NSDictionary<NSKeyValueChangeKey,id> * __nullable change);

@interface LYSubscribeManger : NSObject

+ (void)subscribe:(NSObject *)subject forKeyPath:(NSString *)keyPath trigger:(LYSubscribeTrigger)trigger;
+ (void)unsubscribe:(NSObject *)subject forKeyPath:(NSString *)keyPath;

@end

NS_ASSUME_NONNULL_END
