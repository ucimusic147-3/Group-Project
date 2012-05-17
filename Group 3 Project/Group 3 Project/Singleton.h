//
//  Singleton.h
//  MySecondApp
//
//  Created by Kojiro Umezaki on 4/11/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "AQPlayer.h"
#import "Sequencer.h"


@interface Singleton : NSObject <UIAccelerometerDelegate> {
    
    AQPlayer*   aqp;
    
    Sequencer*  q;
    
    UInt16 noteNum;
}

-(void)updateTime:(Float64)elapsed_time;

@end
