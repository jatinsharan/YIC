//
//  OTPViewController.h
//  myClubKart
//
//  Created by Sheetal on 8/5/15.
//  Copyright (c) 2015 Dotsquares. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface OTPassViewController : UIViewController<UITextFieldDelegate,UIAlertViewDelegate>
{
    int timeCount;
    NSTimer *timer;
    NSInteger nextTag;
    NSString *nextStr;
    NSString *strOtp;
    
}
@property (weak, nonatomic) IBOutlet UILabel *timerLbl;
- (IBAction)tapped_continue:(id)sender;
@property (weak, nonatomic) IBOutlet UIScrollView *pageScroll;
@property (strong, nonatomic) IBOutletCollection(UITextField) NSArray *otpTxt;
@property(strong,nonatomic) NSString *strPhoneNo;
-(IBAction)Click_REcivedOtpRetry:(id)sender;
@end
