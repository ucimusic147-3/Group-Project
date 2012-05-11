//
//  AQPlayer_Synth.h
//  MySecondApp
//
//  Created by Kojiro Umezaki on 4/18/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "AQPlayer.h"

@interface AQPlayer_Synth : AQPlayer {
    /* member variables */
    Float64 theta;
    Float64 deltaTheta;
}

// methods
-(void)fillAudioBuffer:(Float64*)buffer:(UInt32)num_samples;


@end
