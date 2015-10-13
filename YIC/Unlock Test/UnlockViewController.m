//
//  OTPViewController.m
//  myClubKart
//
//  Created by Sheetal on 8/5/15.
//  Copyright (c) 2015 Dotsquares. All rights reserved.
//

#import "UnlockViewController.h"
#import "InstructionViewController.h"
#import "DBManagerYIC.h"
#import "GlobalDataPersistence.h"


@implementation UnlockViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
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
    if (timeCount==0) {
        
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
    strOtp = @"";
    for(UITextField *text in self.otpTxt)
    {
        strOtp = [NSString stringWithString:[strOtp stringByAppendingString:text.text ]];
    }
    
    NSString *code = [@"kjtlmt" substringFromIndex: [@"kjtlmt" length] - 3];
    NSLog(@"%@",code);
}

- (IBAction)tapped_ResentOTP:(id)sender
{
    UITextField *text=nil;
    
    strOtp = @"";
    for(text in self.otpTxt) {
        strOtp = [NSString stringWithString:[strOtp stringByAppendingString:text.text]];
    }
    
    [text resignFirstResponder];
    
    if (strOtp.length == 8)
    {
        DBManagerYIC *obj_DBManagerYIC=[DBManagerYIC new];
        
        NSString *lockCode = [[strOtp substringFromIndex: [strOtp length] - 3] uppercaseString];
        NSLog(@"%@",lockCode);
        
        BOOL success = [obj_DBManagerYIC checkLockCode:lockCode];
        if (success)
        {
            NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
            [formatter setDateFormat:@"hh:mm a"];
            NSLocale *locale = [[NSLocale alloc] initWithLocaleIdentifier:@"en_US"];
            [formatter setLocale:locale];
            NSString *strDate = [formatter stringFromDate:[NSDate date]];
            
            NSString *strhourlycode = [obj_DBManagerYIC getHourlyCode:strDate];
            
            NSString *strCollegeCode = [KUSER_DEFAULT valueForKey:KCOLLAGE_ID];
            
            NSString *strCommom = [NSString stringWithFormat:@"%@%@%@",strCollegeCode,strhourlycode,lockCode];
            NSLog(@"%@",strCommom);
            
            if([[strCommom uppercaseString] isEqualToString:[strOtp uppercaseString]])
            {                
                [KUSER_DEFAULT setValue:strCommom forKey:KPASSCODE];
                [KUSER_DEFAULT synchronize];
                
                // lock code entered is valid, move to next screen
                InstructionViewController *obj_InstructionViewController=[InstructionViewController new];
                [self.navigationController pushViewController:obj_InstructionViewController animated:YES];
            }
            else
            {
                UIAlertView *alert =[[UIAlertView alloc]initWithTitle:@"" message:@"Invalid code, Please enter the correct code!" delegate:nil cancelButtonTitle:@"Ok" otherButtonTitles:nil, nil];
                [alert show];
            }
        }
        else
        {
            UIAlertView *alert =[[UIAlertView alloc]initWithTitle:@"" message:@"Invalid code, Please enter the correct code!" delegate:nil cancelButtonTitle:@"Ok" otherButtonTitles:nil, nil];
            [alert show];
        }
    }
    else
    {
        UIAlertView *alert =[[UIAlertView alloc]initWithTitle:@"" message:@"Lock code is exactly 8 characters long!" delegate:nil cancelButtonTitle:@"Ok" otherButtonTitles:nil, nil];
        [alert show];
    }    
}

#pragma Text Field Delegate

-(BOOL)textFieldShouldReturn:(UITextField*)textField
{
    [textField resignFirstResponder];
    return YES;
}

-(BOOL)textFieldShouldBeginEditing:(UITextField *)textField
{
    return YES;
}

-(void)textFieldDidBeginEditing:(UITextField *)textField
{

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
    else if ([textField.text length]==1)
    {
        nextTag = textField.tag;
        if (nextTag<8) {
            UITextField *nextTextField = (UITextField *)[self.otpTxt objectAtIndex:nextTag];
            [self  textFieldDidBeginEditienter:nextTextField :@"forward"];
        }
        else
        {
            [textField resignFirstResponder];
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

-(IBAction)Click_Back:(id)sender
{
    [self.navigationController popViewControllerAnimated:YES];
}


@end
