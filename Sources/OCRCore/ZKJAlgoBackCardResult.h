//
//  ZKJAIAlgoBackCardResult.h
//  ZKJAIAlgoSDK
//
//  Created by Davien on 2024/3/25.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface ZKJAIAlgoBackCardResult : NSObject

//银行卡号
@property (nonatomic,copy) NSString *r_cardNum;
//发卡行
@property (nonatomic,copy) NSString *r_bankName;
//卡种名
@property (nonatomic,copy) NSString *r_cardName;
//卡类型
@property (nonatomic,copy) NSString *r_cardType;
//银行卡图
@property (nonatomic,strong) UIImage *bankImage;


@end

NS_ASSUME_NONNULL_END
