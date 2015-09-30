//
//  OTPViewController.h
//  myClubKart
//
//  Created by Sheetal on 8/5/15.
//  Copyright (c) 2015 Dotsquares. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UnlockViewController : UIViewController<UITextFieldDelegate,UIAlertViewDelegate>
{
    int timeCount;
    NSTimer *timer;
    int nextTag;
    NSString *nextStr;
    
    
}
@property (weak, nonatomic) IBOutlet UILabel *timerLbl;
- (IBAction)tapped_continue:(id)sender;
@property (weak, nonatomic) IBOutlet UIScrollView *pageScroll;

@property (strong, nonatomic) IBOutletCollection(UITextField) NSArray *otpTxt;
@property(strong,nonatomic) NSString *strPhoneNo;
@end
