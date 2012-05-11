//
//  SoundFile.h
//  MInC
//
//  Created by Kojiro Umezaki on 6/2/10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <AudioToolbox/AudioToolbox.h>

/* the maximum number of samples we can read at one time */
#define kMaxIOBufferSamples	1024

@interface SoundFile : NSObject {

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
