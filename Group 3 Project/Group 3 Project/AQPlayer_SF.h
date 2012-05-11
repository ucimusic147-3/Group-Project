//
//  AQPlayer_SF.h
//  MySecondApp
//
//  Created by Kojiro Umezaki on 4/18/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "AQPlayer.h"
#import "SoundFile.h"

@interface AQPlayer_SF : AQPlayer {
    SoundFile* sf;
}

-(void)fillAudioBuffer:(Float64*)buffer:(UInt32)num_samples;

@end
