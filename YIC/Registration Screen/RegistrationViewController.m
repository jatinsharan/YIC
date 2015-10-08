//
//  RegistrationViewController.m
//  CL-YIC
//
//  Created by Jatin on 9/5/15.
//
//

#import "RegistrationViewController.h"
#import "WebCommunicationClass.h"
#import "OTPassViewController.h"
#import "Config.h"
#import "GlobalDataPersistence.h"

@interface RegistrationViewController ()

@end

@implementation RegistrationViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    pickerReg.delegate=nil;
    pickerReg.dataSource=nil;
    
    arrCollage=[[NSArray alloc] init];
    
    arrSem=[[NSArray alloc] initWithObjects:@"1", @"2",@"3",@"4",@"5",@"6",@"7",@"8",nil];
    
    // Do any additional setup after loading the view from its nib.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Custom methods

- (void)hidePickerView
{
    [UIView beginAnimations:nil context:NULL];
    [UIView setAnimationDuration:0.3];
    vwReg.frame = CGRectMake(0,750, self.view.frame.size.width, 222);
    [UIView commitAnimations];
}

- (void)showPickerView
{
    [UIView beginAnimations:nil context:NULL];
    [UIView setAnimationDuration:0.3];
    vwReg.frame = CGRectMake(0,(self.view.frame.size.width==375?450:347), self.view.frame.size.width, 222);
    [UIView commitAnimations];
}

#pragma mark - IBActions

- (IBAction)Click_City:(id)sender
{
    [self resignAllTextFields];
    strBtnSelection=@"C";
    WebCommunicationClass *obj=[WebCommunicationClass new];
    [obj setACaller:self];
    [obj Getcity];

}

- (IBAction)Click_Collage:(id)sender
{
    [self resignAllTextFields];
    
    strBtnSelection=@"Cl";
    
    WebCommunicationClass *obj=[WebCommunicationClass new];
    [obj setACaller:self];
    [obj GetCollage:strCityId];
}

- (IBAction)Click_Sem:(id)sender
{
    [self resignAllTextFields];
    
   
    
    
    strBtnSelection=@"S";
    pickerReg.delegate = self;
    pickerReg.dataSource = self;
    [pickerReg reloadAllComponents];
   
    [self showPickerView];
}

