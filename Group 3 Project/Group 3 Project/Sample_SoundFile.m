//
//  Sample_SoundFile.m
//  Music147_2012
//
//  Created by Kojiro Umezaki on 5/30/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "Sample_SoundFile.h"

@implementation Sample_SoundFile

-(id)init
{
	self = [super init];
	
    /* get a path to the sound file */
    /* note that the file name and file extension are set here */
	CFURLRef mSoundFileURLRef = CFBundleCopyResourceURL(CFBundleGetMainBundle(),CFSTR("Music147"),CFSTR("aif"),NULL);
    
	/* open the file and get the fileID */
	OSStatus result = noErr;
	result = AudioFileOpenURL(mSoundFileURLRef,kAudioFileReadPermission,0,&fileID);
	if (result != noErr)
		NSLog(@"AudioFileOpenURL exception %ld",result);
	
	return self;
}

-(void)dealloc
{
	/* close the file */
	OSStatus result = noErr;
	result = AudioFileClose(fileID);
	if (result != noErr)
		NSLog(@"AudioFileClose %ld",result);	
}


-(void)fillSampleBuffer:(Float64*)buffer:(UInt32)num_buf_samples
{
    Float64 pitch = 2.0;
    
    /* set up arguments needed by AudioFileReadPackets */
    UInt32 numReadPackets = num_buf_samples * pitch;
	UInt32 ioNumPackets = numReadPackets;
	SInt64 inStartingPacket = (SInt64)filePos; /* convert float to int */
	UInt32 outNumBytes = 0;
    
    /* read some data */
	OSStatus result = AudioFileReadPackets(fileID,NO,&outNumBytes,NULL,inStartingPacket,&ioNumPackets,fileBuffer);
	if (result != noErr)
		NSLog(@"AudioFileReadPackets exception %ld",result);
    
    if (ioNumPackets < numReadPackets)
    /* reset the filePos value to 0 to loop back to the beginning of the sound file */
        filePos = 0;
    else
    /* advance the member variable filePos to know where to read from next time this method is called */
        filePos += ioNumPackets;
    
	/* convert the buffer of sample read from sound file into the app's internal audio buffer */
	for (UInt32 buf_pos = 0; buf_pos < num_buf_samples; buf_pos++)
	{
		Float64 s = (SInt16)CFSwapInt16BigToHost(fileBuffer[(UInt32)(buf_pos * pitch)]);
		buffer[buf_pos] += s / INT16_MAX;
	}
}

@end
