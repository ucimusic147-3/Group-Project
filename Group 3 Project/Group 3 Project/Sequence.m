//
//  Sequence.m
//  Music147_2012
//
//  Created by Kojiro Umezaki on 5/2/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "Sequence.h"

@implementation Sequence

-(id)init
{
    self = [super init];
    
    for (UInt16 i = 0; i < kNumSeqNotes; i++)
    {
        notes[i] = [[Note alloc] init];
        notes[i].note_num = 60 + i;
        notes[i].start_time = i;
        notes[i].duration = 0.5;
    }

    return self;
}

-(Note*)getNote:(UInt32)note_pos
{
    return notes[note_pos];
}

@end
