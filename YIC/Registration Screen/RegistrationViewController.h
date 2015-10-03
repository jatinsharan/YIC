//
//  RegistrationViewController.h
//  CL-YIC
//
//  Created by Jatin on 9/5/15.
//
//

#import <UIKit/UIKit.h>
#import "PPPinPadViewController.h"


@interface RegistrationViewController : UIViewController<UITextFieldDelegate,UIPickerViewDataSource,UIPickerViewDelegate,PinPadPasswordProtocol>
{
    IBOutlet UITextField *lblName;
    IBOutlet UITextField *lblEmail;
    IBOutlet UITextField *lblNumber;
    IBOutlet UITextField *lblAddress;
    IBOutlet UITextField *lblCourse;
    
    IBOutlet UIButton *btnCity;
    IBOutlet UIButton *btnCollage;
    IBOutlet UIButton *btnSem;
    
    NSArray *arrCity;
    NSArray *arrSem;
    NSArray *arrCollage;
    IBOutlet UIPickerView *pickerReg;
    IBOutlet UIView *vwReg;
    
    NSString *strBtnSelection;
    NSString *strCityId;
}
- (IBAction)Click_City:(id)sender;
- (IBAction)Click_Collage:(id)sender;
- (IBAction)Click_Sem:(id)sender;
- (IBAction)Click_Submit:(id)sender;


@end
