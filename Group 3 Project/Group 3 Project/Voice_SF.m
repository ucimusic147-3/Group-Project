//
//  Voice_SF.m
//  Group 3 Project
//
//  Created by Lab User on 6/11/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "Voice_SF.h"
#import "SoundFile.h"


@implementation Voice_SF



- (id)initWithNote:(UInt8)_n
{
    self = [super initWithNote:(UInt8)_n];
    
    sample = [[Sample_Recorder alloc] init];
    
    speed = pow(2., (_n - 60)/12.);
    
	return self;
}

-(void)fillSampleBuffer:(Float64*)buffer:(UInt32)num_samples
{
    
    [sample fillSampleBuffer:buffer:num_samples:speed];
}

@end
