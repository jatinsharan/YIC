//
//  HomeViewController.h
//  CL-YIC
//
//  Created by Jatin on 9/3/15.
//
//

#import <UIKit/UIKit.h>

@interface HomeViewController : UIViewController {
    IBOutlet UIButton *btnSync;
}

- (IBAction)Click_YICRounds:(id)sender;
- (IBAction)Click_Notifications:(id)sender;
- (IBAction)Click_TakeTest:(id)sender;
- (IBAction)Click_Share:(id)sender;
- (IBAction)Click_Sync:(id)sender;

@end
