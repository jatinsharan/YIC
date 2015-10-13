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
    countDownTime = 2700;
    
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
    NSLog(@"COUNTDOWN >>> %d",(2700-countDownTime));
    
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
    
//    if ( correctOption == nil || correctOption.length==0 || [correctOption isEqualToString:@""]) {
//        // No Option selected, display alert
//        UIAlertView *alert =[[UIAlertView alloc]initWithTitle:@"" message:@"You need to select an option to proceed!" delegate:nil cancelButtonTitle:@"Ok" otherButtonTitles:nil, nil];
//        [alert show];
//    }
//    else {
    
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
            
            [KUSER_DEFAULT setInteger:2700-countDownTime forKey:KTIME_TAKEN];
            [KUSER_DEFAULT setInteger:obj_GlobalDataPersistence.correctPoint forKey:KTIME_TAKEN];
            
            // Question complete, move to Result screen
            
            ResultViewController *obj_ResultViewController=[ResultViewController new];
            [self.navigationController pushViewController:obj_ResultViewController animated:YES];
        }
//    }
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
    
    
    // ===============================================
    
    question=[arrQuestion objectAtIndex:questionCount];
    NSLog(@"%@",question.qCorrectOption);
    
    lblQuestionCount.text=[NSString stringWithFormat:@"%d",questionCount+1];

    if (questionCount<20) {
        lblSectionHeading.text=[NSString stringWithFormat:@"Section 1:%@",question.qSection];
    }
    else if (questionCount<40) {
        lblSectionHeading.text=[NSString stringWithFormat:@"Section 2:%@",question.qSection];
    }
    else {
        lblSectionHeading.text=[NSString stringWithFormat:@"Section 3:%@",question.qSection];
    }

    
    lblQuestion.text = question.qQuestion;
    [self layoutQuestionView];
    
    [btnOption1 setTitle:[NSString stringWithFormat:@"%@",question.qOption_1] forState:UIControlStateNormal];
    btnOption1.titleLabel.numberOfLines=0;
    btnOption1.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;

    [btnOption2 setTitle:[NSString stringWithFormat:@"%@",question.qOption_2] forState:UIControlStateNormal];
    btnOption2.titleLabel.numberOfLines=0;
    btnOption2.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;

    [btnOption3 setTitle:[NSString stringWithFormat:@"%@",question.qOption_3] forState:UIControlStateNormal];
    btnOption3.titleLabel.numberOfLines=0;
    btnOption3.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;

    [btnOption4 setTitle:[NSString stringWithFormat:@"%@",question.qOption_4] forState:UIControlStateNormal];
    btnOption4.titleLabel.numberOfLines=0;
    btnOption4.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;

    [self layoutOptionView];
    
    if (questionCount<40) {
        viewInstruction.hidden = YES;
    }
    else {
        viewInstruction.hidden = NO;
        
        lblInstruction.text = question.qInstruction;
        [self layoutInstructionView];
    }
    
    CGFloat width = [UIScreen mainScreen].bounds.size.width;
    CGFloat height = viewQuestion.frame.origin.y+viewQuestion.frame.size.height;
    [scrlMain setContentSize:CGSizeMake(width, height)];
    
    // ================================================
    
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

- (void)layoutInstructionView
{
    //Calculate the expected size based on the font and linebreak mode of your label
    // MAXFLOAT here simply means no constraint in height
    
    CGSize maximumLabelSize = CGSizeMake(KMAX_WIDTH, MAXFLOAT);
    
    CGSize expectedLabelSize = [lblInstruction.text boundingRectWithSize:maximumLabelSize
                                                              options:NSStringDrawingUsesLineFragmentOrigin
                                                           attributes:@{NSFontAttributeName : lblInstruction.font}
                                                              context:nil].size;
    //adjust the label the the new height.
    CGRect newFrame = KDEFAULT_RECT;
    newFrame.size.height = expectedLabelSize.height;
    lblInstruction.frame = newFrame;
    [lblInstruction sizeToFit];
    
    CGRect bgFrame = bgInstruction.frame;
    bgFrame.size.height = lblInstruction.frame.origin.y+lblInstruction.frame.size.height+8;
    bgInstruction.frame = bgFrame;
    
    CGRect questionFrame = viewQuestion.frame;
    questionFrame.origin.y = bgInstruction.frame.origin.y+bgInstruction.frame.size.height+16;
    viewQuestion.frame = questionFrame;
}

