//
//  QuestionViewController.m
//  YIC
//
//  Created by Jatin on 9/30/15.
//
//

#import "QuestionViewController.h"
#import "ResultViewController.h"
#import <Foundation/Foundation.h>
#import <sqlite3.h>
#import "GlobalDataPersistence.h"
#import "DBManagerYIC.h"
#import "QuestionYIC.h"
#import "WebCommunicationClass.h"

@interface QuestionViewController () {
    GlobalDataPersistence *obj_GlobalDataPersistence;
}

@end

@implementation QuestionViewController

- (void)viewDidLoad {
    
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    DBManagerYIC *obj_DBManagerYIC = [DBManagerYIC new];
    
    arrQuestion = [obj_DBManagerYIC getAllRandomQuestion];
    
    question = [QuestionYIC new];
    
    questionCount=0;
    correctOption = @"";
    [self setCurrentQuestion];
    
    btnBack.hidden = YES;
    
    obj_GlobalDataPersistence = [GlobalDataPersistence sharedGlobalDataPersistence];
    obj_GlobalDataPersistence.correctPoint = 0;
    
    [KUSER_DEFAULT setBool:TRUE forKey:KIS_TEST_ATTEMPTED];
    [KUSER_DEFAULT synchronize];
    
    dictAnsweredQuestion = [NSMutableDictionary dictionary];
    for (int i=0; i<arrQuestion.count; i++) {
        [dictAnsweredQuestion setObject:@"N" forKey:[NSNumber numberWithInt:i]];
    }
    
    secs = 00;
    mints = 58;
    hourss = 23;
    countDownTime = 3000;
    
    _CountDownTimer =  [NSTimer scheduledTimerWithTimeInterval:1
                                                        target:self
                                                      selector:@selector(DecrementCounterValue)
                                                      userInfo:nil
                                                       repeats:YES];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)DecrementCounterValue
{
    NSLog(@"COUNTDOWN >>> %d",(3000-countDownTime));
    
    if(countDownTime > 0)
    {
        int sec = countDownTime%60;
        int min =(countDownTime / 60)%60;
        
        if (mints == min && sec==secs)
        {
            UIAlertView *alert =[[UIAlertView alloc]initWithTitle:@"Worning" message:@"Time Up!" delegate:nil cancelButtonTitle:@"Ok" otherButtonTitles:nil, nil];
            [alert show];
            [self InvalidateCountDownTimer];
        }
        else
        {
            self.lbl.text=[NSString stringWithFormat:@"%02d:%02d",min,sec];
        }
        
        countDownTime--;
    }
    else
    {
        self.lbl.text = @"00:00";
        
        UIAlertView *alert =[[UIAlertView alloc]initWithTitle:@"Worning" message:@"Time Up!" delegate:nil cancelButtonTitle:@"Ok" otherButtonTitles:nil, nil];
        [alert show];
        [self InvalidateCountDownTimer];
    }
}


-(void)InvalidateCountDownTimer
{
    if ([_CountDownTimer isValid]) {
        [_CountDownTimer invalidate];
        
    }
    
    _CountDownTimer=nil;
}

#pragma mark Class functions

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

- (IBAction)Click_NextQuestion:(id)sender {
    
    if ( correctOption == nil || correctOption.length==0 || [correctOption isEqualToString:@""]) {
        // No Option selected, display alert
        UIAlertView *alert =[[UIAlertView alloc]initWithTitle:@"" message:@"You need to select an option to proceed!" delegate:nil cancelButtonTitle:@"Ok" otherButtonTitles:nil, nil];
        [alert show];
    }
    else {
        
        if(questionCount<[arrQuestion count]-1)
        {
            if (![[dictAnsweredQuestion objectForKey:[NSNumber numberWithInt:questionCount]] isEqualToString:@"Y"]) {
                [self submitAnswer]; // This is imp.
            }
            
            questionCount++;
            [self setCurrentQuestion];
        }
        else
        {
            [_CountDownTimer invalidate];
            _CountDownTimer=nil;
            
            [KUSER_DEFAULT setInteger:3000-countDownTime forKey:KTIME_TAKEN];
            [KUSER_DEFAULT setInteger:obj_GlobalDataPersistence.correctPoint forKey:KTIME_TAKEN];
            
            // Question complete, move to Result screen
            
            ResultViewController *obj_ResultViewController=[ResultViewController new];
            [self.navigationController pushViewController:obj_ResultViewController animated:YES];
        }
    }
}

- (IBAction)Click_PreviousQuestion:(id)sender {
    
    if(questionCount>0)
    {
        questionCount--;
        [self setCurrentQuestion];
    }
}

