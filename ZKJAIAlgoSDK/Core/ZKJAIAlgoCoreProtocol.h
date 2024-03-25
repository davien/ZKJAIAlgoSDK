//
//  人脸活体检测1.h
//  ZKJAIAlgoSDK
//
//  Created by Davien on 2024/3/22.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

#import "ZKJAIFaceRecognizeResult.h"
#import "ZKJAIAlgoFaceConfig.h"


NS_ASSUME_NONNULL_BEGIN

/// 算法核心协议
@protocol ZKJAIAlgoCoreProtocol <NSObject>

@required

/// 反初始化方法，用于销毁释放资源
- (void)unInit;

@end

NS_ASSUME_NONNULL_END
