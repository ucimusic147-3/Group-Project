//
//  Voice_Synth.h
//  Music147_2012
//
//  Created by Kojiro Umezaki on 4/25/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "Voice.h"

@interface Voice_Synth : Voice {
    Float64 theta;
    Float64 deltaTheta;
    Float64 freq;
}

@property Float64 freq;

+(Float64)noteNumToFreq:(UInt8)note_num;

@end
