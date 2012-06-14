//
//  Voice_Sample.m
//  Group 3 Project
//
//  Created by Sia Mozaffari/Jetpack Dinosaurs on 6/11/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "Voice_Sample.h"
#import "AQRecorder.h"

extern AQRecorder* aqr;

@implementation Voice_Sample



- (id)initWithNote:(UInt8)_n
{
    self = [super initWithNote:(UInt8)_n];
    
  //  sample = [[Sample alloc] init];
    
    speed = pow(2., (_n - 60)/12.);
    
    readPos = 0;
    
	return self;
}

// Recording buffer created by Kojiro Kumezaki
-(void)fillSampleBuffer:(Float64*)buffer:(UInt32)num_samples
{
    /* To avoid a crash, ensure we're not accessing beyond the audioBuffer array. */
    /* This is not the best solution, but it's a quick one. */
    if ((readPos+num_samples) < kMaxRecBufferSize)
    {
        for (UInt32 i = 0; i < num_samples; i++)
        {
            /* Notes regarding the below... */
            /* The -> notation is something we did not cover in class, but is necessary in this case. */
            /* It relates to the @public directive in the AQRecorder interface and is similar to the dot notation. */
            buffer[i] += aqr->audioBuffer[(UInt32)(i * speed)+readPos];
        }
        readPos += num_samples * speed;
    }
}

@end
