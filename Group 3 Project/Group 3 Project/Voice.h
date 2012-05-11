//
//  Voice.h
//  Music147_2012
//
//  Created by Kojiro Umezaki on 4/25/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Voice : NSObject {
    BOOL on;
    Float64 amp;
}

@property Float64 amp;

-(void)fillSampleBuffer:(Float64*)buffer:(UInt32)num_samples;

-(BOOL)isOn;
-(void)on;
-(void)off;

@end
