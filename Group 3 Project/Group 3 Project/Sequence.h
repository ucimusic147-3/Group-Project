//
//  Sequence.h
//  Music147_2012
//
//  Created by Kojiro Umezaki on 5/2/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "Note.h"

#define kNumSeqNotes 32

@interface Sequence : NSObject {
    Note* notes[kNumSeqNotes];
}
    
-(Note*)getNote:(UInt32)note_pos;

@end
