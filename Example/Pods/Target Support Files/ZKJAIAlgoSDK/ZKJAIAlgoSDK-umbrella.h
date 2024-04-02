#ifdef __OBJC__
#import <UIKit/UIKit.h>
#else
#ifndef FOUNDATION_EXPORT
#if defined(__cplusplus)
#define FOUNDATION_EXPORT extern "C"
#else
#define FOUNDATION_EXPORT extern
#endif
#endif
#endif

#import "ZKJAlgoCoreProtocol.h"
#import "ZKJAlgoFaceConfig.h"
#import "ZKJAlgoFaceDetectProtocol.h"
#import "ZKJAlgoFaceManager.h"
#import "ZKJAlgoFaceRecognizeResult.h"
#import "ZKJAlgoFaceKit.h"
#import "ZKJAlgoFaceKitConstants.h"
#import "ZKJAlgoLiveConfig.h"
#import "ZKJAlgoLiveDetectProtocol.h"
#import "ZKJAlgoLiveManager.h"
#import "ZKJAlgoLiveKit.h"
#import "ZKJAlgoLiveKitConstants.h"
#import "ZKJAlgoBackCardResult.h"
#import "ZKJAlgoIdcardResult.h"
#import "ZKJAlgoOCRConfig.h"
#import "ZKJAlgoOCRDetectProtocol.h"
#import "ZKJAlgoOCRManager.h"
#import "ZKJAlgoOCRKit.h"
#import "ZKJAlgoOCRKitConstants.h"

FOUNDATION_EXPORT double ZKJAIAlgoSDKVersionNumber;
FOUNDATION_EXPORT const unsigned char ZKJAIAlgoSDKVersionString[];

