//
//  ZKJMSOCRDetectKit.m
//  ZKJAIAlgoSDK
//
//  Created by Davien on 2024/3/23.
//

#import "ZKJMSOCRDetectKit.h"

#import <libidcardocr/libidcardocr.h>

#import "ZKJAIAlgoOCRManager.h"

NSString * const ZKJAIAlgoMSOCRDetectionIdentifierKey = @"ZKJAIAlgoMSOCRDetectionIdentifierKey";


@implementation ZKJMSOCRDetectKit

+ (void)load {
    [ZKJAIAlgoOCRManager registerOCRAlgorithm:[ZKJMSOCRDetectKit class] identifier:ZKJAIAlgoMSOCRDetectionIdentifierKey];
}

- (BOOL)initIdCardWithConfig:(ZKJAIAlgoOCRConfig *)config {
    // 获取当前framework的bundle
    NSBundle *frameworkBundle = [NSBundle bundleForClass:self.class];
    // 根据bundle的名字构建路径
    NSString *bundlePath = [frameworkBundle pathForResource:@"libidcardocr" ofType:@"bundle"];
    
    NSString *licenseName = @"msidcard_ocr_ios";
    if ([config.licenseName isKindOfClass:[NSString class]] && config.licenseName.length > 0 ) {
        licenseName = config.licenseName;
    }
    
    int statues = [IdCardOptCharReg initWithStrModelRootDir:bundlePath licenseName:licenseName];
    if (statues == 0) {
        NSLog(@"OCR初始化失败");
        return NO;
    } else {
        NSLog(@"OCR初始化成功");
    }
                   
    MSIdcardConfigInstance.bAddressCheck = NO;
    MSIdcardConfigInstance.bDistanceControl = YES;
    MSIdcardConfigInstance.bLeanAngleControl = NO;
    MSIdcardConfigInstance.distanceThreshold = 0.3;
    MSIdcardConfigInstance.leanAngleThreshold = 10;
    MSIdcardConfigInstance.bHighAccuracy = NO;
    MSIdcardConfigInstance.iTimeLimit = 20;
                   
    [IdCardOptCharReg idCardDetectionConfig:MSIdcardConfigInstance];   // 设置参数
    
    return YES;
}

- (void)unInit {
    NSLog(@"OCR反初始化成功");
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.3 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [IdCardOptCharReg unInit];
        [BankCardOptCharReg unInit];
    });
}

- (BOOL)startIdCardDetectionWithCardType:(ZKJAIIdCardType)cardType {
    int code = [IdCardOptCharReg idCardDetectionStart:(IdCardType)cardType];
    if (code == -101) {
        NSLog(@"OCR未初始化");
        return NO;
    }
    else{
        NSLog(@"OCR初始化成功");
        return YES;
    }
    
    return YES;
}

- (void)idCardDetectionInputData:(UIImage *)image cardType:(ZKJAIIdCardType)cardType completion:(nonnull void (^)(int, ZKJAIAlgoIdcardResult * _Nullable, UIImage * _Nullable))completion {
    NSString *savePath = [[self getOCRImageCachesPath] stringByAppendingPathComponent:@"idCard_ocr.jpg"];
    
    int code = [IdCardOptCharReg idCardDetRecInputData:image roiBoxX:1 roiBoxY:1 roiBoxW:image.size.width - 2 roiBoxH:image.size.height - 2  bestImagePath:savePath completion:^(int x, int y, int width, int height) {
        
    }];
    NSLog(@"OCR识别code:%d",code);
    if (code == 102) {
        [IdCardOptCharReg getIdCardTextRecResults:^(IdcardResult * _Nonnull idcardResult) {
            UIImage *bImage = [UIImage imageWithContentsOfFile:savePath];
            ZKJAIAlgoIdcardResult *result = [self idcardRecognizeResultFromResult:idcardResult];
            if (completion) {
                completion(code,result,bImage);
            }
        }];
    }
    else if (code == 101 || code == 103 || code == 104 || code == 105 || code == 106 || code == 110) {
        
        [IdCardOptCharReg idCardDetectionStart:(IdCardType)cardType];
        if (completion) {
            completion(code,nil,nil);
        }
    }
    else {
        if (completion) {
            completion(code,nil,nil);
        }
        
    }
}

- (void)stopIdCardDetection {
    [IdCardOptCharReg idCardDetectionStop];
}


