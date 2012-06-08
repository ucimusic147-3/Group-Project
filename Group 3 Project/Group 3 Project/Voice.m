//
//  Voice.m
//  Music147_2012
//
//  Created by Kojiro Umezaki on 4/25/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "Voice.h"

@implementation Voice

static UInt8 voicecount = 0;

@synthesize note;


-(id)initWithNote:(UInt8)n
{
    self = [super init];
    
    onCount=1;
    voicecount++;
 
    NSLog(@"%d" , voicecount);
    
    if (n != NO_KEY)
        note = n;
    
    return self;
}

-(void)fillSampleBuffer:(Float64*)buffer:(UInt32)num_samples
{
}

-(BOOL)isOn { return onCount > 0; }
-(void)on { onCount++;}
-(void)off
{
    if (onCount > 0)
    {
        onCount--;
    }
    if (onCount <= 0)
    {
        onCount = 0;
      
        voicecount--;
    }
}

@end
