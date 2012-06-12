//  Sia Mozaffari
//  MyView.m
//  Music147_2012
//
//  Created by Kojiro Umezaki on 5/2/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "MyView.h"

#import "AQPlayer.h"

#import "Singleton.h"
#import "VoiceTouchPair.h"

extern AQPlayer *aqp;
extern VoiceTouchPair* VTarray[NUM_VOICES];
extern enum OutputMode currentMode;


UInt8 const NO_KEY = 255;


@implementation MyView


/*
- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [[UIAccelerometer sharedAccelerometer] setDelegate:self];
        NSLog(@"hello myview");
    }
    return self;
}
*/

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
       NSLog(@"accelerometer!  %f %f %f",acceleration.x,acceleration.y,acceleration.z);
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
            //        NSLog(@"Began (%f , %f)", pt.x , pt.y);
        }
        [self setNeedsDisplay];
        }}
}

-(IBAction)doSlider:(id)sender{
    
    referencePixel = Slider.value;
    [self setNeedsDisplay];
}


-(IBAction)button1:(id)sender
{
    //   NSLog(@"toggleVoice0");
    //   [aqp voiceToggle:0];
    referencePixel -= 15;
    [self setNeedsDisplay];
    
}


-(IBAction)button2:(id)sender
{
    [VoiceTouchPair setMode:Sine];
}

-(IBAction)button3:(id)sender
{
    [VoiceTouchPair setMode:File];
}

-(IBAction)button4:(id)sender
{
    //   NSLog(@"toggleVoice2");
    if (accelerometerOn)
        accelerometerOn = NO;
    else 
        accelerometerOn = YES;
}

-(IBAction)button5:(id)sender
{
    //   NSLog(@"toggleVoice3");
    referencePixel+=15;
    [self setNeedsDisplay];
}

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    //   NSLog(@"%d",touches.count);
    
    for (UITouch* t in touches)
    {
        VoiceTouchPair* vtPair = [VoiceTouchPair newTouch:t];
        if (vtPair != nil)
        {
            CGPoint pt = [t locationInView:self];
            UInt8 note = [self chooseTone:pt.x:pt.y];
            [VoiceTouchPair setNote:vtPair:note];
        }
//        NSLog(@"Began (%f , %f)", pt.x , pt.y);
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
            //        NSLog(@"Began (%f , %f)", pt.x , pt.y);
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
 //   NSLog(@"octave %d cKeyoffset %d ctoneoffset %d" , octave , cKeyOffset , cToneOffset);
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
    if ( y >= 2*WIDTH/3  && y <= WIDTH )
    {
        return tone + [MyView toneOffset:tone:keyoffset];
    }
    else if ( 0 <= y && y <= 2*WIDTH/3 )   // black key
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
    //   UIColor *rectColor = [UIColor greenColor]; [rectColor set];
    //   CGPoint pt = [touch locationInView:self];
    //   UIRectFill(CGRectMake(0,0,width,height));  fillBG
    
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
        
        if ( pt.y >= 2*WIDTH/3  && pt.y <= WIDTH )
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
                    UIRectFill(CGRectMake(x,0,KEYWIDTH/2,2*WIDTH/3));
                    break;
                default:
                    key +=2;
                    UIRectFill(CGRectMake(x,0,KEYWIDTH/2,2*WIDTH/3));
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
        
        if (0 <= pt.y && pt.y <= 2*WIDTH/3)
        {
            UInt8 keyoffset = [self keyOffset:pt.x+KEYWIDTH/2];
            UIRectFill(CGRectMake(keyoffset*KEYWIDTH-offset-KEYWIDTH/4,0,KEYWIDTH/2,2*WIDTH/3));
        }
    }
    }
     
}

@end
