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

#import "ZKJAIAlgoCoreProtocol.h"
#import "ZKJAIAlgoManager.h"
#import "ZKJAIAlgoBackCardResult.h"
#import "ZKJAIAlgoIdcardResult.h"
#import "ZKJAIAlgoOCRConfig.h"
#import "ZKJAIAlgoOCRManager.h"
#import "ZKJAIOCRDetectionProtocol.h"

FOUNDATION_EXPORT double ZKJAIAlgoSDKVersionNumber;
FOUNDATION_EXPORT const unsigned char ZKJAIAlgoSDKVersionString[];

