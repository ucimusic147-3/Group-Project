//
//  VoiceTouchPair.m
//  Group 3 Project
//
//  Created by Lab User on 6/11/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "VoiceTouchPair.h"

VoiceTouchPair* VTarray[NUM_VOICES];
static enum OutputMode currentMode = Sine;

@implementation VoiceTouchPair

@synthesize touch;
@synthesize voice;

+(void)setMode:(enum OutputMode)m
{
    if (currentMode == m)
        return;
    currentMode = m;
    for (UInt16 i = 0; i < NUM_VOICES; i++)
    {
        Voice* v = [VTarray[i] voice];
        if (v != nil)
        {
            [v off];
            [VTarray[i] setVoice:nil];
        }
    }
}

+(VoiceTouchPair*)newTouch:(UITouch*)t
{
    for (UInt16 i = 0; i < NUM_VOICES; i++)
        if ([VTarray[i] touch] == nil)
        {
            [VTarray[i] setTouch:t];
            return VTarray[i];
        }
    return nil;
}

+(VoiceTouchPair*)findTouch:(UITouch*)t
{
    for (UInt16 i = 0; i < NUM_VOICES; i++)
        
        if ([VTarray[i] touch] == t)
        {
            return VTarray[i];
        }
    return nil;
}

+(Voice*)findVoice:(UInt8)midi
{
    for (int i=0; i<NUM_VOICES; i++ )
    {
        VoiceTouchPair* vt = VTarray[i];
        if (vt != nil && [vt voice] != nil && [[vt voice] note] == midi)
        {
            return [vt voice];
        }
    }
    return nil;
}


+(Voice*)makeVoice:(UInt8)midi
{
    switch (currentMode)
    {
        case Sine:
            return [[Voice_Sine alloc] initWithNote:midi];
        case File:
            return [[Voice_SF alloc] initWithNote:midi];
    }
}


+(void)setNote:(VoiceTouchPair*)vt : (UInt8)midi
{
    Voice* myvoice = [vt voice];
    if (myvoice != nil)
    {
        if ([myvoice note] == midi)
        {
            return;
        }
        else
        {
            [myvoice off];
            // possible memory leak when too many notes are played, but ObjC prohibits release because automatic reference counting is on.
            //            if (![myvoice isOn])
            //               [myvoice release];
        }
    }
    
    if (midi == NO_KEY)
    {
        [vt setVoice:nil];
        return;
    }   
    
    Voice* result = [self findVoice:midi];
    
    if (result == nil) 
    {
        Voice* newvoice = [self makeVoice:midi];
        [vt setVoice:newvoice];
    }
    else
    {
        [vt setVoice:result];
        [result on];
    }
}

+(void)killTouch:(UITouch*)t
{
    for (UInt16 i = 0; i < NUM_VOICES; i++)
    {
        if ([VTarray[i] touch] == t)
        {
            [VTarray[i] setTouch:nil];
            
            Voice* v = [VTarray[i] voice];
            if (v != nil)
            {
                [v off];
                // possible memory leak when too many notes are played, but ObjC prohibits release because automatic reference counting is on.
                //              if (![v isOn])
                //                   [v release];
            }
            [VTarray[i] setVoice:nil];
        }
    }
}

@end
