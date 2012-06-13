//
//  AQPlayer_Samp.m
//  Music147_2012
//
//  Created by Kojiro Umezaki on 5/30/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "AQPlayer_Samp.h"
#import "Sample_Recorder.h"
#import "Sample_SoundFile.h"

@implementation AQPlayer_Samp

- (id)init
{
    self = [super init];
    
    sample = [[Sample_Recorder alloc] init];
    
	return self;
}

-(void)resetStartPos
{
    [sample resetStartPos];
}

-(void)fillAudioBuffer:(Float64*)buffer:(UInt32)num_samples
{
    [sample fillSampleBuffer:buffer:num_samples];
}

@end
