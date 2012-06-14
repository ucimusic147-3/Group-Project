//
//  Singleton.m
//  MySecondApp
//
//  Created by Kojiro Umezaki on 4/11/12.
//  Adapted by Jetpack Dinosaurs 6/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "Singleton.h"
#import "AQPlayer.h"

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

@end
