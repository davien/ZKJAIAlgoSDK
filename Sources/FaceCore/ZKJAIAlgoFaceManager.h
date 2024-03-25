//
//  ZKJAIAlgoFaceManager.h
//  ZKJAIAlgoSDK
//
//  Created by Davien on 2024/3/24.
//

#import <Foundation/Foundation.h>

#import "ZKJAIFaceDetectionProtocol.h"

NS_ASSUME_NONNULL_BEGIN

@interface ZKJAIAlgoFaceManager : NSObject

/// 注册人脸检测算法实例
/// - Parameters:
///   - algorithm: 要注册的算法实例
///   - identifier: 算法实例指定的唯一标识符
+ (void)registerFaceDetectionAlgorithm:(Class<ZKJAIFaceDetectionProtocol>)algorithm
                            identifier:(NSString *)identifier;

/// 切换人脸检测算法
/// - Parameter identifier: 算法的标识符
+ (void)switchFaceDetectionAlgorithmWithIdentifier:(NSString *)identifier;

/// 获取人脸检测算法
+ (id<ZKJAIFaceDetectionProtocol>)faceDetectionAlgorithm;

@end

NS_ASSUME_NONNULL_END
