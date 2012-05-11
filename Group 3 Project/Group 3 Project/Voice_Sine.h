//
//  Voice_Sine.h
//  Music147_2012
//
//  Created by Kojiro Umezaki on 4/25/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "Voice_Synth.h"

@interface Voice_Sine : Voice_Synth

-(void)fillSampleBuffer:(Float64*)buffer:(UInt32)num_samples;

@end
