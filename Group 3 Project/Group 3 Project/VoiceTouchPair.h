//
//  VoiceTouchPair.h
//  Group 3 Project
//
//  Created by Jetpack Dinosaurs on 6/11/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Voice_Sine.h"
#import "Voice_Sample.h"
#import "Voice_Saw.h"
#import "Voice_Square.h"
#import "Voice_Triangle.h"


enum OutputMode {Sine , Record , Saw , Square , Triangle};


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