- (BOOL)initBackCardWithConfig:(ZKJAIAlgoOCRConfig *)config {
    // 获取当前framework的bundle
    NSBundle *frameworkBundle = [NSBundle bundleForClass:self.class];
    // 根据bundle的名字构建路径
    NSString *bundlePath = [frameworkBundle pathForResource:@"LibActionLive" ofType:@"bundle"];
    
    int statues = [BankCardOptCharReg initWithStrModelRootDir:bundlePath licenseName:config.licenseName];
    if (statues == 0) {
        NSLog(@"银行卡识别初始化失败");
        return NO;
    }

    int code = [BankCardOptCharReg bankCardDetectionStart];
    if (code == -101) {
        NSLog(@"银行卡识别初始化失败");
        return NO;
    }
    else{
        NSLog(@"银行卡识别初始化成功");
        return YES;
    }
}

- (BOOL)startBankCardDetection {
    int code = [BankCardOptCharReg bankCardDetectionStart];
    if (code == -101) {
        NSLog(@"银行卡识别初始化失败");
        return NO;
    }
    else{
        NSLog(@"银行卡识别初始化成功");
        return YES;
    }
}

- (void)bankCardDetectionInputData:(UIImage *)image overlayFrame:(CGRect)overlayFrame completion:(void (^)(ZKJAIAlgoBackCardResult * _Nullable, int))completion {
    
    NSString *savePath = [[self getOCRImageCachesPath] stringByAppendingPathComponent:@"idCard_bank.jpg"];

    CGRect rect = overlayFrame;
    
    int space = 20;
    if (rect.origin.x <= space || rect.origin.y <= space) {
        space = 0;
    }
    
    int code = [BankCardOptCharReg bankCardDetRecInputData:image roiBoxX:(rect.origin.x - space) roiBoxY:(rect.origin.y - space) roiBoxW:(rect.size.width + space * 2) roiBoxH:(rect.size.height + space * 2)  cardAngleType:0 bestImagePath:savePath];
    
//    int code = [BankCardOptCharReg bankCardDetRecInputData:image roiBoxX:-1 roiBoxY:-1 roiBoxW:image.size.width+2 roiBoxH:image.size.height+2  cardAngleType:0 bestImagePath:savePath];
    NSLog(@"银行卡识别:%d......当前线程:%@",code,[NSThread currentThread]);
    if (code == 102) {
        [BankCardOptCharReg getBankCardTextRecResults:^(NSString * _Nonnull r_cardNum, NSString * _Nonnull r_bankName, NSString * _Nonnull r_cardName, NSString * _Nonnull r_cardType) {
            
            dispatch_async(dispatch_get_main_queue(), ^{
                UIImage *bImage = [UIImage imageWithContentsOfFile:savePath];
                ZKJAIAlgoBackCardResult *result = [[ZKJAIAlgoBackCardResult alloc] init];
                result.r_cardNum = r_cardNum;
                result.r_bankName = r_bankName;
                result.r_cardName = r_cardName;
                result.r_cardType = r_cardType;
                result.bankImage = bImage;
            
                if (completion) {
                    completion(result,code);
                }
            });

        }];
        
    }
    else if (code == 101 || code == 103 || code == 104 || code == 105 || code == 106 || code == 110) {//需要重启算法
        
        int startCode = [BankCardOptCharReg bankCardDetectionStart];
        NSLog(@"重启算法检测Code - %d",startCode);
        if (completion) {
            completion(nil,code);
        }
    }
    else{
        if (completion) {
            completion(nil,code);
        }
    }
}

- (void)stopBankCardDetection {
    [BankCardOptCharReg bankCardDetectionStop];
}


- (ZKJAIAlgoIdcardResult *)idcardRecognizeResultFromResult:(IdcardResult *)result {
    ZKJAIAlgoIdcardResult *idcardResult = [[ZKJAIAlgoIdcardResult alloc] init];
    idcardResult.idCardType = result.idCardType;
    idcardResult.idcardName = result.idcardName;
    idcardResult.idcardGender = result.idcardGender;
    idcardResult.idcardBirth = result.idcardBirth;
    idcardResult.idcardNation = result.idcardNation;
    idcardResult.idcardAddress = result.idcardAddress;
    idcardResult.idcardNumber = result.idcardNumber;
    idcardResult.idcardAuthority = result.idcardAuthority;
    idcardResult.idcardValiddate = result.idcardValiddate;
    return idcardResult;
}

//获取图片识别临时缓存地址-结束办理可删除
- (NSString *)getOCRImageCachesPath {
    
    NSFileManager *fileManger = [NSFileManager defaultManager];
    NSString *zkjSDKCachePath = [NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES).lastObject stringByAppendingPathComponent:@"ZKJSDK"];
    if (![fileManger fileExistsAtPath:zkjSDKCachePath]) {
        BOOL res = [fileManger createDirectoryAtPath:zkjSDKCachePath withIntermediateDirectories:YES attributes:nil error:nil];
        
        if (!res) {
            NSLog(@"创建zkjSDKCachePath失败");
        }
    }

    
    return zkjSDKCachePath;
}

@end
