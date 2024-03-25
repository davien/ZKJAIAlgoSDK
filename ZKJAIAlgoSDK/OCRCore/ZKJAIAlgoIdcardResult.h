//
//  ZKJAIAlgoIdcardResult.h
//  ZKJAIAlgoSDK
//
//  Created by Davien on 2024/3/25.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface ZKJAIAlgoIdcardResult : NSObject

/// 身份证正反面类型： 1正面 2反面
@property (nonatomic, assign) int idCardType;
/// 姓名
@property (nonatomic, copy) NSString *idcardName;
/// 性别
@property (nonatomic, copy) NSString *idcardGender;
/// 出生日期
@property (nonatomic, copy) NSString *idcardBirth;
/// 民族
@property (nonatomic, copy) NSString *idcardNation;
/// 地址
@property (nonatomic, copy) NSString *idcardAddress;
/// 身份证号
@property (nonatomic, copy) NSString *idcardNumber;
/// 签发机关
@property (nonatomic, copy) NSString *idcardAuthority;
/// 有效日期
@property (nonatomic, copy) NSString *idcardValiddate;

@end

NS_ASSUME_NONNULL_END
