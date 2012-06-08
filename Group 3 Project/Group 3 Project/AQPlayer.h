//
//  AQPlayer.h
//  MInC
//
//  Created by Kojiro Umezaki on 4/4/10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import <AudioToolbox/AudioToolbox.h>
#import <Foundation/Foundation.h>

#import "Voice_Sine.h"
#import "VoiceTouchPair.h"

/* number of buffers used by system */
#define kNumberBuffers	3



/* sample rate */
#define kSR				22050.

@interface AQPlayer : NSObject {
    
	AudioQueueRef				queue;
	AudioQueueBufferRef			buffers[kNumberBuffers];
	AudioStreamBasicDescription	dataFormat;
    
    //Voice* voices[NUM_VOICES];
    
}


-(void)setup;

-(OSStatus)start;
-(OSStatus)stop;

-(void)fillAudioBuffer:(Float64*)buffer:(UInt32)num_samples;

-(VoiceTouchPair*)newTouch:(UITouch*)newtouch;

+(Voice*)findVoice:(UInt8)midi;
-(VoiceTouchPair*)findTouch:(UITouch*)searchkey;

-(void)killTouch:(UITouch*)touch;

//-(void)voiceToggle:(UInt16)pos;

-(void)setNote:(VoiceTouchPair*)vt:(UInt8)midi;

-(void)reportElapsedTime:(Float64)elapsed_time;

@end
