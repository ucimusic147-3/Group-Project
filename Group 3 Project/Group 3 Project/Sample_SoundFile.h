//
//  Sample_SoundFile.h
//  Music147_2012
//
//  Created by Kojiro Umezaki on 5/30/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <AudioToolbox/AudioToolbox.h>

#import "Sample.h"

/* the maximum number of samples we can read at one time */
#define kMaxIOBufferSamples	1024

@interface Sample_SoundFile : Sample {
    
    /* a kind of system pointer to the audio file */
    AudioFileID		fileID;
    
    /* the buffer which will contain data read from the audio file */
    SInt16			fileBuffer[kMaxIOBufferSamples];
    
    /* the index where the next read in the file will happen  */
    Float64			filePos;
}

/* calling this will read the next buffer of samples */
-(void)fillSampleBuffer:(Float64*)buffer:(UInt32)num_buf_samples;

@end