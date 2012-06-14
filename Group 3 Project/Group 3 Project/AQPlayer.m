//
//  AQPlayer.m
//  MInC
//
//  Created by Kojiro Umezaki on 4/4/10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import "AQPlayer.h"
//#import "Voice_SF.h"
//#import "SoundFile.h"
#import "Singleton.h"

AQPlayer *aqp = nil;

extern Singleton* gSing;
extern UInt8 voicecount;
extern VoiceTouchPair* VTarray[NUM_VOICES];


void AQBufferCallback(void *inUserData, AudioQueueRef inAQ, AudioQueueBufferRef inAQBuffer);

void AQBufferCallback(void *inUserData, AudioQueueRef inAQ, AudioQueueBufferRef inAQBuffer) 
{
    /* compute the requested number of sample frames of audio */
	const SInt32 numFrames = (inAQBuffer->mAudioDataBytesCapacity) / sizeof(SInt16);
    
    /* create a temporary buffer of Float64 type samples */
	Float64 buffer[numFrames];
    
    /* set all sample values in buffer to zero (no sound) */
    memset(buffer,0,sizeof(Float64)*numFrames);
	
    /* call AQPlayer fillAudioBuffer method to get a new block of samples */
	[aqp fillAudioBuffer:buffer:numFrames];
	
    /* fill the outgoing buffer as SInt16 type samples */
	for (SInt32 i = 0; i < numFrames; i++)
		((SInt16 *)inAQBuffer->mAudioData)[i] = buffer[i] * (SInt16)INT16_MAX;
	
    /* set the mAudioDataByteSize and mPacketDescriptionCount AudioQueueBuffer fields (for some reason) */
	inAQBuffer->mAudioDataByteSize = 512;
	inAQBuffer->mPacketDescriptionCount = 0;
    
	/* queue the updated AudioQueueBuffer */
	AudioQueueEnqueueBuffer(inAQ, inAQBuffer, 0, nil);
    
    /* compute and report elapsed time */
    Float64 elapsed_time = numFrames / kSR;
    [aqp reportElapsedTime:elapsed_time];
}

@implementation AQPlayer

- (void)dealloc {
    
	[self stop];
}

- (id)init
{
    self = [super init];
    
	aqp = self;
    
    for (UInt8 i = 0; i < NUM_VOICES; i++)
    {
        VTarray[i] = [[VoiceTouchPair alloc] init];
    }
	
	//[self start];
    
	return self;
}

-(void)setup
{
	dataFormat.mFormatID = kAudioFormatLinearPCM;
	dataFormat.mFormatFlags = kAudioFormatFlagIsSignedInteger;
	dataFormat.mChannelsPerFrame = 1;
	dataFormat.mSampleRate = kSR;
	dataFormat.mBitsPerChannel = 16;
	dataFormat.mFramesPerPacket = 1;
	dataFormat.mBytesPerPacket = sizeof(SInt16);
	dataFormat.mBytesPerFrame = sizeof(SInt16);
    
    OSStatus result = AudioQueueNewOutput(&dataFormat, AQBufferCallback, nil, nil, nil, 0, &queue);
	
	if (result != noErr)
		NSLog(@"AudioQueueNewOutput %ld\n",result);
	
    for (SInt32 i = 0; i < kNumberBuffers; i++)
	{
		result = AudioQueueAllocateBuffer(queue, 512, &buffers[i]);
		if (result != noErr)
			NSLog(@"AudioQueueAllocateBuffer %ld\n",result);
	}
}

-(OSStatus)start
{
	OSStatus result = noErr;
    
    // if we have no queue, create one now
    if (queue == nil)
        [self setup];
    
    // prime the queue with some data before starting
    for (SInt32 i = 0; i < kNumberBuffers; ++i)
        AQBufferCallback(nil, queue, buffers[i]);            
	
    result = AudioQueueStart(queue, nil);
    
	return result;
}

-(OSStatus)stop
{
	OSStatus result = noErr;
    
    result = AudioQueueStop(queue, true);
	
	return result;
}

-(void)resetStartPos
{
}


-(void)fillAudioBuffer:(Float64*)buffer:(UInt32)num_samples
{
    for (UInt8 i = 0; i < NUM_VOICES; i++)
        if (VTarray[i] != nil)
        {
            Voice* current = [VTarray[i] voice];
            if ((current != nil) && [current isOn])
            {
                BOOL distinct = YES;
                for (UInt8 j = 0; j < i; j++)
                {
                    if (current == [VTarray[j] voice])
                    {
                        distinct = NO;
                        break;
                    }
                }
                if (distinct)
                    [current fillSampleBuffer:buffer:num_samples];           
            }   
        }
    
}


-(void)reportElapsedTime:(Float64)elapsed_time
{
    //    NSLog(@"elapsed time %f",elapsed_time);
    
    [gSing updateTime:elapsed_time];
}



@end
