//
//  AQPlayer_Synth.m
//  MySecondApp
//
//  Created by Kojiro Umezaki on 4/18/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "AQPlayer_Synth.h"

#import "Voice_Sine.h"

@implementation AQPlayer_Synth

-(id)init
{
    self = [super init];
    
    for (SInt32 i = 0; i < 4; i++)
    {
        voices[i] = [[Voice_Sine alloc] init];
        [voices[i] on];
        ((Voice_Synth*)voices[i]).freq = [Voice_Synth noteNumToFreq:45+(12*i)];
    }
    
    return self;
}

-(void)fillAudioBuffer:(Float64*)buffer:(UInt32)num_samples
{
    for (SInt32 i = 0; i < 4; i++)
        if (voices[i] != nil)
            [voices[i] fillSampleBuffer:buffer:num_samples];
}

@end
