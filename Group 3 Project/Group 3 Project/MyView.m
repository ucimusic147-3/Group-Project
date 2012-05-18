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
     [aqp setVoiceNote:MIDDLE_C+2];
    referencePixel = 8*KEYWIDTH*5;
}

-(IBAction)toggleVoice2:(id)sender
{
 //   NSLog(@"toggleVoice2");
    [aqp setVoiceNote:MIDDLE_C+4];
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
        if ( 0 <= pt.x && pt.x <= WIDTH/2 ) // white key
        {
            UInt8 note = [self chooseTone:pt.x:pt.y];
            freevoice = [aqp setVoiceNote:note];
            [freevoice on];
            NSLog(@"%d , %d", note , referencePixel);
        }
        else if ( pt.x <= WIDTH/2  && pt.x <= WIDTH )   // black key
        {
            
        }
             
        //NSLog(@"%lf,%lf",pt.x,pt.y);
       // y = pt.y;
        touch = t;
        
    }
    
    
    [self setNeedsDisplay];
 //   NSLog(@"%lf",event.timestamp);
 
    
}

- (void)touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event
{
  /*  NSLog(@"%d",touches.count);
    for (UITouch* t in touches)
    {
        CGPoint pt = [t locationInView:self];
        NSLog(@"%lf,%lf",pt.x,pt.y);
    }
    NSLog(@"%lf",event.timestamp);
   */
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
    touch = nil;
    [self setNeedsDisplay];
}

- (void)touchesCancelled:(NSSet *)touches withEvent:(UIEvent *)event
{
}

-(UInt8)referenceKey
{
    UInt16 octaveWidth = 8*KEYWIDTH;
    UInt8 octave = referencePixel/octaveWidth;
    UInt16 cKeyOffset = (referencePixel % octaveWidth) / KEYWIDTH;  // how many keys above c?
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
            result -= ((keyOffset>=5) + (keyOffset>=1));
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
            result -= ((keyOffset>=4) + (keyOffset>=1));
            break;
    }
    return result;
}

-(UInt8)chooseTone:(CGFloat)x:(CGFloat)y
{
    UInt8 keyoffset = [self keyOffset:y];  
    
    UInt8 tone = [self referenceKey];
    
    // White keys
    if ( 0 <= x && x <= WIDTH/2 )
    {
        tone += [MyView toneOffset:tone:keyoffset];
    }
    else if ( x <= WIDTH/2  && x <= WIDTH )   // black key
    {
        
    }
    return tone;
}

// 320 X 460
-(void) drawRect:(CGRect)rect
{
 //   UIColor *rectColor = [UIColor greenColor]; [rectColor set];
 //   CGPoint pt = [touch locationInView:self];
 //   UIRectFill(CGRectMake(0,0,width,height));  fillBG

    UInt8 offset = [self pixelOffset];

    
    // White key borders
    [[UIColor blackColor] set];
    for (int i = KEYWIDTH-offset ; i <= HEIGHT ; i+=KEYWIDTH )
    {
        UIRectFill(CGRectMake(0,i,WIDTH,4));
    }
    
    // Black keys
    {
        
    }
    
    
    // Highlight touched key
    if (touch != nil)
    {
        CGPoint pt = [touch locationInView:self];
        
        
        
        [[UIColor lightGrayColor] set];
        
        UIRectFill(CGRectMake(0, [self keyOffset:pt.y]*KEYWIDTH-offset ,WIDTH/2,KEYWIDTH));
     //   NSLog(@"%d" , ((UInt16)pt.y)/KEYWIDTH*KEYWIDTH);
    }
}

@end
