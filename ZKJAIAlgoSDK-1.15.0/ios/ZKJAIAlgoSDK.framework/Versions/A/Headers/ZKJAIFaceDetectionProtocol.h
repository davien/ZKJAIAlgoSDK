//
//  人脸活体检测1.h
//  ZKJAIAlgoSDK
//
//  Created by Davien on 2024/3/22.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

#import "ZKJAIAlgoCoreProtocol.h"

#import "ZKJAIAlgoFaceConfig.h"
#import "ZKJAIFaceRecognizeResult.h"


NS_ASSUME_NONNULL_BEGIN


/// 初始化
typedef NS_ENUM(NSInteger, ZKJAIFaceInitStatus) {
    ZKJAIFaceInitStatusOK,                // 成功
    ZKJAIFaceInitStatusModelError,        // 模型错误
    ZKJAIFaceInitStatusError              // 错误
};

/// 人脸检测
typedef NS_ENUM(NSInteger, ZKJAIFaceDetectStatus) {
    ZKJAIFaceDetectStatusOK,              // 成功
    ZKJAIFaceDetectStatusNone             // 未检测到
};

/// 人脸比对
typedef NS_ENUM(NSInteger, ZKJAIFaceCompareStatus) {
    ZKJAIFaceCompareStatusOK,             // 成功
    ZKJAIFaceCompareStatusFaceOneNone,    // 图一未检测到
    ZKJAIFaceCompareStatusFaceTwoNone     // 图二未检测到
};

/// 人脸检测算法类型
extern NSString * const ZKJAIAlgoFaceDetectionTypeKey;

/// 人脸检测算法协议
@protocol ZKJAIFaceDetectionProtocol <ZKJAIAlgoCoreProtocol>

@required

/// 人脸检测初始化
/// - Parameter config: 人脸算法配置
- (ZKJAIFaceInitStatus)initWithConfig:(ZKJAIAlgoFaceConfig *)config;

/// 人脸出框检测
/// - Parameters:
///   - faceImage: 人脸图片
///   - completion: 完成的回调
- (void)detectFaceOutOfBoundInFaceImage:(UIImage *)faceImage
                             completion:(void (^)(ZKJAIFaceDetectStatus status,NSArray<ZKJAIFaceRecognizeResult *> * _Nullable results))completion;


/// 人脸比对
/// - Parameters:
///   - face1: 图片1
///   - face2: 图片2
///   - completion: 完成的回调
- (void)compareFace:(UIImage *)face1
              face2:(UIImage *)face2
         completion:(void (^)(ZKJAIFaceCompareStatus compareStatus, float similarityScore))completion;

@end

NS_ASSUME_NONNULL_END
