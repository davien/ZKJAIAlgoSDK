//
//  ZKJAlgoFaceConfig.h
//  ZKJAIAlgoSDK
//
//  Created by Davien on 2024/3/22.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface ZKJAlgoFaceConfig : NSObject

/// 模型地址
@property (nonatomic, copy) NSString *modelPath;

/// 证书名字
@property (nonatomic, copy) NSString *licenseName;


@end

NS_ASSUME_NONNULL_END
