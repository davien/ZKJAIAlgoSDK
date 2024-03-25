//
//  ZKJAIAlgoLiveManager.m
//  ZKJAIAlgoSDK
//
//  Created by Davien on 2024/3/25.
//

#import "ZKJAIAlgoLiveManager.h"

#import "ZKJAIAlgoManager.h"

@implementation ZKJAIAlgoLiveManager

+ (void)registerLiveDetectionAlgorithm:(Class<ZKJAILiveDetectionProtocol>)algorithm identifier:(NSString *)identifier {
    [[ZKJAIAlgoManager sharedManager] registerAlgorithmClass:algorithm identifier:identifier type:ZKJAIAlgoLiveDetectionTypeKey];
}

+ (void)switchLiveDetectionAlgorithmWithIdentifier:(NSString *)identifier {
    [[ZKJAIAlgoManager sharedManager] switchAlgorithmWithIdentifier:identifier type:ZKJAIAlgoLiveDetectionTypeKey];

}

+ (id<ZKJAILiveDetectionProtocol>)liveDetectionAlgorithm {
    id <ZKJAIAlgoCoreProtocol> algoCoreObject = [[ZKJAIAlgoManager sharedManager] algorithmForType:ZKJAIAlgoLiveDetectionTypeKey];
    id<ZKJAILiveDetectionProtocol> faceDetectionObject = (id<ZKJAILiveDetectionProtocol>)algoCoreObject;
    return faceDetectionObject;
}

@end
