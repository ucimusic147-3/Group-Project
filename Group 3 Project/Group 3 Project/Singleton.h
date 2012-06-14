//
//  Singleton.h
//  MySecondApp
//
//  Created by Kojiro Umezaki on 4/11/12.
//  Adapted by Jetpack Dinosaurs 6/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "AQPlayer.h"
#import "AQRecorder.h"


@interface Singleton : NSObject <UIAccelerometerDelegate> {
    
    AQPlayer*   aqp;
    AQRecorder* aqr;
    
}


@end
