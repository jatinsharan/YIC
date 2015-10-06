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

@interface QuestionViewController ()

@end

@implementation QuestionViewController

- (void)viewDidLoad {
    
    [super viewDidLoad];
    
    GlobalDataPersistence *obj_GlobalDataPersistence=[GlobalDataPersistence sharedGlobalDataPersistence];
    NSLog(@"%@",obj_GlobalDataPersistence.strCollageId);
    
    DBManagerYIC *obj_DBManagerYIC=[DBManagerYIC new];
    arrQuestion = [obj_DBManagerYIC getAllRandomQuestion];
    
    question = [QuestionYIC new];
    
    questionCount=0;
    [self setCurrentQuestion];
    
    secs = 00;
    mints = 58;
    hourss=23;
    countDownTime=3000;
    _CountDownTimer =  [NSTimer scheduledTimerWithTimeInterval:1 target:self selector:@selector(DecrementCounterValue) userInfo:nil repeats:YES];
    // Do any additional setup after loading the view from its nib.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)DecrementCounterValue
{
    
    //        $init = 86399;
    //        $hours = floor($init / 3600);
    //        $minutes = floor(($init / 60) % 60);
    //        $seconds = $init % 60;
    int sec = countDownTime%60;
    int min =(countDownTime / 60)%60;
    
    NSLog(@"%d",(countDownTime / 60)%60-countDownTime);
    if(countDownTime > 0)
    {
        
        countDownTime--;
        // int
        if (mints == min && sec==secs)
        {
            UIAlertView *alert =[[UIAlertView alloc]initWithTitle:@"Worning" message:@"Time Up!" delegate:nil cancelButtonTitle:@"Ok" otherButtonTitles:nil, nil];
            [alert show];
            [self InvalidateCountDownTimer];
        }
        else
        {
            // label.text=[NSString stringWithFormat:@"%d:00",countDownTime];
            self.lbl.text=[NSString stringWithFormat:@"%d:%d",min,sec];
        }
    }
    else
    {
        self.lbl.text=[NSString stringWithFormat:@"%d:%d",min,sec];
        
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
    
    if(questionCount<[arrQuestion count]-1)
    {
        questionCount++;
        [self setCurrentQuestion];
        
        // ======== this logic here need to be revised ==========
        GlobalDataPersistence *obj_global=[GlobalDataPersistence sharedGlobalDataPersistence];
        NSLog(@"%d",question.qMarks);
        
        if([correctOption isEqualToString:question.qCorrectOption]) {
            obj_global.correctPoint=obj_global.correctPoint+question.qMarks;
        }
        
        NSLog(@"%d",obj_global.correctPoint);
        // ====================================================
    }
    else
    {
        [_CountDownTimer invalidate];
        _CountDownTimer=nil;
        
        NSLog(@"%d",50-countDownTime);
        GlobalDataPersistence *obj_GlobalDataPersistence=[GlobalDataPersistence sharedGlobalDataPersistence];
        NSLog(@"%@",obj_GlobalDataPersistence.strUserId);
        WebCommunicationClass *obj=[WebCommunicationClass new];
        [obj setACaller:self];
        
        [obj GetSaveUserdetail:[[NSUserDefaults standardUserDefaults] valueForKey:@"UserId"] testDate:[NSString stringWithFormat:@"%@",[NSDate date]] passcode:obj_GlobalDataPersistence.strPasscode timeTaken:[NSString stringWithFormat:@"%d",50] marks:[NSString stringWithFormat:@"%d",obj_GlobalDataPersistence.correctPoint]];
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
        correctOption=@"c";
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
    
}

-(IBAction)click_back:(id)sender
{
    [self.navigationController popViewControllerAnimated:YES];
}

-(void)dataDidFinishDowloading:(ASIHTTPRequest*)aReq withMethood:(NSString *)MethoodName withOBJ:(WebCommunicationClass *)aObj
{
    NSError *jsonParsingError = nil;
    
    NSString *strResult=[NSJSONSerialization JSONObjectWithData:[aReq responseData]options:0 error:&jsonParsingError];
    
    NSLog(@"%@",[strResult valueForKey:@"errorCode"]);
    NSNumber * isSuccessNumber = (NSNumber *)[strResult valueForKey:@"errorCode"];
    
    if(isSuccessNumber)
    {
        ResultViewController *obj_ResultViewController=[ResultViewController new];
        [self.navigationController pushViewController:obj_ResultViewController animated:YES];
        
        
    }
}

- (void)setCurrentQuestion
{
    // This is a generic func. which is using repeteadly
    
    if (questionCount==0)
        btnPrevious.hidden = YES;
    else
        btnPrevious.hidden = NO;
    
    lblQuestionCount.text=[NSString stringWithFormat:@"%d",questionCount+1];
    
    question=[arrQuestion objectAtIndex:questionCount];
    NSLog(@"%@",question.qCorrectOption);
    
    lblQuestion.text=[NSString stringWithFormat:@"%@",question.qQuestion];
    lblSectionHeading.text=[NSString stringWithFormat:@"Section 1:%@",question.qSection];
    
    [btnOption1 setTitle:[NSString stringWithFormat:@"%@",question.qOption_1] forState:UIControlStateNormal];
    [btnOption2 setTitle:[NSString stringWithFormat:@"%@",question.qOption_2] forState:UIControlStateNormal];
    [btnOption3 setTitle:[NSString stringWithFormat:@"%@",question.qOption_3] forState:UIControlStateNormal];
    [btnOption4 setTitle:[NSString stringWithFormat:@"%@",question.qOption_4] forState:UIControlStateNormal];
    
    [btnOption1 setSelected:NO];
    [btnOption2 setSelected:NO];
    [btnOption3 setSelected:NO];
    [btnOption4 setSelected:NO];
}

@end
