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
    
    sf = [[SoundFile alloc] init];
    
	return self;
}

-(void)fillSampleBuffer:(Float64*)buffer:(UInt32)num_samples
{
    [sf fillSampleBuffer:buffer:num_samples:freq];
}

@end
