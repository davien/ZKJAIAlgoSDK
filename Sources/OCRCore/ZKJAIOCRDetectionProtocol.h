//
//  ZKJAIOCRDetectionProtocol.h
//  ZKJAIAlgoSDK
//
//  Created by Davien on 2024/3/22.
//

#import <Foundation/Foundation.h>

#import "ZKJAIAlgoCoreProtocol.h"

#import "ZKJAIAlgoOCRConfig.h"
#import "ZKJAIAlgoIdcardResult.h"
#import "ZKJAIAlgoBackCardResult.h"

NS_ASSUME_NONNULL_BEGIN

typedef NS_ENUM(NSUInteger, ZKJAIIdCardType) {
    ZKJAIIdCardTypeNoLimit = 0, //不限制卡片类型
    ZKJAIIdCardTypeFront = 1,   //身份证正面
    ZKJAIIdCardTypeBack  = 2,   //身份证反面
};

/// OCR算法类型
extern NSString * const ZKJAIAlgoOCRTypeKey;

/// OCR算法协议
@protocol ZKJAIOCRDetectionProtocol <ZKJAIAlgoCoreProtocol>

/// 身份证初始化 (YES 成功，NO 失败)
/// - Parameter config: 人脸算法配置
- (BOOL)initIdCardWithConfig:(ZKJAIAlgoOCRConfig *)config;


/// 开始身份证的识别
/// - Parameter cardType: 身份证人像/国徽面
- (BOOL)startIdCardDetectionWithCardType:(ZKJAIIdCardType)cardType;

/// 持续识别身份证图片
/// - Parameters:
///   - image: 识别图片
///   - cardType: 身份证人像/国徽面
///   - completion: 完成的回调
- (void)idCardDetectionInputData:(UIImage *)image
                        cardType:(ZKJAIIdCardType)cardType
                      completion:(void (^)(int code, ZKJAIAlgoIdcardResult * _Nullable idcardResult, UIImage * _Nullable bestImage))completion;

/// 停止身份证识别
- (void)stopIdCardDetection;


/// 银行卡初始化 (YES 成功，NO 失败)
/// - Parameter config: 人脸算法配置
- (BOOL)initBackCardWithConfig:(ZKJAIAlgoOCRConfig *)config;


/// 开始银行卡识别
- (BOOL)startBankCardDetection;

/// 持续识别银行卡图片
/// - Parameters:
///   - image: 识别图片
///   - overlayFrame: frame
///   - completion: 完成的回调
- (void)bankCardDetectionInputData:(UIImage *)image
                      overlayFrame:(CGRect)overlayFrame
                        completion:(void (^)(ZKJAIAlgoBackCardResult * _Nullable backCardResult,int code))completion;

/// 停止银行卡识别
- (void)stopBankCardDetection;

@required


@end

NS_ASSUME_NONNULL_END
