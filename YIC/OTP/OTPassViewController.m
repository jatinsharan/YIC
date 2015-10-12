//
//  OTPViewController.m
//  myClubKart
//
//  Created by Sheetal on 8/5/15.
//  Copyright (c) 2015 Dotsquares. All rights reserved.
//

#import "OTPassViewController.h"
#import "HomeViewController.h"
#import "DBManagerYIC.h"
#import "WebCommunicationClass.h"
#import "GlobalDataPersistence.h"

@implementation OTPassViewController

- (void)viewDidLoad {
    
    [super viewDidLoad];
    
    CGRect screenRect = [[UIScreen mainScreen] bounds];
    CGFloat screenWidth = screenRect.size.width;
    CGFloat screenHeight = screenRect.size.height;
    
    [self.pageScroll setContentSize:CGSizeMake(screenWidth, screenHeight)];
    [_pageScroll setContentOffset:CGPointMake(0, 0)];
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:YES];
    timeCount=60;
}

- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:YES];
    [timer invalidate];
    timeCount=60;
}

- (void)viewDidAppear:(BOOL)animated
{
    UIAlertView *alert =[[UIAlertView alloc]initWithTitle:@"" message:@"A OTP code has been sent to you. Please verify and complete registration." delegate:nil cancelButtonTitle:@"Ok" otherButtonTitles:nil, nil];
    [alert show];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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
    self.timerLbl.text=[NSString stringWithFormat:@"%d",timeCount];
    timeCount--;
}

- (IBAction)tapped_continue:(id)sender
{
    strOtp = @"";
    
    for(UITextField *text in self.otpTxt) {
        strOtp = [NSString stringWithString:[strOtp stringByAppendingString:text.text ]];
    }
}

- (IBAction)tapped_ResentOTP:(id)sender
{
    [_pageScroll setContentOffset:CGPointMake(0, -20)];
    
    strOtp = @"";
    
    for(UITextField *text in self.otpTxt) {
        strOtp = [NSString stringWithString:[strOtp stringByAppendingString:text.text ]];
    }
    
    if(strOtp.length == 6)
    {        
        WebCommunicationClass *obj=[WebCommunicationClass new];
        [obj setACaller:self];
        [obj GetOtp:[KUSER_DEFAULT valueForKey:KUSER_ID] otp:strOtp];
    }
    else
    {
        UIAlertView *alert =[[UIAlertView alloc]initWithTitle:@"" message:@"OTP needs to be exactly of 6 digits!" delegate:nil cancelButtonTitle:@"Ok" otherButtonTitles:nil, nil];
        [alert show];
    }
}

-(IBAction)Click_REcivedOtpRetry:(id)sender
{
    // Havn't received OTP, navigate back to registration screen
    [self.navigationController popViewControllerAnimated:YES];
}

#pragma Text Field Delegate

-(BOOL)textFieldShouldReturn:(UITextField*)textField
{
    [_pageScroll setContentOffset:CGPointMake(0, -20)];
    [textField resignFirstResponder];
    return YES;
}

-(void)textFieldDidBeginEditing:(UITextField *)textField
{
    if ([UIScreen mainScreen].bounds.size.width != 375) {
        [_pageScroll setContentOffset:CGPointMake(0, 100)];
    }
}

-(void)textFieldDidEndEditing:(UITextField *)textField
{
    [_pageScroll setContentOffset:CGPointMake(0, -20)];
}

-(BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string
{
    nextStr=string;
    
    NSLog(@"%ld",(long)nextTag);
    
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
        
        if (nextTag<6) {
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

#pragma mark- Webservice callback

-(void) dataDidFinishDowloading:(ASIHTTPRequest*)aReq withMethood:(NSString *)MethoodName withOBJ:(WebCommunicationClass *)aObj
{
    NSError *jsonParsingError = nil;
    
    NSString *strResult=[NSJSONSerialization JSONObjectWithData:[aReq responseData]options:0 error:&jsonParsingError];
    
    NSLog(@"%@",[strResult valueForKey:@"errorCode"]);
    NSNumber * isSuccessNumber = (NSNumber *)[strResult valueForKey:@"errorCode"];
    
    if(isSuccessNumber)
    {
        [KUSER_DEFAULT setBool:true forKey:KIS_OTP];
        [KUSER_DEFAULT setValue:@"1" forKey:KIS_LOGIN];
        [KUSER_DEFAULT synchronize];
        
        HomeViewController *objHomeViewController=[HomeViewController new];
        [self.navigationController pushViewController:objHomeViewController animated:YES];
    }
}

@end
