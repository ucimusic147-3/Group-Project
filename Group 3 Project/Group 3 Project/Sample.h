//
//  Sample.h
//  Music147_2012
//
//  Created by Kojiro Umezaki on 5/30/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Sample : NSObject

-(void)resetStartPos;

/* calling this will read the next buffer of samples */
-(void)fillSampleBuffer:(Float64*)buffer:(UInt32)num_buf_samples;

@end
