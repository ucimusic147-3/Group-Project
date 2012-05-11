//
//  Note.m
//  Music147_2012
//
//  Created by Kojiro Umezaki on 5/2/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "Note.h"
#import "AQPlayer.h"
#import "Voice_Synth.h"

extern AQPlayer *aqp;

@implementation Note

@synthesize note_num;
@synthesize start_time;
@synthesize duration;


-(void)updateState:(Float64)now_time
{
    if (now_time < start_time)
    {
        /* waiting */
        if (on)
            if (voice != nil)
            {
                [voice off];
                on = NO;
                voice = nil;
            }
    }
    else if ((start_time <= now_time) && (now_time < (start_time + duration)))
    {
        /* playing */
        if (!on)
        {
            voice = [aqp getFreeVoice];
            if (voice != nil)
            {
                Float64 freq = [Voice_Synth noteNumToFreq:note_num];
                ((Voice_Synth*)voice).freq = freq;
                on = YES;
                [voice on];
            }
        }
    }
    else
    {
        /* done */
        if (on)
            if (voice != nil)
            {
                [voice off];
                on = NO;
                voice = nil;
            }
    }
}

@end
