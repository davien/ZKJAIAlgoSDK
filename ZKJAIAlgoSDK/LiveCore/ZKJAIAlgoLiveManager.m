//
//  ZKJAIAlgoLiveManager.m
//  ZKJAIAlgoSDK
//
//  Created by Davien on 2024/3/25.
//

#import "ZKJAIAlgoLiveManager.h"

#import "ZKJAIAlgoManager.h"

@implementation ZKJAIAlgoLiveManager

/// 注册人脸检测算法实例
/// - Parameters:
///   - algorithm: 要注册的算法实例
///   - identifier: 算法实例指定的唯一标识符
+ (void)registerFaceDetectionAlgorithm:(Class<ZKJAILiveDetectionProtocol>)algorithm
                            identifier:(NSString *)identifier {
    [[ZKJAIAlgoManager sharedManager] registerAlgorithmClass:algorithm identifier:identifier type:ZKJAIAlgoLiveDetectionTypeKey];
}

/// 切换人脸检测算法
/// - Parameter identifier: 算法的标识符
+ (void)switchFaceDetectionAlgorithmWithIdentifier:(NSString *)identifier {
    [[ZKJAIAlgoManager sharedManager] switchAlgorithmWithIdentifier:identifier type:ZKJAIAlgoLiveDetectionTypeKey];

}
/// 获取人脸检测算法
+ (id<ZKJAILiveDetectionProtocol>)faceDetectionAlgorithm {
    id <ZKJAIAlgoCoreProtocol> algoCoreObject = [[ZKJAIAlgoManager sharedManager] algorithmForType:ZKJAIAlgoLiveDetectionTypeKey];
    id<ZKJAILiveDetectionProtocol> faceDetectionObject = (id<ZKJAILiveDetectionProtocol>)algoCoreObject;
    return faceDetectionObject;
}

@end
