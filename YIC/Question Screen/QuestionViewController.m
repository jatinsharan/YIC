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

@interface QuestionViewController ()

@end

@implementation QuestionViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    questionCount=0;
    
    lblQuestionCount.text=[NSString stringWithFormat:@"%d",questionCount];
    
    GlobalDataPersistence *obj_GlobalDataPersistence=[GlobalDataPersistence sharedGlobalDataPersistence];
    NSLog(@"%@",obj_GlobalDataPersistence.strCollageId);
    
    DBManagerYIC *obj_DBManagerYIC=[DBManagerYIC new];
    arrQuestion=[obj_DBManagerYIC getAllRandomQuestion];
    
    question = [QuestionYIC new];
    question=[arrQuestion objectAtIndex:questionCount];
    
    lblSectionHeading.text=[NSString stringWithFormat:@"Section 1:%@",question.qSection];
    lblQuestion.text=[NSString stringWithFormat:@"%@",question.qQuestion];
    
    [btnOption1 setTitle:[NSString stringWithFormat:@"%@",question.qOption_1] forState:UIControlStateNormal];
    
    [btnOption2 setTitle:[NSString stringWithFormat:@"%@",question.qOption_2] forState:UIControlStateNormal];
    
    [btnOption3 setTitle:[NSString stringWithFormat:@"%@",question.qOption_3] forState:UIControlStateNormal];
    
    [btnOption4 setTitle:[NSString stringWithFormat:@"%@",question.qOption_4] forState:UIControlStateNormal];
    
    NSLog(@"%@",question.qCorrectOption);
    
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
    int hours = countDownTime /3600;
    if(countDownTime > 0)
    {
        
        countDownTime--;
        // int
        if (hours == hourss && mints == min && sec==secs)
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
    
    if ([_CountDownTimer isValid])
    {
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

- (IBAction)Click_NextQuestion:(id)sender {
    
    if(questionCount<[arrQuestion count]-1)
    {
        questionCount++;
         lblQuestionCount.text=[NSString stringWithFormat:@"%d",questionCount];
        question=[arrQuestion objectAtIndex:questionCount];
         NSLog(@"%@",question.qCorrectOption);
        lblSectionHeading.text=[NSString stringWithFormat:@"Section 1:%@",question.qSection];
        lblQuestion.text=[NSString stringWithFormat:@"%@",question.qQuestion];
        
        [btnOption1 setTitle:[NSString stringWithFormat:@"%@",question.qOption_1] forState:UIControlStateNormal];
        
        [btnOption2 setTitle:[NSString stringWithFormat:@"%@",question.qOption_2] forState:UIControlStateNormal];
        
        [btnOption3 setTitle:[NSString stringWithFormat:@"%@",question.qOption_3] forState:UIControlStateNormal];
        
        [btnOption4 setTitle:[NSString stringWithFormat:@"%@",question.qOption_4] forState:UIControlStateNormal];
        GlobalDataPersistence *obj_global=[GlobalDataPersistence sharedGlobalDataPersistence];
         NSLog(@"%d",question.qMarks);
        if([correctOption isEqualToString:question.qCorrectOption])
        {
        obj_global.correctPoint=obj_global.correctPoint+question.qMarks;
        }
        NSLog(@"%d",obj_global.correctPoint);
        [btnOption1 setSelected:NO];
        [btnOption2 setSelected:NO];
        [btnOption3 setSelected:NO];
        [btnOption4 setSelected:NO];

    }
    else
    {
        [_CountDownTimer invalidate];
        
        
        _CountDownTimer=nil;
        ResultViewController *obj_ResultViewController=[ResultViewController new];
        [self.navigationController pushViewController:obj_ResultViewController animated:YES];
    
    }
    
    
    
    
}
@end
