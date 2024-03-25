//
//  ZKJAILiveDetectionProtocol.h
//  ZKJAIAlgoSDK
//
//  Created by Davien on 2024/3/22.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

#import "ZKJAIAlgoCoreProtocol.h"

#import "ZKJAIAlgoFaceConfig.h"


NS_ASSUME_NONNULL_BEGIN


/// 人脸检测算法类型
extern NSString * const ZKJAIAlgoLiveDetectionTypeKey;

/// 人脸检测算法协议
@protocol ZKJAILiveDetectionProtocol <ZKJAIAlgoCoreProtocol>

@required

/// 活体检测初始化
/// - Parameter config: 活体算法配置
- (BOOL)initWithConfig:(ZKJAIAlgoFaceConfig *)config;

/// 启动检测线程
- (int)startProcess;


- (int)imgInputWithImage:(UIImage *)image
                 faceBoxX:(int)iFaceBoxX
                 faceBoxY:(int)iFaceBoxY
                 faceBoxW:(int)iFaceBoxW
                 faceBoxH:(int)iFaceBoxH
               motionCode:(int)imotionCode
            bestImagePath:(nullable NSString *)strBestImagePath
                 complete:(void (^)(float fScreenDetScore, NSData *imageData))complete;




@end

NS_ASSUME_NONNULL_END
