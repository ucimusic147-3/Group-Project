//
//  Note.h
//  Music147_2012
//
//  Created by Kojiro Umezaki on 5/2/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "Voice.h"

@interface Note : NSObject {
    SInt16 note_num;
    Float64 start_time;
    Float64 duration;
    BOOL on;
    Voice* voice;
}

@property SInt16 note_num;
@property Float64 start_time;
@property Float64 duration;

-(void)updateState:(Float64)now_time;

@end
