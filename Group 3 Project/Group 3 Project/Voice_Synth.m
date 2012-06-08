//
//  Voice_Synth.m
//  Music147_2012
//
//  Created by Kojiro Umezaki on 4/25/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "Voice_Synth.h"

@implementation Voice_Synth

@synthesize freq;

-(id)initWithNote:(UInt8)_n
{
    self = [super initWithNote:_n];    
  //  [super setNote:n];
    
    if (_n != NO_KEY)
      freq = [Voice_Synth noteNumToFreq:_n];
    
    return self;
}

+(Float64)noteNumToFreq:(UInt8)note_num
{
    return pow(2.,(Float64)(note_num-69)/12) * 440.;
}

@end
