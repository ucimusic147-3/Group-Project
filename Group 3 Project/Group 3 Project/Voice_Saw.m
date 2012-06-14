//
//  Voice_Saw.m
//  Group 3 Project
//
//  Created by Jetpack Dinosaurs on 6/13/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "Voice_Saw.h"
#import "AQPlayer.h"

#define Nmax 200

@implementation Voice_Saw

// Sawtooth wavetable from in-class example and notes
-(void)fillWavetable
{
    /* for each harmonic (outer loop) */
    for (UInt16 k = 1; k <= Nmax; k++)
    {
        /* add to the wavetable the harmonic, a sinusoid that is an integer multiple of the fundamental frequency (inner loop) */
        for (UInt16 i = 0; i < kWaveTableSize; i++)
        {
            const Float64 t = (Float64)i / kWaveTableSize * k;
            table[i] += sin(t * 2 * M_PI) / k;
        }
    }
}




@end
