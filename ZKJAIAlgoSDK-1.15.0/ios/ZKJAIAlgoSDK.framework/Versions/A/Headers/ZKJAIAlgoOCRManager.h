//
//  ZKJAIAlgoOCRManager.h
//  ZKJAIAlgoSDK
//
//  Created by Davien on 2024/3/25.
//

#import <Foundation/Foundation.h>

#import "ZKJAIOCRDetectionProtocol.h"

NS_ASSUME_NONNULL_BEGIN

@interface ZKJAIAlgoOCRManager : NSObject

/// 注册OCR算法实例
/// - Parameters:
///   - algorithm: 要注册的算法实例
///   - identifier: 算法实例指定的唯一标识符
+ (void)registerOCRAlgorithm:(Class<ZKJAIOCRDetectionProtocol>)algorithm
                  identifier:(NSString *)identifier;

/// 切换OCR算法
/// - Parameter identifier: 算法的标识符
+ (void)switchOCRDetectionAlgorithmWithIdentifier:(NSString *)identifier;

/// 获取OCR算法
+ (id<ZKJAIOCRDetectionProtocol>)ocrDetectionAlgorithm;

@end

NS_ASSUME_NONNULL_END
