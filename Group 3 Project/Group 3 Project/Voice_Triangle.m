//
//  Voice_Triangle.m
//  Group 3 Project
//
//  Created by Jetpack Dinosaurs on 6/13/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "Voice_Triangle.h"
#define Nmax 200

@implementation Voice_Triangle

-(void)fillWavetable
{
    for (UInt16 k = 1; k <= Nmax; k+=4)
    {
        for (UInt16 i = 0; i < kWaveTableSize; i++)
        {
            const Float64 t = (Float64)i / kWaveTableSize * k;
            table[i] += sin(t * 2 * M_PI) / (k*k);
        }
    }

    for (UInt16 k = 3; k <= Nmax; k+=4)
    {
        for (UInt16 i = 0; i < kWaveTableSize; i++)
        {
            const Float64 t = (Float64)i / kWaveTableSize * k;
            table[i] -= sin(t * 2 * M_PI) / (k*k);
        }
    }
}

@end