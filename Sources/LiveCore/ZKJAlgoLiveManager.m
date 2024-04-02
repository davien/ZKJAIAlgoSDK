//
//  ZKJAIAlgoLiveManager.m
//  ZKJAIAlgoSDK
//
//  Created by Davien on 2024/3/25.
//

#import "ZKJAIAlgoLiveManager.h"

#import "ZKJAlgoManager.h"

@implementation ZKJAIAlgoLiveManager

+ (void)registerLiveDetectionAlgorithm:(Class<ZKJAILiveDetectionProtocol>)algorithm identifier:(NSString *)identifier {
    [[ZKJAlgoManager sharedManager] registerAlgorithmClass:algorithm identifier:identifier type:ZKJAIAlgoLiveDetectionTypeKey];
}

+ (void)switchLiveDetectionAlgorithmWithIdentifier:(NSString *)identifier {
    [[ZKJAlgoManager sharedManager] switchAlgorithmWithIdentifier:identifier type:ZKJAIAlgoLiveDetectionTypeKey];

}

+ (id<ZKJAILiveDetectionProtocol>)liveDetectionAlgorithm {
    id <ZKJAlgoCoreProtocol> algoCoreObject = [[ZKJAlgoManager sharedManager] algorithmForType:ZKJAIAlgoLiveDetectionTypeKey];
    id<ZKJAILiveDetectionProtocol> faceDetectionObject = (id<ZKJAILiveDetectionProtocol>)algoCoreObject;
    return faceDetectionObject;
}

@end
