//  MyView.m
//  Music147_2012
//
//  Created by Kojiro Umezaki on 5/2/12.
//  Extended by Jetpack Dinosaurs 6/12:
//  - Button/Interface Layout by Jonathan Chen
//  - Accelerometer and Slider UI/Functionality by Eric Riggs
//  - Keyboard UI by Dennis Yeh
//
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "MyView.h"

#import "AQPlayer.h"
#import "AQRecorder.h"
#import "Singleton.h"
#import "VoiceTouchPair.h"

extern AQPlayer *aqp;
extern AQRecorder *aqr;
extern VoiceTouchPair* VTarray[NUM_VOICES];
extern enum OutputMode currentMode;


UInt8 const NO_KEY = 255;


@implementation MyView



-(void)awakeFromNib
{
    [[UIAccelerometer sharedAccelerometer] setDelegate:self];
    accelerometerOn = NO;
    referencePixel = 7*KEYWIDTH*5;

}

-(void)accelerometer:(UIAccelerometer *)accelerometer didAccelerate:(UIAcceleration *)acceleration
{
    if ( accelerometerOn )
    {
     if (fabs(acceleration.y) > .1) {
            
        
        Slider.value -= 100*acceleration.y;
        referencePixel = Slider.value;
        for (UInt8 i = 0 ; i < NUM_VOICES ; i++)
        {
            VoiceTouchPair* vt = VTarray[i];
            if (vt != nil && [vt touch] != nil)
            {
                UITouch* t = [vt touch];
                CGPoint pt = [t locationInView:self];
                UInt8 note = [self chooseTone:pt.x:pt.y];
                [VoiceTouchPair setNote:vt:note];
            }
        }
        [self setNeedsDisplay];
        }}
}

-(IBAction)doSlider:(id)sender{
    
    referencePixel = Slider.value;
    [self setNeedsDisplay];
}

-(IBAction)startRec:(id)sender
{
    [aqp stop];
    [aqr start];
}

-(IBAction)stopRec:(id)sender
{
    [aqr stop];
    [aqp start];
}


-(IBAction)sawButton:(id)sender
{    
    [VoiceTouchPair setMode:Saw];
}

-(IBAction)triButton:(id)sender
{
    [VoiceTouchPair setMode:Triangle];
}

-(IBAction)sineButton:(id)sender
{
    [VoiceTouchPair setMode:Sine];
}

-(IBAction)sampleButton:(id)sender
{
    [VoiceTouchPair setMode:Record];
}

-(IBAction)sqrButton:(id)sender
{
    [VoiceTouchPair setMode:Square];
}

-(IBAction)accButton:(id)sender
{
    if (accelerometerOn)
    {
        accelerometerOn = NO;
        [accButton setTitle: @"accOff" forState: UIControlStateNormal];
    }
    else
    { 
        accelerometerOn = YES;
        [accButton setTitle: @"accOn" forState: UIControlStateNormal];
    }
}



- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    
    for (UITouch* t in touches)
    {
        VoiceTouchPair* vtPair = [VoiceTouchPair newTouch:t];
        if (vtPair != nil)
        {
            CGPoint pt = [t locationInView:self];
            UInt8 note = [self chooseTone:pt.x:pt.y];
            [VoiceTouchPair setNote:vtPair:note];
        }
    }
    [self setNeedsDisplay];
}

- (void)touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event
{
    for (UITouch* t in touches)
    {
        for (UITouch* t in touches)
        {
            VoiceTouchPair* vtPair = [VoiceTouchPair findTouch:t];
            if (vtPair != nil)
            {
                CGPoint pt = [t locationInView:self];
                UInt8 note = [self chooseTone:pt.x:pt.y];
                [VoiceTouchPair setNote:vtPair:note];
            }
        }
        [self setNeedsDisplay];
    }
}

