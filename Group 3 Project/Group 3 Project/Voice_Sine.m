//
//  Voice_Sine.m
//  Music147_2012
//
//  Created by Kojiro Umezaki on 4/25/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "Voice_Sine.h"

#import "AQplayer.h"

@implementation Voice_Sine

extern UInt8 voicecount;

-(void)fillSampleBuffer:(Float64*)buffer:(UInt32)num_samples
{
    deltaTheta = freq / kSR;
    
    Float64 amp = .25; //(Float64)voicecount/NUM_VOICES;
    
	for (SInt32 i = 0; i < num_samples; i++)
	{
		buffer[i] += amp * sin(theta * 2 * M_PI);
		theta += deltaTheta;
	}
}

@end
