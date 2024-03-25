//
//  ZKJAIAlgoManager.m
//  ZKJAIAlgoSDK
//
//  Created by Davien on 2024/3/23.
//

#import "ZKJAIAlgoManager.h"

#import "ZKJAIAlgoCoreProtocol.h"

@interface ZKJAIAlgoManager ()

// 存储所有注册的算法实例，外层字典的键为算法类型，内层字典的键为算法标识符
@property (nonatomic, strong) NSMutableDictionary<NSString *, NSMutableDictionary<NSString *, Class> *> *algorithmClasses;

// 存储每种类型当前活跃的算法标识符
@property (nonatomic, strong) NSMutableDictionary<NSString *, id<ZKJAIAlgoCoreProtocol>> *activeAlgorithmIdentifiers;

@end

@implementation ZKJAIAlgoManager
{
    // 存储所有注册的算法实例，外层字典的键为算法类型，内层字典的键为算法标识符
    NSMutableDictionary<NSString *, NSMutableDictionary<NSString *, Class> *> *_registeredAlgorithms;
    // 存储每种类型当前活跃的算法标识符
    NSMutableDictionary<NSString *, id<ZKJAIAlgoCoreProtocol>> *_activeAlgorithms;
    NSMutableDictionary<NSString *, NSString *> *_activeIdentifiers;
}

+ (instancetype)sharedManager {
    static ZKJAIAlgoManager *sharedInstance = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sharedInstance = [[self alloc] init];
    });
    return sharedInstance;
}

- (instancetype)init {
    self = [super init];
    if (self) {
        _registeredAlgorithms = [NSMutableDictionary dictionary];
        _activeAlgorithms = [NSMutableDictionary dictionary];
        _activeIdentifiers = [NSMutableDictionary dictionary];
    }
    return self;
}

- (void)registerAlgorithmClass:(Class<ZKJAIAlgoCoreProtocol>)algorithmClass identifier:(NSString *)identifier type:(NSString *)type {
    if (!_registeredAlgorithms[type]) {
            _registeredAlgorithms[type] = [NSMutableDictionary dictionary];
        }
        _registeredAlgorithms[type][identifier] = algorithmClass;
}

- (id<ZKJAIAlgoCoreProtocol>)algorithmForType:(NSString *)type {
    NSString *activeIdentifier = _activeIdentifiers[type];
    if (!activeIdentifier) {
        NSLog(@"No active algorithm identifier for type %@", type);
        return nil;
    }
    id<ZKJAIAlgoCoreProtocol> activeAlgorithm = _activeAlgorithms[activeIdentifier];
    if (!activeAlgorithm) {
        Class algorithmClass = _registeredAlgorithms[type][activeIdentifier];
        if (algorithmClass) {
            activeAlgorithm = [[algorithmClass alloc] init];
            _activeAlgorithms[activeIdentifier] = activeAlgorithm;
        }
    }
    return activeAlgorithm;
}

- (void)switchAlgorithmWithIdentifier:(NSString *)identifier type:(NSString *)type {
    NSString *currentActiveIdentifier = _activeIdentifiers[type];
    if ([currentActiveIdentifier isEqualToString:identifier]) {
        return;
    }
    
    if (currentActiveIdentifier) {
        id<ZKJAIAlgoCoreProtocol> currentActiveAlgorithm = _activeAlgorithms[currentActiveIdentifier];
        [currentActiveAlgorithm unInit];
        [_activeAlgorithms removeObjectForKey:currentActiveIdentifier];
    }
    
    _activeIdentifiers[type] = identifier;
    
    
}

@end