- (IBAction)Click_Submit:(id)sender {
    
    if(lblName.text.length==0)
    {
        UIAlertView *alert =[[UIAlertView alloc]initWithTitle:@"YIC" message:@"Please enter your name" delegate:nil cancelButtonTitle:@"Ok" otherButtonTitles:nil, nil];
        [alert show];
    
    }
    else if (lblNumber.text.length==0)
    {
        UIAlertView *alert =[[UIAlertView alloc]initWithTitle:@"YIC" message:@"Please enter your Phone number" delegate:nil cancelButtonTitle:@"Ok" otherButtonTitles:nil, nil];
        [alert show];
    }
    else if (lblNumber.text.length>=10)
    {
        UIAlertView *alert =[[UIAlertView alloc]initWithTitle:@"YIC" message:@"Please enter only 10 digit Phone number" delegate:nil cancelButtonTitle:@"Ok" otherButtonTitles:nil, nil];
        [alert show];
    }
    
    else if (lblEmail.text.length==0)
    {
        UIAlertView *alert =[[UIAlertView alloc]initWithTitle:@"YIC" message:@"Please enter your Email" delegate:nil cancelButtonTitle:@"Ok" otherButtonTitles:nil, nil];
        [alert show];
    }
    else if (![self validateEmail:lblEmail.text])
    {
        UIAlertView *alert=[[UIAlertView alloc]initWithTitle:@"YIC" message:@"Please enter Valid EmailId" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
        alert.delegate=self;
        [alert show];
        
        
    }

    else if(btnCity.titleLabel.text.length==0)
    {
        UIAlertView *alert =[[UIAlertView alloc]initWithTitle:@"YIC" message:@"Please select your City" delegate:nil cancelButtonTitle:@"Ok" otherButtonTitles:nil, nil];
        [alert show];
    }else if (lblAddress.text.length==0)
    {
        UIAlertView *alert =[[UIAlertView alloc]initWithTitle:@"YIC" message:@"Please enter your Address" delegate:nil cancelButtonTitle:@"Ok" otherButtonTitles:nil, nil];
        [alert show];
    
    }else if (btnCollage.titleLabel.text.length==0)
    {
        UIAlertView *alert =[[UIAlertView alloc]initWithTitle:@"YIC" message:@"Please select your Collage" delegate:nil cancelButtonTitle:@"Ok" otherButtonTitles:nil, nil];
        [alert show];
    }
    else if (lblCourse.text.length==0)
    {
        UIAlertView *alert =[[UIAlertView alloc]initWithTitle:@"YIC" message:@"Please enter your Course" delegate:nil cancelButtonTitle:@"Ok" otherButtonTitles:nil, nil];
        [alert show];
    }else if (btnSem.titleLabel.text.length==0)
    {
        UIAlertView *alert =[[UIAlertView alloc]initWithTitle:@"YIC" message:@"Please select your Semester" delegate:nil cancelButtonTitle:@"Ok" otherButtonTitles:nil, nil];
        [alert show];
    }else
    {
        WebCommunicationClass *obj=[WebCommunicationClass new];
    
        [obj setACaller:self];
        [obj GetRegestater:lblName.text mobile:lblNumber.text email:lblEmail.text city:strCityId localAddress:lblAddress.text collegeName:btnCollage.titleLabel.text course:lblCourse.text semester:btnSem.titleLabel.text];
    }
}

- (BOOL) validateEmail: (NSString *) candidate
{
    NSString *emailRegex = @"[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,4}";
    NSPredicate *emailTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", emailRegex];
    
    return [emailTest evaluateWithObject:candidate];
}

-(IBAction)btn_Back:(id)sender
{
    [self.navigationController popViewControllerAnimated:YES];
}

#pragma mark- Webservice callback
#pragma mark-

-(void) dataDidFinishDowloading:(ASIHTTPRequest*)aReq withMethood:(NSString *)MethoodName withOBJ:(WebCommunicationClass *)aObj
{
    NSError *jsonParsingError = nil;
    
    NSString *strResult=[NSJSONSerialization JSONObjectWithData:[aReq responseData]options:0 error:&jsonParsingError];
    
    NSLog(@"%@",[strResult valueForKey:@"responseObject"]);
    NSNumber * isSuccessNumber = (NSNumber *)[strResult valueForKey:@"errorCode"];
    
    if(aReq.tag==2)
    {
        if(isSuccessNumber)
        {
            
            
            arrCollage=[strResult valueForKey:@"responseObject"];
            NSLog(@"%@",arrCollage);
            pickerReg.delegate=self;
            pickerReg.dataSource=self;
            [pickerReg reloadAllComponents];
            
            [self showPickerView];
        }
    }
    else if (aReq.tag==6)
    {
        if(isSuccessNumber)
        {
            arrCity=[strResult valueForKey:@"responseObject"];
            NSLog(@"%@",arrCity);
            pickerReg.delegate=self;
            pickerReg.dataSource=self;
            [pickerReg reloadAllComponents];
            
            [self showPickerView];
        }
    
    }
    else
    {
        if(isSuccessNumber)
        {
            
            NSUserDefaults *defult=[NSUserDefaults standardUserDefaults];
            [defult setValue:@"1" forKey:@"isLogin"];
            
            
             GlobalDataPersistence *obj_GlobalDataPersistence=[GlobalDataPersistence sharedGlobalDataPersistence];
            obj_GlobalDataPersistence.strUserId=[NSString stringWithFormat:@"%@",[strResult valueForKey:@"responseObject"]];
            [defult setValue:[NSString stringWithFormat:@"%@",[strResult valueForKey:@"responseObject"]] forKey:@"UserId"];
            [defult synchronize];
            OTPassViewController * pinViewController = [[OTPassViewController alloc] init];
            
            [self.navigationController pushViewController:pinViewController animated:YES];
            

            
        }
    }
}

#pragma mark - Picker View Data source

-(NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView
{
    return 1;
}

-(NSInteger)pickerView:(UIPickerView *)pickerView
numberOfRowsInComponent:(NSInteger)component
{
    if([strBtnSelection isEqualToString:@"C"])
    {
        return [arrCity count] ;
    }
    else if ([strBtnSelection isEqualToString:@"Cl"])
    {
        return [arrCollage count];
    }
    else
    {
        return [arrSem count] ;
    }
}

#pragma mark- Picker View Delegate

-(void)pickerView:(UIPickerView *)pickerView didSelectRow:
(NSInteger)row inComponent:(NSInteger)component{
    
    if([strBtnSelection isEqualToString:@"C"])
    {
        [btnCity setTitle:[[arrCity valueForKey:@"cityName"] objectAtIndex:row] forState:UIControlStateNormal];
        strCityId=[NSString stringWithFormat:@"%@",[[arrCity valueForKey:@"cityId"] objectAtIndex:row]];
        NSLog(@"%@",strCityId);
    }
    else if ([strBtnSelection isEqualToString:@"Cl"])
    {
        
        [btnCollage setTitle:[[arrCollage valueForKey:@"collegeName"] objectAtIndex:row] forState:UIControlStateNormal];
        GlobalDataPersistence *obj_GlobalDataPersistence=[GlobalDataPersistence sharedGlobalDataPersistence];
        obj_GlobalDataPersistence.strCollageId=[NSString stringWithFormat:@"%@",[[arrCollage valueForKey:@"collegeId"] objectAtIndex:row]];
        
        NSUserDefaults *defult=[NSUserDefaults standardUserDefaults];
        [defult setValue:[NSString stringWithFormat:@"%@",[[arrCollage valueForKey:@"collegeId"] objectAtIndex:row]] forKey:@"CollageId"];
        [defult synchronize];
    }
    else
    {
        [btnSem setTitle:[arrSem objectAtIndex:row] forState:UIControlStateNormal];
    }
    
    [self hidePickerView];
}

- (NSString *)pickerView:(UIPickerView *)pickerView titleForRow:
(NSInteger)row forComponent:(NSInteger)component
{
    if([strBtnSelection isEqualToString:@"C"])
    {
        return [[arrCity valueForKey:@"cityName"] objectAtIndex:row];
    }
    else if ([strBtnSelection isEqualToString:@"Cl"])
    {
        
        return [[arrCollage valueForKey:@"collegeName"] objectAtIndex:row];
    }
    
    else
    {
        return [arrSem objectAtIndex:row];
    }
}

#pragma mark - TextField delegate

- (void)resignAllTextFields
{
    [lblName resignFirstResponder];
    [lblEmail resignFirstResponder];
    [lblCourse resignFirstResponder];
    [lblNumber resignFirstResponder];
    [lblAddress resignFirstResponder];
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [textField resignFirstResponder];
    

    return YES;
}

- (void)textFieldDidBeginEditing:(UITextField *)textField
{
    [self hidePickerView];
    if(textField.tag==10)
    {
    [self animateTextField: textField up: YES];
    }
}

- (void)textFieldDidEndEditing:(UITextField *)textField
{
    if(textField.tag==10)
    {
   [self animateTextField: textField up: NO];
    }
}
- (void) animateTextField: (UITextField*) textField up: (BOOL) up
{
    
    const int movementDistance = 130; // tweak as needed
    const float movementDuration = 0.3f; // tweak as needed
    
    int movement = (up ? -movementDistance : movementDistance);
    
    [UIView beginAnimations: @"anim" context: nil];
    [UIView setAnimationBeginsFromCurrentState: YES];
    [UIView setAnimationDuration: movementDuration];
    self.view.frame=CGRectOffset(self.view.frame, 0, movement);
    [UIView commitAnimations];
}
@end
