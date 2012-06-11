//
//  VoiceTouchPair.h
//  Group 3 Project
//
//  Created by Lab User on 6/11/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "Voice_Synth.h"

@interface VoiceTouchPair : NSObject
@property (nonatomic,strong) UITouch* touch;
@property (nonatomic,strong) Voice* voice;
@end
