//
//  ZKJAIAlgoFaceManager.m
//  ZKJAIAlgoSDK
//
//  Created by Davien on 2024/3/24.
//

#import "ZKJAIAlgoFaceManager.h"
#import "ZKJAlgoManager.h"

@implementation ZKJAIAlgoFaceManager

/// 注册人脸检测算法实例
/// - Parameters:
///   - algorithm: 要注册的算法实例
///   - identifier: 算法实例指定的唯一标识符
+ (void)registerFaceDetectionAlgorithm:(Class<ZKJAlgoFaceDetectionProtocol>)algorithm
                            identifier:(NSString *)identifier {
    [[ZKJAlgoManager sharedManager] registerAlgorithmClass:algorithm identifier:identifier type:ZKJAIAlgoFaceDetectionTypeKey];
}

/// 切换人脸检测算法
/// - Parameter identifier: 算法的标识符
+ (void)switchFaceDetectionAlgorithmWithIdentifier:(NSString *)identifier {
    NSLog(@"switchFaceDetectionAlgorithmWithIdentifier");
    [[ZKJAlgoManager sharedManager] switchAlgorithmWithIdentifier:identifier type:ZKJAIAlgoFaceDetectionTypeKey];
}

/// 获取人脸检测算法
+ (id <ZKJAlgoFaceDetectionProtocol>)faceDetectionAlgorithm {
    id <ZKJAlgoCoreProtocol> algoCoreObject = [[ZKJAlgoManager sharedManager] algorithmForType:ZKJAIAlgoFaceDetectionTypeKey];
    NSLog(@"faceDetectionAlgorithm %@",algoCoreObject);

    
    id<ZKJAlgoFaceDetectionProtocol> faceDetectionObject = (id<ZKJAlgoFaceDetectionProtocol>)algoCoreObject;
    return faceDetectionObject;
}

@end
