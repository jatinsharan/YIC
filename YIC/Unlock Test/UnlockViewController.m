//
//  OTPViewController.m
//  myClubKart
//
//  Created by Sheetal on 8/5/15.
//  Copyright (c) 2015 Dotsquares. All rights reserved.
//

#import "UnlockViewController.h"
#import "InstructionViewController.h"


@implementation UnlockViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
   /* UITextField *nextTextField1 = (UITextField *)[self.otpTxt objectAtIndex:0];
    [nextTextField1 becomeFirstResponder];
    
    CGRect screenRect = [[UIScreen mainScreen] bounds];
    CGFloat screenWidth = screenRect.size.width;
    CGFloat screenHeight = screenRect.size.height;
    
    self.pageScroll.frame = CGRectMake(0, 0, screenWidth, screenHeight);
    [self.pageScroll setContentSize:CGSizeMake(self.view.bounds.size.width, self.view.bounds.size.height+50)];
    
  
    
    timeCount=60;
    timer=[NSTimer scheduledTimerWithTimeInterval:1.0 target:self selector:@selector(increaseTimer:) userInfo:nil repeats:YES];
    [timer fire];
    UITapGestureRecognizer *tap=[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapOnView)];
    [self.pageScroll addGestureRecognizer:tap];*/
}


-(void)tapOnView
{
    NSLog(@"touch");
    
    for (UIView *viewT in [self.pageScroll subviews])
    {
        if ([viewT isKindOfClass:[UITextField class]])
        {
            UITextField *txtField=(UITextField *)viewT;
            if ([txtField isFirstResponder] ) {
                [txtField resignFirstResponder];
            }
            
        }
    }
}



-(void)increaseTimer:(NSTimer *)theTimer
{
    
    if (timeCount==0)
    {
       
       }
    self.timerLbl.text=[NSString stringWithFormat:@"%d",timeCount];
    timeCount--;
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:YES];
    timeCount=60;
}
-(void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:YES];
    [timer invalidate];
    timeCount=60;
    
}

- (IBAction)tapped_continue:(id)sender
{
    NSString *strOtp = @"";
    for(UITextField *text in self.otpTxt)
    {
        
        strOtp = [NSString stringWithString:[strOtp stringByAppendingString:text.text ]];
        
        
    }
}




- (IBAction)tapped_ResentOTP:(id)sender
{
    InstructionViewController *obj_InstructionViewController=[InstructionViewController new];
    [self.navigationController pushViewController:obj_InstructionViewController animated:YES];
}

#pragma Text Field Delegate
-(BOOL)textFieldShouldReturn:(UITextField*)textField
{
    return YES;
}
-(BOOL)textFieldShouldBeginEditing:(UITextField *)textField
{
    return YES;
}
-(void)textFieldDidBeginEditing:(UITextField *)textField
{
    
    NSLog(@"ff");
}
-(void)textFieldDidEndEditing:(UITextField *)textField
{
    
}
-(BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string
{
    
    nextStr=string;
    
    if (range.length==1 )
    {
        nextTag = textField.tag;
        
        if (nextTag>1) {
            UITextField *nextTextField = (UITextField *)[self.otpTxt objectAtIndex:nextTag-1];
            nextTextField.text=@"";
            [self  textFieldDidBeginEditienter:nextTextField :@"rev"];
            
            return NO;
        }
        return YES;
    }
    else   if ([textField.text length]==1)
    {
        nextTag = textField.tag;
        if (nextTag<=9) {
            UITextField *nextTextField = (UITextField *)[self.otpTxt objectAtIndex:nextTag];
            [self  textFieldDidBeginEditienter:nextTextField :@"forward"];
            
        }
        return NO;
        
    }
    
    
    return YES;
}

-(void)textFieldDidBeginEditienter:(UITextField *)textField :(NSString *)revOrFrwd
{
    
    
    if ([revOrFrwd isEqualToString:@"rev"]) {
        
        UITextField *nextTextField1 = (UITextField *)[self.otpTxt objectAtIndex:nextTag-2];
        for (UITextField *obj in self.otpTxt) {
            obj.userInteractionEnabled=NO;
        }
        nextTextField1.userInteractionEnabled=YES;
        [nextTextField1 becomeFirstResponder];
        
        
        // nextTextField1.text=prevStr;
        
    }
    else if ([revOrFrwd isEqualToString:@"forward"])
    {
        for (UITextField *obj in self.otpTxt) {
            obj.userInteractionEnabled=NO;
        }
        textField.userInteractionEnabled=YES;
        [textField becomeFirstResponder];
        
        textField.text=nextStr;
    }
    
}

#pragma AlertView Delegate

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if(alertView.tag == 1)
    {
             
    }
    else if (alertView.tag == 2)
    {
        //[self.navigationController popViewControllerAnimated:YES];
    }
}

@end
