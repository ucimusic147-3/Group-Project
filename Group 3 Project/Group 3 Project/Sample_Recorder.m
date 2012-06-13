//
//  Sample_Recorder.m
//  Music147_2012
//
//  Created by Kojiro Umezaki on 5/30/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "Sample_Recorder.h"

#import "AQRecorder.h"

extern AQRecorder *aqr;

@implementation Sample_Recorder

-(void)resetStartPos
{
    readPos = 0;
}

-(void)fillSampleBuffer:(Float64*)buffer:(UInt32)num_buf_samples
{
    Float64 pitch = .7;
    
    /* To avoid a crash, ensure we're not accessing beyond the audioBuffer array. */
    /* This is not the best solution, but it's a quick one. */
    if ((readPos+num_buf_samples) < kMaxRecBufferSize)
    {
        for (UInt32 i = 0; i < num_buf_samples; i++)
        {
            /* Notes regarding the below... */
            /* The -> notation is something we did not cover in class, but is necessary in this case. */
            /* It relates to the @public directive in the AQRecorder interface and is similar to the dot notation. */
            buffer[i] += aqr->audioBuffer[(UInt32)(i * pitch)+readPos];
        }
        readPos += num_buf_samples * pitch;
    }
}

@end

