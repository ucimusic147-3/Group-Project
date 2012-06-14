//
//  Voice_SF.h
//  Group 3 Project
//
//  Created by Lab User on 6/11/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "Voice_Synth.h"
#import "Sample_Recorder.h"
#import "SoundFile.h"

@interface Voice_SF : Voice_Synth
{
    Sample_Recorder* sample;
    Float64 speed;
}


@end
