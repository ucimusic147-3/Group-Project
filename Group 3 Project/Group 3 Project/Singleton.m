//
//  Singleton.m
//  MySecondApp
//
//  Created by Kojiro Umezaki on 4/11/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "Singleton.h"
#import "AQPlayer.h"
#import "AQPlayer_Samp.h"
#import "AQPlayer_Synth.h"

@implementation Singleton

-(id)init
{
    self = [super init];
    
    NSLog(@"Initializing Singleton object.");
    
    aqp = [[AQPlayer alloc] init];
    aqr = [[AQRecorder alloc] init];
    
    
    return self;
}

-(void)dealloc
{
}

-(void)updateTime:(Float64)elapsed_time
{
  //  [q updateTime:elapsed_time];
}

/*
-(void)accelerometer:(UIAccelerometer *)accelerometer didAccelerate:(UIAcceleration *)acceleration
{
    NSLog(@"%f %f %f",acceleration.x,acceleration.y,acceleration.z);
}*/

@end
