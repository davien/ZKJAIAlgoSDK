//
//  ZKJMSFaceLiveDetectKit.m
//  ZKJAIAlgoSDK
//
//  Created by Davien on 2024/3/23.
//

#import "ZKJMSFaceLiveDetectKit.h"

#import <LibActionLive/Facexdet.h>

#import "ZKJAlgoFaceManager.h"
#import "ZKJAlgoFaceRecognizeResult.h"

NSString * const ZKJAIAlgoMSFaceDetectionIdentifierKey = @"ZKJAIAlgoMSFaceDetectionIdentifierKey";


@implementation ZKJMSFaceLiveDetectKit

+ (void)load {
    NSLog(@"ZKJMSFaceLiveDetectKit load");

    [ZKJAlgoFaceManager registerFaceDetectionAlgorithm:[ZKJMSFaceLiveDetectKit class] identifier:ZKJAIAlgoMSFaceDetectionIdentifierKey];
}

- (ZKJAIFaceInitStatus)initWithConfig:(nonnull ZKJAlgoFaceConfig *)config {
    NSLog(@"爱加密");
    // 获取当前framework的bundle
    NSBundle *frameworkBundle = [NSBundle bundleForClass:self.class];
    // 根据bundle的名字构建路径
    NSString *bundlePath = [frameworkBundle pathForResource:@"LibActionLive" ofType:@"bundle"];

    if (![bundlePath isKindOfClass:[NSString class]] || !(bundlePath.length > 0)) {
        NSLog(@"资源路径错误");
        return  ZKJAIFaceInitStatusModelError;
    }
    
    NSString *licenseName = @"facex_record_ios";
    if ([config.licenseName isKindOfClass:[NSString class]] && config.licenseName.length > 0 ) {
        licenseName = config.licenseName;
    }

    FaceQualityConfig *faceConfig = [[FaceQualityConfig alloc] init];
    faceConfig.faceShelterSwitch = YES;
    int code = [Facexdet initWithBundleDir:bundlePath licenseName:licenseName faceQualityConfig:faceConfig];

    if (code == 1) {
        NSLog(@"Facex初始化成功");
        return ZKJAIFaceInitStatusOK;
    } else {
        NSLog(@"Facex初始化失败:%d",code);
        return ZKJAIFaceInitStatusError;
    }
}

- (void)detectFaceOutOfBoundInFaceImage:(UIImage *)faceImage completion:(void (^)(ZKJAIFaceDetectStatus, NSArray<ZKJAlgoFaceRecognizeResult *> * _Nullable))completion {
    NSLog(@"detectFaceOutOfBoundInFaceImage");
    ZKJAIFaceDetectStatus status;
    NSArray *array = [self detectFaceOutOfBoundInFaceImage:faceImage facexDetectStatus:&status];
    if (completion) {
        completion(status, [self faceRecognizeResultFromResults:array]);
    }
    
}

