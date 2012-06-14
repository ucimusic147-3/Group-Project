//
//  VoiceTouchPair.h
//  Group 3 Project
//
//  Created by Jetpack Dinosaurs on 6/11/12.
//
//  This structural class links touch event objects to voice objects.
//  Voice-touch links are stored in a simple array.
//  It includes tools to create the voice objects and manage the links.
//
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

//  Change the audio output mode
+(void)setMode:(enum OutputMode)m;

//  Allot a link in the array to newtouch
//  Return nil if array is full
+(VoiceTouchPair*)newTouch:(UITouch*)newtouch;

//  Locate the link for searchkey
//  Return nil if not found
+(VoiceTouchPair*)findTouch:(UITouch*)searchkey;

//  Release touch's link from the array  
+(void)killTouch:(UITouch*)touch;

//  Instantiate voice object as per the current audio output mode
+(Voice*)makeVoice:(UInt8)midi;

//  Locate a voice matching midi note
//  Return nil if not found
+(Voice*)findVoice:(UInt8)midi;

//  Assign vt's voice to a 
//  If voice already matches, do nothing
//  If current voice is different, replace it
//  Ensure voices are unique and distince by note
+(void)setNote:(VoiceTouchPair*)vt:(UInt8)midi;


@end
