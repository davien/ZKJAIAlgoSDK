//
//  ZKJAIAlgoMSLiveDetectKit.m
//  ZKJAIAlgoSDK
//
//  Created by Davien on 2024/3/23.
//

#import "ZKJAIAlgoMSLiveDetectKit.h"

#import <LibActionLive/Actionlive.h>

#import "ZKJAlgoLiveManager.h"


NSString * const ZKJAIAlgoMSLiveDetectionIdentifierKey = @"ZKJAIAlgoMSLiveDetectionIdentifierKey";


@implementation ZKJAIAlgoMSLiveDetectKit

+ (void)load {
    [ZKJAlgoLiveManager registerLiveDetectionAlgorithm:[ZKJAIAlgoMSLiveDetectKit class] identifier:ZKJAIAlgoMSLiveDetectionIdentifierKey];
}

- (BOOL)initWithConfig:(ZKJAlgoLiveConfig *)config {
    LiveConfig *liveConfig = [[LiveConfig alloc] init];
    //    config.isScreenDet = self.configModel.screenDet;//TODO: 前置不做防翻拍
    liveConfig.isScreenDet = NO;
    liveConfig.minFaceSize = 60;
    
    // 获取当前framework的bundle
    NSBundle *frameworkBundle = [NSBundle bundleForClass:self.class];
    // 根据bundle的名字构建路径
    NSString *bundlePath = [frameworkBundle pathForResource:@"LibActionLive" ofType:@"bundle"];
    
    NSString *licenseName = @"facex_live_ios";
    if ([config.licenseName isKindOfClass:[NSString class]] && config.licenseName.length > 0 ) {
        licenseName = config.licenseName;
    }

    int facexliveStatues = [Actionlive initWithBundleDir:bundlePath licenseName:licenseName liveConfig:liveConfig];
    // 初始化结果
    if (facexliveStatues == 1) {
       NSLog(@"活体SDK初始化成功");
        return YES;
    } else {
        return NO;
    }
}

- (int)startProcess {
    return [Actionlive startProcess];
}

- (int)imgInputWithImage:(UIImage *)image faceBoxX:(int)iFaceBoxX faceBoxY:(int)iFaceBoxY faceBoxW:(int)iFaceBoxW faceBoxH:(int)iFaceBoxH motionCode:(int)imotionCode bestImagePath:(NSString *)strBestImagePath complete:(void (^)(float, NSData * _Nonnull))complete {
    return [Actionlive imgInputWithImage:image faceBoxX:iFaceBoxX faceBoxY:iFaceBoxY faceBoxW:iFaceBoxW faceBoxH:iFaceBoxH motionCode:imotionCode bestImagePath:strBestImagePath complete:complete];
}




- (void)unInit { 
    [Actionlive unInit];
}

@end
