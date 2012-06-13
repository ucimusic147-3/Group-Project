//
//  AQPlayer_Samp.h
//  Music147_2012
//
//  Created by Kojiro Umezaki on 5/30/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "AQPlayer.h"
#import "Sample.h"

@interface AQPlayer_Samp : AQPlayer {
    Sample* sample;
}

-(void)fillAudioBuffer:(Float64*)buffer:(UInt32)num_samples;

-(void)resetStartPos;

@end
