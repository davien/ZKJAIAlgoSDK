//
//  ZKJAIViewController.m
//  ZKJAIAlgoSDK
//
//  Created by davien on 03/21/2024.
//  Copyright (c) 2024 davien. All rights reserved.
//

#import "ZKJAIViewController.h"

#import <ZKJAIAlgoSDK/ZKJAlgoFaceKit.h>

#import <ZKJAIAlgoSDK/ZKJAlgoLiveKit.h>

#import <ZKJAIAlgoSDK/ZKJAlgoOCRKit.h>








@interface ZKJAIViewController ()

@end

@implementation ZKJAIViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor redColor];
  
	// Do any additional setup after loading the view, typically from a nib.
    [ZKJAlgoFaceManager switchFaceDetectionAlgorithmWithIdentifier:ZKJAlgoMSFaceDetectIdentifierKey];
    ZKJAlgoFaceConfig *config = [[ZKJAlgoFaceConfig alloc] init];
    [[ZKJAlgoFaceManager faceDetectionAlgorithm] initWithConfig:config];

    
    [ZKJAlgoLiveManager switchLiveDetectionAlgorithmWithIdentifier:ZKJAlgoMSLiveDetectIdentifierKey];
    ZKJAlgoLiveConfig *liveConfig = [[ZKJAlgoLiveConfig alloc] init];
    [[ZKJAlgoLiveManager liveDetectionAlgorithm] initWithConfig:liveConfig];
//    
    [ZKJAlgoOCRManager switchOCRDetectionAlgorithmWithIdentifier:ZKJAlgoMSOCRDetectIdentifierKey];
    ZKJAlgoOCRConfig *ocrConfig = [[ZKJAlgoOCRConfig alloc] init];
    [[ZKJAlgoOCRManager ocrDetectionAlgorithm] initIdCardWithConfig:ocrConfig];

}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
 
//    
    [[ZKJAlgoFaceManager faceDetectionAlgorithm] detectFaceOutOfBoundInFaceImage:[UIImage imageNamed:@"123"] completion:^(ZKJAIFaceDetectStatus status, NSArray<ZKJAlgoFaceRecognizeResult *> * _Nullable results) {
        NSLog(@"%ld---%@",status, results);

    }];
    
    [[ZKJAlgoFaceManager faceDetectionAlgorithm] compareFace:[UIImage imageNamed:@"123"] face2:[UIImage imageNamed:@"123"] completion:^(ZKJAIFaceCompareStatus compareStatus, float similarityScore) {
        NSLog(@"%ld---%f",compareStatus, similarityScore);
    }];
 
}



- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
