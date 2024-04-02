//
//  ZKJAIAlgoFaceManager.m
//  ZKJAIAlgoSDK
//
//  Created by Davien on 2024/3/24.
//

#import "ZKJAIAlgoFaceManager.h"
#import "ZKJAIAlgoManager.h"

@implementation ZKJAIAlgoFaceManager

/// 注册人脸检测算法实例
/// - Parameters:
///   - algorithm: 要注册的算法实例
///   - identifier: 算法实例指定的唯一标识符
+ (void)registerFaceDetectionAlgorithm:(Class<ZKJAIFaceDetectionProtocol>)algorithm
                            identifier:(NSString *)identifier {
    [[ZKJAIAlgoManager sharedManager] registerAlgorithmClass:algorithm identifier:identifier type:ZKJAIAlgoFaceDetectionTypeKey];
}

/// 切换人脸检测算法
/// - Parameter identifier: 算法的标识符
+ (void)switchFaceDetectionAlgorithmWithIdentifier:(NSString *)identifier {
    NSLog(@"switchFaceDetectionAlgorithmWithIdentifier");
    [[ZKJAIAlgoManager sharedManager] switchAlgorithmWithIdentifier:identifier type:ZKJAIAlgoFaceDetectionTypeKey];
}

/// 获取人脸检测算法
+ (id <ZKJAIFaceDetectionProtocol>)faceDetectionAlgorithm {
    id <ZKJAIAlgoCoreProtocol> algoCoreObject = [[ZKJAIAlgoManager sharedManager] algorithmForType:ZKJAIAlgoFaceDetectionTypeKey];
    NSLog(@"faceDetectionAlgorithm %@",algoCoreObject);

    
    id<ZKJAIFaceDetectionProtocol> faceDetectionObject = (id<ZKJAIFaceDetectionProtocol>)algoCoreObject;
    return faceDetectionObject;
}

@end
