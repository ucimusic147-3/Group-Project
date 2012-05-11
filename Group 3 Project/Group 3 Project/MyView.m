//
//  MyView.m
//  Music147_2012
//
//  Created by Kojiro Umezaki on 5/2/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "MyView.h"

#import "AQPlayer.h"

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
    NSLog(@"toggleVoice0");
    [aqp voiceToggle:0];
}

-(IBAction)toggleVoice1:(id)sender
{
    NSLog(@"toggleVoice1");
    [aqp voiceToggle:1];
}

-(IBAction)toggleVoice2:(id)sender
{
    NSLog(@"toggleVoice2");
    [aqp voiceToggle:2];
}

-(IBAction)toggleVoice3:(id)sender
{
    NSLog(@"toggleVoice3");
    [aqp voiceToggle:3];
}

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    NSLog(@"%d",touches.count);
    for (UITouch* t in touches)
    {
        CGPoint pt = [t locationInView:self];
        NSLog(@"%lf,%lf",pt.x,pt.y);
    }
    NSLog(@"%lf",event.timestamp);
}

- (void)touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event
{
    NSLog(@"%d",touches.count);
    for (UITouch* t in touches)
    {
        CGPoint pt = [t locationInView:self];
        NSLog(@"%lf,%lf",pt.x,pt.y);
    }
    NSLog(@"%lf",event.timestamp);
}

- (void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event
{
    NSLog(@"%d",touches.count);
    for (UITouch* t in touches)
    {
        CGPoint pt = [t locationInView:self];
        NSLog(@"%lf,%lf",pt.x,pt.y);
    }
    NSLog(@"%lf",event.timestamp);
}

- (void)touchesCancelled:(NSSet *)touches withEvent:(UIEvent *)event
{
}

@end
