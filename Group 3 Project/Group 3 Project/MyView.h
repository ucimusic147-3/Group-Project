//  Sia Mozaffari
// Eric
// Profanity!!!!
// Dennis
//hello dennis
//  MyView.h
//  Music147_2012
//
//  Created by Kojiro Umezaki on 5/2/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Voice_Synth.h"

#define WIDTH 300.
#define HEIGHT 480.
#define KEYWIDTH 60
#define MIDDLE_C 60
#define OCTAVE_STEPS 12  // 12 semitones per octave




@interface MyView : UIView <UIAccelerometerDelegate> {
//    UITouch* touch[NUM_VOICES];
    
    UInt16 referencePixel;
    
//    Voice_Synth* freevoice;
}

-(IBAction)toggleVoice0:(id)sender;
-(IBAction)toggleVoice1:(id)sender;
-(IBAction)toggleVoice2:(id)sender;
-(IBAction)toggleVoice3:(id)sender;

-(UInt8)referenceKey;
-(UInt8)pixelOffset;
-(UInt8)keyOffset:(CGFloat)y;
+(UInt8)toneOffset:(UInt8)base:(UInt8)keyOffset;
-(UInt8)chooseTone:(CGFloat)x:(CGFloat)y;

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event;
- (void)touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event;
- (void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event;
- (void)touchesCancelled:(NSSet *)touches withEvent:(UIEvent *)event;

@end