- (void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event
{
     for (UITouch* t in touches)
     {
         [VoiceTouchPair killTouch:t];
     }
    [self setNeedsDisplay];
}

- (void)touchesCancelled:(NSSet *)touches withEvent:(UIEvent *)event
{
    for (UITouch* t in touches)
    {
        [VoiceTouchPair killTouch:t];
    }
    [self setNeedsDisplay];
}

-(UInt8)referenceKey
{
    UInt16 octaveWidth = 7*KEYWIDTH;
    UInt8 octave = referencePixel/octaveWidth;
    UInt16 cKeyOffset = (referencePixel % octaveWidth) / KEYWIDTH;  // how many steps above c?
    UInt8 cToneOffset = [MyView toneOffset:0:cKeyOffset];
    return OCTAVE_STEPS*octave + cToneOffset;       // octaves begin on c
}

-(UInt8)pixelOffset
{
    return referencePixel % KEYWIDTH;
}

// how many keys down from the top the screen?
-(UInt8)keyOffset:(CGFloat)x
{
    UInt8 pixoffset = [self pixelOffset];
    UInt16 xInt = (UInt16)x;
    return (xInt+pixoffset)/KEYWIDTH;
}

// how many tones above the base?
// adjust for the half-steps
+(UInt8)toneOffset:(UInt8)base:(UInt8)keyOffset
{
    UInt8 result = 2*keyOffset;
    switch (base%12)
    {
        case 0: // C
            result -= ((keyOffset>=7) + (keyOffset>=3));
            break;
        case 2: // D
            result -= ((keyOffset>=6) + (keyOffset>=2));
            break;
        case 4: // E
            result -= ((keyOffset>=5) + (keyOffset>=1) + (keyOffset>=8));
            break;
        case 5: // F
            result -= ((keyOffset>=7) + (keyOffset>=4));
            break;
        case 7: // G
            result -= ((keyOffset>=6) + (keyOffset>=3));
            break;
        case 9: // A
            result -= ((keyOffset>=5) + (keyOffset>=2));
            break;
        case 11: // B
            result -= ((keyOffset>=4) + (keyOffset>=1) + (keyOffset>=8));
            break;
    }
    return result;
}

-(UInt8)chooseTone:(CGFloat)x:(CGFloat)y
{
    if (x <= 0) return NO_KEY;
    
    UInt8 keyoffset = [self keyOffset:x];  
    
    UInt8 tone = [self referenceKey];
    
    // White keys
    if ( y >= 2*WIDTH/4  && y <= WIDTH )
    {
        return tone + [MyView toneOffset:tone:keyoffset];
    }
    else if ( 0 <= y && y <= 2*WIDTH/4 )   // black key
    {
        keyoffset = [self keyOffset:x+KEYWIDTH/2];
        if (abs( keyoffset*KEYWIDTH - (x+[self pixelOffset])) > KEYWIDTH/4)
        {
            return NO_KEY;
        }
        UInt8 chosenTone = tone + [MyView toneOffset:tone:keyoffset]-1;
        switch (chosenTone % 12) {
            case 11: case 4:
                return NO_KEY;
        }
        return chosenTone;
    }
    return NO_KEY;
}

// 320 X 460
-(void) drawRect:(CGRect)rect
{
    
    UInt8 offset = [self pixelOffset];
    UInt8 thickness = 4;
    
    
    
    // White key borders
    
    [[UIColor blackColor] set];
    for (int i = -offset ; i <= HEIGHT ; i+=KEYWIDTH )
    {
        UIRectFill(CGRectMake(i,0,thickness,WIDTH));
    }
    
    // Highlight touched white key
    for (int i = 0 ; i < NUM_VOICES ; i++ )
    {
    UITouch* touch = [VTarray[i] touch];
    if (touch != nil)
    {
        [[UIColor darkGrayColor] set];
        CGPoint pt = [touch locationInView:self];
        
        if ( pt.y >= 2*WIDTH/4  && pt.y <= WIDTH )
        {
            UIRectFill(CGRectMake([self keyOffset:pt.x]*KEYWIDTH-offset+thickness , 0 ,KEYWIDTH-thickness , WIDTH));
        }
    }
    }
    
    
    
    
    // Black keys    Skip E-F and B-C
    [[UIColor blackColor] set];
    {
        UInt8 key = [self referenceKey];
        for (int x = -offset-KEYWIDTH/4 ; x <= HEIGHT ; x+=KEYWIDTH )
        {  
            switch (key%12)
            {
                case 0: case 5:
                    key+=2;
                    break;
                case 11: case 4:
                    key++;
                    UIRectFill(CGRectMake(x,0,KEYWIDTH/2,2*WIDTH/4));
                    break;
                default:
                    key +=2;
                    UIRectFill(CGRectMake(x,0,KEYWIDTH/2,2*WIDTH/4));
            }
        }
    }
    
    // Highlight touched black key
    for (int i = 0 ; i < NUM_VOICES ; i++ )
    {
    UITouch* touch = [VTarray[i] touch];
    if (touch != nil && [VTarray[i] voice] != nil)
    {
        [[UIColor lightGrayColor] set];
        CGPoint pt = [touch locationInView:self];
        
        if (0 <= pt.y && pt.y <= 2*WIDTH/4)
        {
            UInt8 keyoffset = [self keyOffset:pt.x+KEYWIDTH/2];
            UIRectFill(CGRectMake(keyoffset*KEYWIDTH-offset-KEYWIDTH/4,0,KEYWIDTH/2,2*WIDTH/4));
        }
    }
    }
     
}

@end
