//
//  ViewController.h
//  Music147_2012
//
//  Created by Kojiro Umezaki on 4/21/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface ViewController : UIViewController {
    IBOutlet UIViewController* firstViewController;
    IBOutlet UIViewController* secondViewController;
    
}

-(IBAction)loadFirstView:(id)sender;

-(IBAction)loadSecondView:(id)sender;

-(void)clearView;

@end
