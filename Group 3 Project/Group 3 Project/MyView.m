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

extern AQPlayer *aqp;

@implementation MyView

UInt8 const NO_KEY = 255;

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
    }
    return self;
}

/*
 // Only override drawRect: if you perform custom drawing.
 // An empty implementation adversely affects performance during animation.
 - (void)drawRect:(CGRect)rect
 {
 // Drawing code
 }
 */

-(IBAction)toggleVoice0:(id)sender
{
    //   NSLog(@"toggleVoice0");
    //   [aqp voiceToggle:0];
    referencePixel -= 15;
    [self setNeedsDisplay];
}


-(IBAction)toggleVoice1:(id)sender
{
    //   NSLog(@"toggleVoice1");
    
    referencePixel = 7*KEYWIDTH*5;
    [self setNeedsDisplay];
}

-(IBAction)toggleVoice2:(id)sender
{
    //   NSLog(@"toggleVoice2");
}

-(IBAction)toggleVoice3:(id)sender
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
        CGPoint pt = [t locationInView:self];
        if ( 0 <= pt.x && pt.x <= WIDTH )
        {
            UInt8 note = [self chooseTone:pt.x:pt.y];
            if ( note != NO_KEY )
            {
                touch = t;
                if (freevoice == nil)
                {
                    freevoice = (Voice_Synth*)[aqp getFreeVoice];
                }
                [aqp setVoiceNote:freevoice:note];
                [freevoice on];
            }
            //        NSLog(@"%d , %d", note , referencePixel);
        }             
        
        
    }
    
    
    [self setNeedsDisplay];
    //   NSLog(@"%lf",event.timestamp);
    
    
}

- (void)touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event
{
    for (UITouch* t in touches)
    {
        CGPoint pt = [t locationInView:self];
        if ( 0 <= pt.x && pt.x <= WIDTH )
        {
            UInt8 note = [self chooseTone:pt.x:pt.y];
            if ( note != NO_KEY )
            {
                touch = t;
                if (freevoice == nil)
                {
                    freevoice = (Voice_Synth*)[aqp getFreeVoice];
                }
                [aqp setVoiceNote:freevoice:note];
                [freevoice on];
            }
            else
            {
                [freevoice off];
                freevoice = nil;
                touch = nil;
                
            }
        }
    }
    [self setNeedsDisplay];
    //   NSLog(@"%lf",event.timestamp);
    
}

- (void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event
{
    /*
     NSLog(@"%d",touches.count);
     for (UITouch* t in touches)
     {
     CGPoint pt = [t locationInView:self];
     NSLog(@"%lf,%lf",pt.x,pt.y);
     }
     NSLog(@"%lf",event.timestamp);
     */
    [freevoice off];
    freevoice = nil;
    touch = nil;
    [self setNeedsDisplay];
}

- (void)touchesCancelled:(NSSet *)touches withEvent:(UIEvent *)event
{
}

-(UInt8)referenceKey
{
    UInt16 octaveWidth = 7*KEYWIDTH;
    UInt8 octave = referencePixel/octaveWidth;
    UInt16 cKeyOffset = (referencePixel % octaveWidth) / KEYWIDTH;  // how many steps above c?
    UInt8 cToneOffset = [MyView toneOffset:0:cKeyOffset];
    NSLog(@"octave %d cKeyoffset %d ctoneoffset %d" , octave , cKeyOffset , cToneOffset);
    return OCTAVE_STEPS*octave + cToneOffset;       // octaves begin on c
}

-(UInt8)pixelOffset
{
    return referencePixel % KEYWIDTH;
}

// how many keys down from the top the screen?
-(UInt8)keyOffset:(CGFloat)y
{
    UInt8 pixoffset = [self pixelOffset];
    UInt16 yInt = (UInt16)y;
    return (yInt+pixoffset)/KEYWIDTH;
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
    if (y <= 0) return NO_KEY;
    
    UInt8 keyoffset = [self keyOffset:y];  
    
    UInt8 tone = [self referenceKey];
    
    // White keys
    if ( 0 <= x && x <= WIDTH/3 )
    {
        return tone + [MyView toneOffset:tone:keyoffset];
    }
    else if ( x >= WIDTH/3  && x <= WIDTH )   // black key
    {
        keyoffset = [self keyOffset:y+KEYWIDTH/2];
        if (abs( keyoffset*KEYWIDTH - (y+[self pixelOffset])) > KEYWIDTH/4)
        {
            return NO_KEY;
        }
        NSLog(@"black key!");
        UInt8 chosenTone = tone + [MyView toneOffset:tone:keyoffset]-1;
        switch (chosenTone % 12) {
            case 11: case 4:
                return NO_KEY;
        }
        return chosenTone;
    }
}   // Ignore warning

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
        UIRectFill(CGRectMake(0,i,WIDTH,thickness));
    }
    
    // Highlight touched white key
    if (touch != nil)
    {
        [[UIColor darkGrayColor] set];
        CGPoint pt = [touch locationInView:self];
        
        if (0 <= pt.x && pt.x <= WIDTH/3)
        {
            UIRectFill(CGRectMake(0, [self keyOffset:pt.y]*KEYWIDTH-offset+thickness ,WIDTH,KEYWIDTH-thickness));
        }
    }
    
    
    
    
    // Black keys    Skip E-F and B-C
    [[UIColor blackColor] set];
    {
        UInt8 key = [self referenceKey];
        for (int y = -offset-KEYWIDTH/4 ; y <= HEIGHT ; y+=KEYWIDTH )
        {  
            switch (key%12)
            {
                case 0: case 5:
                    key+=2;
                    break;
                case 11: case 4:
                    key++;
                    UIRectFill(CGRectMake(WIDTH/3,y,2*WIDTH/3,KEYWIDTH/2));
                    break;
                default:
                    key +=2;
                    UIRectFill(CGRectMake(WIDTH/3,y,2*WIDTH/3,KEYWIDTH/2));
            }
        }
    }
    
    // Highlight touched black key
    if (touch != nil)
    {
        [[UIColor lightGrayColor] set];
        CGPoint pt = [touch locationInView:self];
        
        if (WIDTH/3 <= pt.x && pt.x <= WIDTH)
        {
            UInt8 keyoffset = [self keyOffset:pt.y+KEYWIDTH/2];
            UIRectFill(CGRectMake(WIDTH/3, keyoffset*KEYWIDTH-offset-KEYWIDTH/4,2*WIDTH/3,KEYWIDTH/2));
        }
    }
}

@end
