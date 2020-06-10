//
//  LYSubscribeManger.m
//  Pods
//
//  Created by 似水灵修 on 2019/10/30.
//

#import "LYSubscribeManger.h"
@import ObjectiveC.runtime;

static NSString * const kSubscribeContext = @"LYSubscribeMangerContext";

@interface LYSubscribeModel : NSObject
@property (nonatomic, weak) NSObject *subject;
@property (nonatomic, copy) NSString *keyPath;
@property (nonatomic, copy) LYSubscribeTrigger trigger;

- (instancetype)initWithSubject:(NSObject *)subject keyPath:(NSString *)keyPath trigger:(LYSubscribeTrigger)trigger;

@end

@implementation LYSubscribeModel

- (instancetype)initWithSubject:(NSObject *)subject keyPath:(NSString *)keyPath trigger:(LYSubscribeTrigger)trigger {
    if (self = [super init]) {
        self.subject = subject;
        self.keyPath = keyPath;
        self.trigger = trigger;
    }
    return self;
}

@end

@interface LYSubscribeManger ()
@property (nonatomic, strong) NSMutableArray <LYSubscribeModel *> *models;

@end
@implementation LYSubscribeManger

+ (instancetype)shared {
    static id instance = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        instance = [[self alloc] init];
    });
    return instance;
}

+ (void)subscribe:(NSObject *)subject forKeyPath:(NSString *)keyPath trigger:(LYSubscribeTrigger)trigger {
    LYSubscribeManger *observer = [self shared];
    [observer seekSubscribeModel:subject keyPath:keyPath result:^(LYSubscribeModel *model) {
        if (model) {
            [self unsubscribe:subject forKeyPath:keyPath];
        }
        LYSubscribeModel *subscribeModel = [[LYSubscribeModel alloc] initWithSubject:subject keyPath:keyPath trigger:trigger];
        [observer.models addObject:subscribeModel];
        [subject addObserver:observer forKeyPath:keyPath options:NSKeyValueObservingOptionNew | NSKeyValueObservingOptionOld context:(__bridge void * _Nullable)(kSubscribeContext)];
    }];
}

- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary<NSKeyValueChangeKey,id> *)change context:(void *)context {
    LYSubscribeManger *observer = [LYSubscribeManger shared];
    [observer seekSubscribeModel:object keyPath:keyPath result:^(LYSubscribeModel *model) {
        if (model && model.trigger) {
            model.trigger(object, change);
        }
    }];
}

+ (void)unsubscribe:(NSObject *)subject forKeyPath:(NSString *)keyPath {
    LYSubscribeManger *observer = [self shared];
    [observer seekSubscribeModel:subject keyPath:keyPath result:^(LYSubscribeModel *model) {
        if (model) {
            [subject removeObserver:observer forKeyPath:keyPath context:(__bridge void * _Nullable)(kSubscribeContext)];
        }
    }];
    
    NSMutableArray *models = [NSMutableArray array];
    [observer.models enumerateObjectsUsingBlock:^(LYSubscribeModel * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        if (!obj.subject) {
            [models addObject:obj];
        }
    }];
    [observer.models removeObjectsInArray:models];
}

- (void)seekSubscribeModel:(NSObject *)subject keyPath:(NSString *)keyPath result:(void(^)(LYSubscribeModel *model))result {
    __block LYSubscribeModel *model = nil;
    if (subject && keyPath.length) {
        [self.models enumerateObjectsWithOptions:NSEnumerationReverse usingBlock:^(LYSubscribeModel * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
            if ([obj.subject isEqual:subject] && [obj.keyPath isEqualToString:keyPath]) {
                model = obj;
                *stop = YES;
            }
        }];
    }
    if (result) {
        result(model);
    }
}

- (NSMutableArray<LYSubscribeModel *> *)models {
    if (!_models) {
        _models = [NSMutableArray array];
    }
    return _models;
}

@end