- (IBAction)Select_Option:(UIButton*)sender {
    
    if(sender.tag==0)
    {
        correctOption=@"A";
        [btnOption1 setSelected:YES];
        [btnOption2 setSelected:NO];
        [btnOption3 setSelected:NO];
        [btnOption4 setSelected:NO];
    }
    else if(sender.tag==1)
    {
        correctOption=@"B";
        [btnOption2 setSelected:YES];
        [btnOption1 setSelected:NO];
        [btnOption3 setSelected:NO];
        [btnOption4 setSelected:NO];
    }
    else if(sender.tag==2)
    {
        correctOption=@"C";
        [btnOption1 setSelected:NO];
        [btnOption2 setSelected:NO];
        [btnOption3 setSelected:YES];
        [btnOption4 setSelected:NO];
    }
    else if(sender.tag==3)
    {
        correctOption=@"D";
        [btnOption1 setSelected:NO];
        [btnOption2 setSelected:NO];
        [btnOption3 setSelected:NO];
        [btnOption4 setSelected:YES];
    }
    
    [dictAnsweredQuestion setObject:correctOption forKey:[NSNumber numberWithInt:questionCount]];
}

-(IBAction)click_back:(id)sender
{
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)setCurrentQuestion
{
    // This is a generic func. which is using repeteadly
    
    if (questionCount==0) {
        btnPrevious.hidden = YES;
        lblPrev.hidden = YES;
    }
    else {
        btnPrevious.hidden = NO;
        lblPrev.hidden = NO;
    }
    
    if (questionCount==44)
        lblNext.text = @"Submit";
    
    if (questionCount<40) {
        
        CGRect frame1 = viewQuestion.frame;
        frame1.origin.y = 8;
        viewQuestion.frame = frame1;

        viewInstruction.hidden = YES;
        
        CGSize screenSize = [UIScreen mainScreen].bounds.size;
        [scrlMain setContentSize:CGSizeMake(screenSize.width, 270)];
    }
    else {
        
        CGRect frame1 = viewQuestion.frame;
        frame1.origin.y = 396;
        viewQuestion.frame = frame1;

        viewInstruction.hidden = NO;
        
        CGSize screenSize = [UIScreen mainScreen].bounds.size;
        [scrlMain setContentSize:CGSizeMake(screenSize.width, 658)];
    }
    
    question=[arrQuestion objectAtIndex:questionCount];
    NSLog(@"%@",question.qCorrectOption);
    
    if (questionCount<20) {
        lblSectionHeading.text=[NSString stringWithFormat:@"Section 1:%@",question.qSection];
    }
    else if (questionCount<40) {
        lblSectionHeading.text=[NSString stringWithFormat:@"Section 2:%@",question.qSection];
    }
    else {
        lblSectionHeading.text=[NSString stringWithFormat:@"Section 3:%@",question.qSection];
    }

    lblQuestionCount.text=[NSString stringWithFormat:@"%d",questionCount+1];
    
    lblQuestion.text = question.qQuestion;
    lblInstruction.text = question.qInstruction;

    [btnOption1 setTitle:[NSString stringWithFormat:@"%@",question.qOption_1] forState:UIControlStateNormal];
    [btnOption2 setTitle:[NSString stringWithFormat:@"%@",question.qOption_2] forState:UIControlStateNormal];
    [btnOption3 setTitle:[NSString stringWithFormat:@"%@",question.qOption_3] forState:UIControlStateNormal];
    [btnOption4 setTitle:[NSString stringWithFormat:@"%@",question.qOption_4] forState:UIControlStateNormal];
    
    
    NSString *selectedAnswer = [dictAnsweredQuestion objectForKey:[NSNumber numberWithInt:questionCount]];
    
    if ([selectedAnswer isEqualToString:@"N"])
        correctOption=@"";
    else if ([selectedAnswer isEqualToString:@"Y"])
        correctOption = question.qCorrectOption;
    else
        correctOption = selectedAnswer;
    
    if ([correctOption isEqualToString:@"A"]) {
        [btnOption1 setSelected:YES];
        [btnOption2 setSelected:NO];
        [btnOption3 setSelected:NO];
        [btnOption4 setSelected:NO];
    }
    else if ([correctOption isEqualToString:@"B"]) {
        [btnOption1 setSelected:NO];
        [btnOption2 setSelected:YES];
        [btnOption3 setSelected:NO];
        [btnOption4 setSelected:NO];
    }
    else if ([correctOption isEqualToString:@"C"]) {
        [btnOption1 setSelected:NO];
        [btnOption2 setSelected:NO];
        [btnOption3 setSelected:YES];
        [btnOption4 setSelected:NO];
    }
    else if ([correctOption isEqualToString:@"D"]) {
        [btnOption1 setSelected:NO];
        [btnOption2 setSelected:NO];
        [btnOption3 setSelected:NO];
        [btnOption4 setSelected:YES];
    }
    else {
        [btnOption1 setSelected:NO];
        [btnOption2 setSelected:NO];
        [btnOption3 setSelected:NO];
        [btnOption4 setSelected:NO];
    }
}

- (void)submitAnswer {
    
    // =========== logic to check the answer and calculate the total marks
    
    NSLog(@"%d",question.qMarks);
    
    if([[correctOption uppercaseString] isEqualToString:[question.qCorrectOption uppercaseString]])
    {
        // marking this question as answered in global dict
        [dictAnsweredQuestion setObject:@"Y" forKey:[NSNumber numberWithInt:questionCount]];
        
        obj_GlobalDataPersistence.correctPoint = obj_GlobalDataPersistence.correctPoint + question.qMarks;
        NSLog(@"%d",obj_GlobalDataPersistence.correctPoint);
    }
    
    // ====================================
}

@end