- (void)layoutQuestionView
{
    //Calculate the expected size based on the font and linebreak mode of your label
    // MAXFLOAT here simply means no constraint in height
    
    CGSize maximumLabelSize = CGSizeMake(KMAX_WIDTH, MAXFLOAT);
    
    CGSize expectedLabelSize = [lblQuestion.text boundingRectWithSize:maximumLabelSize
                                                              options:NSStringDrawingUsesLineFragmentOrigin
                                                           attributes:@{NSFontAttributeName : lblQuestion.font}
                                                              context:nil].size;
    
    //adjust the label the the new height.
    CGRect newFrame = KDEFAULT_RECT;
    newFrame.size.height = expectedLabelSize.height;
    lblQuestion.frame = newFrame;
    [lblQuestion sizeToFit];
    
    CGRect bgFrame = bgQuestion.frame;
    bgFrame.size.height = lblQuestion.frame.origin.y+lblQuestion.frame.size.height+8;
    bgQuestion.frame = bgFrame;
    
    CGRect optionFrame = viewOption.frame;
    optionFrame.origin.y = bgQuestion.frame.origin.y+bgQuestion.frame.size.height+8;
    viewOption.frame = optionFrame;
    
    CGRect questionFrame = viewQuestion.frame;
    questionFrame.origin.y = 8;
    viewQuestion.frame = questionFrame;
}

- (void)layoutOptionView
{
    //Calculate the expected size based on the font and linebreak mode of your label
    // MAXFLOAT here simply means no constraint in height
    
    CGSize maximumLabelSize = CGSizeMake(240, MAXFLOAT);
    
    CGSize expectedLabelSize1 = [btnOption1.currentTitle boundingRectWithSize:maximumLabelSize
                                                              options:NSStringDrawingUsesLineFragmentOrigin
                                                           attributes:@{NSFontAttributeName : btnOption1.titleLabel.font}
                                                        context:nil].size;

    CGSize expectedLabelSize2 = [btnOption2.currentTitle boundingRectWithSize:maximumLabelSize
                                                                      options:NSStringDrawingUsesLineFragmentOrigin
                                                                   attributes:@{NSFontAttributeName : btnOption2.titleLabel.font}
                                                                      context:nil].size;
    
    CGSize expectedLabelSize3 = [btnOption3.currentTitle boundingRectWithSize:maximumLabelSize
                                                                      options:NSStringDrawingUsesLineFragmentOrigin
                                                                   attributes:@{NSFontAttributeName : btnOption3.titleLabel.font}
                                                                      context:nil].size;
    
    CGSize expectedLabelSize4 = [btnOption4.currentTitle boundingRectWithSize:maximumLabelSize
                                                                      options:NSStringDrawingUsesLineFragmentOrigin
                                                                   attributes:@{NSFontAttributeName : btnOption4.titleLabel.font}
                                                                      context:nil].size;
    
    
    //adjust the btnOption the the new height.
    
    CGRect newFrame1 = KOPTION_RECT;
    newFrame1.origin.y = 12;
    newFrame1.size.height = MAX(expectedLabelSize1.height, 24);
    btnOption1.frame = newFrame1;
    
    CGRect newFrame2 = KOPTION_RECT;
    newFrame2.origin.y = btnOption1.frame.origin.y+btnOption1.frame.size.height+12;
    newFrame2.size.height = MAX(expectedLabelSize2.height, 24);
    btnOption2.frame = newFrame2;
    
    CGRect newFrame3 = KOPTION_RECT;
    newFrame3.origin.y = btnOption2.frame.origin.y+btnOption2.frame.size.height+12;
    newFrame3.size.height = MAX(expectedLabelSize3.height, 24);
    btnOption3.frame = newFrame3;

    CGRect newFrame4 = KOPTION_RECT;
    newFrame4.origin.y = btnOption3.frame.origin.y+btnOption3.frame.size.height+12;
    newFrame4.size.height = MAX(expectedLabelSize4.height, 24);
    btnOption4.frame = newFrame4;

    CGRect bgFrame = bgOption.frame;
    bgFrame.size.height = btnOption4.frame.origin.y+btnOption4.frame.size.height+12;
    bgOption.frame = bgFrame;
    
    CGRect optionFrame = viewOption.frame;
    optionFrame.size.height = btnOption4.frame.origin.y+btnOption4.frame.size.height+12;
    viewOption.frame = optionFrame;
    
    CGRect questionFrame = viewQuestion.frame;
    questionFrame.size.height = viewOption.frame.origin.y+viewOption.frame.size.height+20;
    viewQuestion.frame = questionFrame;
}

@end
