//
//  Voice_Synth.m
//  Music147_2012
//
//  Created by Kojiro Umezaki on 4/25/12.
//  Refitted by Dennis Yeh/Jetpack Dinosaurs 6/12
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "Voice_Synth.h"
#import "AQPlayer.h"

@implementation Voice_Synth

@synthesize freq;

-(id)initWithNote:(UInt8)_n
{
    self = [super initWithNote:_n];    
    
    if (_n != NO_KEY)
      freq = [Voice_Synth noteNumToFreq:_n];
    
    
    [self fillWavetable];
    [self normalize];
    
    return self;
}

+(Float64)noteNumToFreq:(UInt8)note_num
{
    return pow(2.,(Float64)(note_num-69)/12) * 440.;
}

-(void)fillWavetable
{
}

-(void)normalize;
{
    /* find maximum value in table */
    Float64 max = 0.;
    for (UInt16 i = 0; i < kWaveTableSize; i++)
    {
        if (fabs(table[i]) > max)
            max = fabs(table[i]);
    }
    
    if (max <= 0.0)
        return;
    
    /* scale table by maximum value (i.e. normalize) */
    for (UInt16 i = 0; i < kWaveTableSize; i++)
    {
        table[i] = table[i] / max;
    }
}

-(void)fillSampleBuffer:(Float64*)buffer:(UInt32)num_samples
{
    deltaTheta = freq / kSR;
    
    Float64 amp = [Voice getAmp];
    
	for (SInt32 n = 0; n < num_samples; n++)
	{
        /* i is the floating point index into the wavetable */
        Float64 i = theta * kWaveTableSize;
        
        /* i0 is the "lower" index; i1 is the "higher" index */
        SInt32 i0 = (SInt32)i % kWaveTableSize;
        SInt32 i1 = (i0 + 1) % kWaveTableSize;
        
        /* k is the fractional amount between i0 and i1 */
        Float64 k = i - (SInt32)i;
        
        /* s0 and s1 are table values at i0 and i1, respectively */
        Float64 s0 = table[i0];
        Float64 s1 = table[i1];
        
        /* s is the interpolated table value */
        Float64 s = s0 + (s1 - s0) * k;
        
        
        buffer[n] += amp * s;
        
		theta += deltaTheta;
	}
}

@end
