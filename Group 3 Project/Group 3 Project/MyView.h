//  MyView.h
//  Music147_2012
//
//  Created by Kojiro Umezaki on 5/2/12.
//  Extended by Jetpack Dinosaurs 6/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

#define WIDTH 380.
#define HEIGHT 480.
#define KEYWIDTH 60
#define MIDDLE_C 60
#define OCTAVE_STEPS 12  // 12 semitones per octave




@interface MyView : UIView <UIAccelerometerDelegate> {

    
    UInt16 referencePixel;
    
    BOOL accelerometerOn;
    
    IBOutlet UISlider *Slider;
    IBOutlet UIButton *accButton;
}

-(IBAction)startRec:(id)sender;
-(IBAction)stopRec:(id)sender;

-(IBAction)doSlider:(id)sender;
-(IBAction)sineButton:(id)sender;
-(IBAction)sampleButton:(id)sender;
-(IBAction)sqrButton:(id)sender;
-(IBAction)triButton:(id)sender;
-(IBAction)accButton:(id)sender;

// Leftmost visible key (midi)
-(UInt8)referenceKey;
// How many pixels off the left edge is the leftmost key?
-(UInt8)pixelOffset;
// How many keys away from reference key is y pixel coordinate?
-(UInt8)keyOffset:(CGFloat)y;
// How many semitones away from base is keyOffset?
+(UInt8)toneOffset:(UInt8)base:(UInt8)keyOffset;
// Map x,y to a tone (midi)
-(UInt8)chooseTone:(CGFloat)x:(CGFloat)y;

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event;
- (void)touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event;
- (void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event;
- (void)touchesCancelled:(NSSet *)touches withEvent:(UIEvent *)event;

@end
