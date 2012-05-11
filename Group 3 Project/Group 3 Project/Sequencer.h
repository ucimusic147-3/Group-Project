//
//  Sequencer.h
//  Music147_2012
//
//  Created by Kojiro Umezaki on 5/2/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Sequence.h"

@interface Sequencer : NSObject {
    Sequence* seq;
    Float64 now_time;
    Float64 bpm;
}

-(void)setSeq:(Sequence*)_seq;
-(void)setBpm:(Float64)_bpm;
-(void)updateTime:(Float64)elapsed_time;

@end
