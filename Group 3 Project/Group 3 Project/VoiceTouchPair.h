//
//  VoiceTouchPair.h
//  Group 3 Project
//
//  Created by Lab User on 6/11/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Voice_Sine.h"
#import "Voice_SF.h"



enum OutputMode {Sine , File};


@interface VoiceTouchPair : NSObject
@property (nonatomic,strong) UITouch* touch;
@property (nonatomic,strong) Voice* voice;

+(VoiceTouchPair*)newTouch:(UITouch*)newtouch;
+(VoiceTouchPair*)findTouch:(UITouch*)searchkey;
+(void)killTouch:(UITouch*)touch;

+(Voice*)makeVoice:(UInt8)midi;
+(Voice*)findVoice:(UInt8)midi;

+(void)setNote:(VoiceTouchPair*)vt:(UInt8)midi;

+(void)setMode:(enum OutputMode)m;

@end
