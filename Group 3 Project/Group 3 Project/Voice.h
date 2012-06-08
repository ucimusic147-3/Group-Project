//
//  Voice.h
//  Music147_2012
//
//  Created by Kojiro Umezaki on 4/25/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
/* number of voice */
#define NUM_VOICES   10

extern UInt8 const NO_KEY;

@interface Voice : NSObject {
    UInt8 onCount;

}

@property UInt8 note;


-(void)fillSampleBuffer:(Float64*)buffer:(UInt32)num_samples;
-(id)initWithNote:(UInt8)n;
-(BOOL)isOn;
-(void)on;
-(void)off;

@end
