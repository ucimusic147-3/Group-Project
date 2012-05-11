//
//  AQPlayer_SF.m
//  MySecondApp
//
//  Created by Kojiro Umezaki on 4/18/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "AQPlayer_SF.h"

@implementation AQPlayer_SF

- (id)init
{
    self = [super init];
    
    sf = [[SoundFile alloc] init];
    
	return self;
}

-(void)fillAudioBuffer:(Float64*)buffer:(UInt32)num_samples
{
    [sf fillSampleBuffer:buffer:num_samples];
}

@end
