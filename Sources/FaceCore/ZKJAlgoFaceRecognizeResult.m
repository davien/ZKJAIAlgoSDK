//
//  ZKJAIFaceRecognizeResult.m
//  ZKJAIAlgoSDK
//
//  Created by Davien on 2024/3/22.
//

#import "ZKJAIFaceRecognizeResult.h"

@implementation ZKJAIFaceState


@end

@implementation ZKJAIFaceRecognizeResult

- (instancetype)init
{
    self = [super init];
    if (self) {
        self.faceState = [[ZKJAIFaceState alloc] init];
    }
    return self;
}


@end