- (void)compareFace:(nonnull UIImage *)face1 face2:(nonnull UIImage *)face2 completion:(nonnull void (^)(ZKJAIFaceCompareStatus, float))completion {
    if (!face1) {
        NSLog(@"图片一为空");
        if (completion) {
            completion(ZKJAIFaceCompareStatusFaceOneNone, 0);
        }
        return;
    }
    
    if (!face2) {
        NSLog(@"图片二为空");
        if (completion) {
            completion(ZKJAIFaceCompareStatusFaceTwoNone, 0);
        }
        
    }
    
    ZKJAIFaceDetectStatus detStatus;
   //图一检测
    NSArray<FaceRecognizeResult * > *sourceResult = [self detectFaceOutOfBoundInFaceImage:face1 facexDetectStatus:&detStatus];
    if (detStatus == ZKJAIFaceDetectStatusNone) {
        NSLog(@"对比源图片未检测到人脸");
        if (completion) {
            completion(ZKJAIFaceCompareStatusFaceOneNone, 0);
        }
        return;
    }
    
    //图二检测
    NSArray<FaceRecognizeResult * > *compareResult= [self detectFaceOutOfBoundInFaceImage:face2 facexDetectStatus:&detStatus];
    if (detStatus == ZKJAIFaceDetectStatusNone) {
        NSLog(@"被比对图片未检测到人脸");
        if (completion) {
            completion(ZKJAIFaceCompareStatusFaceTwoNone, 0);
        }
    }
    
    NSString *sourceToken = sourceResult.firstObject.token;
    
    NSMutableArray *compareTokens = [NSMutableArray array];
    for (FaceRecognizeResult *result in compareResult) {
        [compareTokens addObject:result.token];
    }
    
    //比对
    __block NSMutableArray *scoreArray = [NSMutableArray array];
    [Facexdet recognizeFaces:sourceToken featureOther:compareTokens completion:^(NSArray<FaceRecognizeResult *> * _Nonnull results) {
        if ([results isKindOfClass:[NSArray class]] && results.count > 0) {
            for (FaceRecognizeResult *result in results) {
                [scoreArray addObject:[NSNumber numberWithFloat:result.faceScore]];
            }
        }
    }];
    
    if (scoreArray.count == 0) {
        NSLog(@"未检测到人脸");
        if (completion) {
            completion(ZKJAIFaceCompareStatusFaceTwoNone, 0);
        }
        return;
    }
    
    float similarity = 0;
    
    for (NSNumber *number in scoreArray) {
        float num = [number floatValue];
        if (num > similarity) {
            similarity = num;
        }
    }
    
    if (completion) {
        completion(ZKJAIFaceCompareStatusOK, similarity);
    }
}


- (NSArray<FaceRecognizeResult * > * _Nullable )detectFaceOutOfBoundInFaceImage:(UIImage *)faceImage facexDetectStatus:(ZKJAIFaceDetectStatus *)status{
    
    if (!faceImage) {
        *status = ZKJAIFaceDetectStatusNone;
        return [NSArray array];
    }
    
    CGRect boxRect = (CGRect){CGPointZero,faceImage.size};

    __block NSArray<FaceRecognizeResult *> *recgnizeResults = nil;

    @autoreleasepool {
        [Facexdet faceDetectWithImage:faceImage correctImage:NO completion:^(NSArray<FaceRecognizeResult *> * _Nonnull results) {
            if ([results isKindOfClass:[NSArray class]] && results.count > 0) {
                recgnizeResults = results;
                *status = ZKJAIFaceDetectStatusOK;
            } else {
                NSLog(@"未检测到人脸");
                *status = ZKJAIFaceDetectStatusNone;
            }
        }];
    };
    
    // 裁剪还原
    for (FaceRecognizeResult *recgnizeResult in recgnizeResults) {
        recgnizeResult.x = recgnizeResult.x + boxRect.origin.x;
        recgnizeResult.y = recgnizeResult.y + boxRect.origin.y;
    }

    return recgnizeResults;

}

- (NSArray <ZKJAlgoFaceRecognizeResult *>*)faceRecognizeResultFromResults:(NSArray <FaceRecognizeResult *>*)results {
    NSMutableArray *array = [NSMutableArray array];
    for (FaceRecognizeResult *result in results) {
        ZKJAlgoFaceRecognizeResult *faceResult = [[ZKJAlgoFaceRecognizeResult alloc] init];
        faceResult.x = result.x;
        faceResult.y = result.y;
        faceResult.width = result.width;
        faceResult.height = result.height;
        faceResult.faceScore = result.faceScore;
        faceResult.faceState.isFaceUpShelter = result.faceState.isFaceUpShelter;
        faceResult.faceState.isFaceDownShelter = result.faceState.isFaceDownShelter;
        faceResult.faceState.isFaceOutLineShelter = result.faceState.isFaceOutLineShelter;
        [array addObject:faceResult];
    }
    return @[];
}




- (void)unInit { 
    [Facexdet unInit];
}

@end
