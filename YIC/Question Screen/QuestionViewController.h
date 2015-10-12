//
//  QuestionViewController.h
//  YIC
//
//  Created by Jatin on 9/30/15.
//
//

#import <UIKit/UIKit.h>
#import "QuestionYIC.h"

@interface QuestionViewController : UIViewController
{
    int countDownTime ;
    int secs;
    int mints;
    int hourss;
    
    IBOutlet UILabel *lblSectionHeading;
    IBOutlet UILabel *lblQuestionCount;
    
    IBOutlet UILabel *lblQuestion;
    IBOutlet UILabel *lblInstruction;

    IBOutlet UIButton *btnOption1;
    IBOutlet UIButton *btnOption2;
    IBOutlet UIButton *btnOption3;
    IBOutlet UIButton *btnOption4;
    
    int questionCount;
    QuestionYIC *question;
    NSArray *arrQuestion;
    NSMutableDictionary *dictAnsweredQuestion;
    
    NSString *correctOption;
    
    IBOutlet UILabel *lblPrev;
    IBOutlet UILabel *lblNext;
    
    IBOutlet UIButton *btnPrevious;
    IBOutlet UIButton *btnNext;
    IBOutlet UIButton *btnBack;
    
    IBOutlet UIView *viewInstruction;
    IBOutlet UIView *viewQuestion;
    IBOutlet UIScrollView *scrlMain;    
}

- (IBAction)Select_Option:(id)sender;
- (IBAction)Click_NextQuestion:(id)sender;
- (IBAction)Click_PreviousQuestion:(id)sender;

@property (strong, nonatomic) IBOutlet UILabel *lbl;
@property(retain,nonatomic)NSTimer *CountDownTimer;

@end
