//
//  Bridged-swift.m
//  Bridged
//
//  Created by Otuniyi, Olayinka (ELS-LON) on 12/11/2021.
//

#import <Foundation/Foundation.h>
#import "React/RCTBridgeModule.h"
#import "React/RCTEventEmitter.h"

@interface RCT_EXTERN_MODULE(CustomRN, NSObject)
  RCT_EXTERN_METHOD(goBack)
@end
