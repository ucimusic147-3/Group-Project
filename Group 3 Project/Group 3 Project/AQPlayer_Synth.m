//
//  AQPlayer_Synth.m
//  MySecondApp
//
//  Created by Kojiro Umezaki on 4/18/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "AQPlayer_Synth.h"

#import "Voice_Sine.h"

@implementation AQPlayer_Synth

extern VoiceTouchPair* VTarray[NUM_VOICES]; 


-(id)init
{
    self = [super init];
    
    /*
    for (UInt8 i = 0; i < NUM_VOICES; i++)
    {
    //      Voice_Synth* newvoice = [[Voice_Sine alloc] init];
        [VTarray[i] setVoice:newvoice];

  //      newvoice.freq = [Voice_Synth noteNumToFreq:45+(12*i)];
    }*/
    
   // [voices[2] on];
    
    return self;
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
                for (UInt8 j = 0; j <= i; j++)
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

@end
