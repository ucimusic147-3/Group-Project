//
//  Voice_Synth.h
//  Music147_2012
//
//  Created by Kojiro Umezaki on 4/25/12.
//  Refitted by Jetpack Dinosaurs 6/12
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "Voice.h"

#define kWaveTableSize  1024

@interface Voice_Synth : Voice {
    Float64 theta;
    Float64 deltaTheta;
    Float64 freq;
    
    Float64 table[kWaveTableSize];
}

@property Float64 freq;

+(Float64)noteNumToFreq:(UInt8)note_num;

-(void)fillWavetable;
-(void)normalize;

@end
