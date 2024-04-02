//
//  ZKJAIFaceRecognizeResult.h
//  ZKJAIAlgoSDK
//
//  Created by Davien on 2024/3/22.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface ZKJAIFaceState : NSObject

/// 人脸上半部是否遮挡
@property (nonatomic, assign) BOOL isFaceUpShelter;
/// 人脸下半部是否遮挡
@property (nonatomic, assign) BOOL isFaceDownShelter;
/// 人脸轮廓是否遮挡
@property (nonatomic, assign) BOOL isFaceOutLineShelter;

@end

@interface ZKJAIFaceRecognizeResult : NSObject

@property (nonatomic, assign) int x;
@property (nonatomic, assign) int y;
@property (nonatomic, assign) int width;
@property (nonatomic, assign) int height;
/// 人脸检测分数
@property (nonatomic, assign) float faceScore;
/// 人脸状态
@property (nonatomic, strong) ZKJAIFaceState *faceState;

@end




NS_ASSUME_NONNULL_END
