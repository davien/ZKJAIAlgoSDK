//
//  ZKJAIViewController.m
//  ZKJAIAlgoSDK
//
//  Created by davien on 03/21/2024.
//  Copyright (c) 2024 davien. All rights reserved.
//

#import "ZKJAIViewController.h"

#import <ZKJAIAlgoSDK/ZKJAIFaceRecognizeResult.h>
#import <ZKJAIAlgoSDK/ZKJMSFaceLiveDetectKit.h>
#import <ZKJAIAlgoSDK/ZKJAIAlgoFaceManager.h>

#import <ZKJAIAlgoSDK/ZKJAIAlgoLiveConfig.h>
#import <ZKJAIAlgoSDK/ZKJAIAlgoMSLiveDetectKit.h>
#import <ZKJAIAlgoSDK/ZKJAIAlgoLiveManager.h>


#import <ZKJAIAlgoSDK/ZKJAIAlgoOCRManager.h>
#import <ZKJAIAlgoSDK/ZKJMSOCRDetectKit.h>
#import <ZKJAIAlgoSDK/ZKJAIAlgoOCRConfig.h>








@interface ZKJAIViewController ()

@end

@implementation ZKJAIViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor redColor];
	// Do any additional setup after loading the view, typically from a nib.
    [ZKJAIAlgoFaceManager switchFaceDetectionAlgorithmWithIdentifier:ZKJAIAlgoMSFaceDetectionIdentifierKey];
    ZKJAIAlgoFaceConfig *config = [[ZKJAIAlgoFaceConfig alloc] init];
    [[ZKJAIAlgoFaceManager faceDetectionAlgorithm] initWithConfig:config];

    
    [ZKJAIAlgoLiveManager switchLiveDetectionAlgorithmWithIdentifier:ZKJAIAlgoMSLiveDetectionIdentifierKey];
    ZKJAIAlgoLiveConfig *liveConfig = [[ZKJAIAlgoLiveConfig alloc] init];
    [[ZKJAIAlgoLiveManager liveDetectionAlgorithm] initWithConfig:liveConfig];
    
    [ZKJAIAlgoOCRManager switchOCRDetectionAlgorithmWithIdentifier:ZKJAIAlgoMSOCRDetectionIdentifierKey];
    ZKJAIAlgoOCRConfig *ocrConfig = [[ZKJAIAlgoOCRConfig alloc] init];
    [[ZKJAIAlgoOCRManager ocrDetectionAlgorithm] initIdCardWithConfig:ocrConfig];

}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
 
    
    [[ZKJAIAlgoFaceManager faceDetectionAlgorithm] detectFaceOutOfBoundInFaceImage:[UIImage imageNamed:@"123"] completion:^(ZKJAIFaceDetectStatus status, NSArray<ZKJAIFaceRecognizeResult *> * _Nullable results) {
        NSLog(@"%ld---%@",status, results);

    }];
    
    [[ZKJAIAlgoFaceManager faceDetectionAlgorithm] compareFace:[UIImage imageNamed:@"123"] face2:[UIImage imageNamed:@"123"] completion:^(ZKJAIFaceCompareStatus compareStatus, float similarityScore) {
        NSLog(@"%ld---%f",compareStatus, similarityScore);
    }];
 
}



- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
