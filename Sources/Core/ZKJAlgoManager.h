//
//  sdf.h
//  ZKJAIAlgoSDK
//
//  Created by Davien on 2024/3/23.
//

#import <Foundation/Foundation.h>

#import "ZKJAlgoCoreProtocol.h"

NS_ASSUME_NONNULL_BEGIN

@interface ZKJAlgoManager : NSObject

/// 获取算法管理器的单例实例
+ (instancetype)sharedManager;

/// 注册算法
/// @param algorithmClass 算法类名
/// @param identifier 算法唯一标识符
/// @param type 算法的类型（如人脸检测、活体检测或OCR）
- (void)registerAlgorithmClass:(Class <ZKJAlgoCoreProtocol>)algorithmClass
                    identifier:(NSString *)identifier
                          type:(NSString *)type;

/// 获取当前的算法
/// @param type 请求的算法类型
/// @return 返回当前设置的算法
- (id <ZKJAlgoCoreProtocol>)algorithmForType:(NSString *)type;

/// 切换当前算法实例
/// @param identifier 要切换到的算法实例的标识符
/// @param type 算法的类型
- (void)switchAlgorithmWithIdentifier:(NSString *)identifier type:(NSString *)type;

@end

NS_ASSUME_NONNULL_END
