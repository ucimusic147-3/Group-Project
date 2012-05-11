//
//  Sequencer.m
//  Music147_2012
//
//  Created by Kojiro Umezaki on 5/2/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "Sequencer.h"

@implementation Sequencer

-(void)setSeq:(Sequence*)_seq
{
    seq = _seq;
}

-(void)setBpm:(Float64)_bpm
{
    bpm = _bpm;
}

-(void)updateTime:(Float64)elapsed_time
{
    Float64 elapsed_beats = bpm / 60. * elapsed_time;
    
    now_time += elapsed_beats;
    
    for (UInt32 i = 0; i < kNumSeqNotes; i++)
    {
        @autoreleasepool {
            Note* n = [seq getNote:i];
            if (n != nil)
                [n updateState:now_time];
        }
    }
}

@end
