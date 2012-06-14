//
//  Voice_Square.m
//  Group 3 Project
//
//  Created by Dennis Yeh/Jetpack Dinosaurs on 6/13/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "Voice_Square.h"
#define Nmax 20

@implementation Voice_Square

-(void)fillWavetable
{
    for (UInt16 k = 1; k <= Nmax; k+=2)
    {
        for (UInt16 i = 0; i < kWaveTableSize; i++)
        {
            const Float64 t = (Float64)i / kWaveTableSize * k;
            table[i] += sin(t * 2 * M_PI) / k;
        }
    }
}

@end
