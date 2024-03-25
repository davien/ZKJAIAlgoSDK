//
//  ZKJAIAlgoOCRManager.m
//  ZKJAIAlgoSDK
//
//  Created by Davien on 2024/3/25.
//

#import "ZKJAIAlgoOCRManager.h"

#import "ZKJAIAlgoManager.h"

@implementation ZKJAIAlgoOCRManager

/// 注册OCR算法实例
/// - Parameters:
///   - algorithm: 要注册的算法实例
///   - identifier: 算法实例指定的唯一标识符
+ (void)registerOCRAlgorithm:(Class<ZKJAIOCRDetectionProtocol>)algorithm
                  identifier:(NSString *)identifier {
    [[ZKJAIAlgoManager sharedManager] registerAlgorithmClass:algorithm identifier:identifier type:ZKJAIAlgoOCRTypeKey];
}

/// 切换OCR算法
/// - Parameter identifier: 算法的标识符
+ (void)switchOCRDetectionAlgorithmWithIdentifier:(NSString *)identifier {
    [[ZKJAIAlgoManager sharedManager] switchAlgorithmWithIdentifier:identifier type:ZKJAIAlgoOCRTypeKey];

}

/// 获取OCR算法
+ (id<ZKJAIOCRDetectionProtocol>)ocrDetectionAlgorithm {
    id <ZKJAIAlgoCoreProtocol> algoCoreObject = [[ZKJAIAlgoManager sharedManager] algorithmForType:ZKJAIAlgoOCRTypeKey];
    id<ZKJAIOCRDetectionProtocol> faceDetectionObject = (id<ZKJAIOCRDetectionProtocol>)algoCoreObject;
    return faceDetectionObject;
}

@end
