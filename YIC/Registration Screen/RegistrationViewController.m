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
#import "TPKeyboardAvoidingScrollView.h"

@interface RegistrationViewController ()

@end

@implementation RegistrationViewController

- (void)viewDidLoad {
    
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.

    pickerReg.delegate=nil;
    pickerReg.dataSource=nil;
    
    arrCollage = [[NSArray alloc] init];
    arrSem = [[NSArray alloc] initWithObjects:@"1", @"2",@"3",@"4",@"5",@"6",@"7",@"8",nil];
    
    CGSize screenSize = [UIScreen mainScreen].bounds.size;
    [scrlView setContentSize:CGSizeMake(screenSize.width,520)];
        
    // Fetching list of Cities
    WebCommunicationClass *obj=[WebCommunicationClass new];
    [obj setACaller:self];
    [obj Getcity];
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
//    vwReg.frame = CGRectMake(0,(self.view.frame.size.width==375?450:347), self.view.frame.size.width, 222);
    vwReg.frame = CGRectMake(0,(self.view.frame.size.height - 222), self.view.frame.size.width, 222);

    [UIView commitAnimations];
}

- (BOOL)validateEmail: (NSString *) candidate
{
    NSString *emailRegex = @"[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,4}";
    NSPredicate *emailTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", emailRegex];
    
    return [emailTest evaluateWithObject:candidate];
}

#pragma mark - IBActions

-(IBAction)btn_Back:(id)sender
{
    [self.navigationController popViewControllerAnimated:YES];
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

- (IBAction)Click_City:(id)sender
{
    [self resignAllTextFields];
    strBtnSelection=@"C";
    
    pickerReg.delegate=self;
    pickerReg.dataSource=self;
    [pickerReg reloadAllComponents];
    
    [self showPickerView];
}

- (IBAction)Click_Collage:(id)sender
{
    [self resignAllTextFields];
    strBtnSelection=@"CL";
    
    // Fetching list of Collages
    WebCommunicationClass *obj=[WebCommunicationClass new];
    [obj setACaller:self];
    [obj GetCollage:strCityId];
}

- (IBAction)Click_Submit:(id)sender {
    
    if(lblName.text.length==0 || lblNumber.text.length==0 || lblEmail.text.length==0 ||
       lblAddress.text.length==0 || lblCourse.text.length==0)
    {
        UIAlertView *alert =[[UIAlertView alloc]initWithTitle:@"" message:@"No field can be left blank!" delegate:nil cancelButtonTitle:@"Ok" otherButtonTitles:nil, nil];
        [alert show];
    }
    else if(btnCity.titleLabel.text.length==0 ||
            btnSem.titleLabel.text.length==0)
    {
        UIAlertView *alert =[[UIAlertView alloc]initWithTitle:@"" message:@"No field can be left blank!" delegate:nil cancelButtonTitle:@"Ok" otherButtonTitles:nil, nil];
        [alert show];
    }
    else if ([btnCollage.titleLabel.text isEqualToString:@"Select a college"]) {
        
        UIAlertView *alert =[[UIAlertView alloc]initWithTitle:@"" message:@"You must select a college!" delegate:nil cancelButtonTitle:@"Ok" otherButtonTitles:nil, nil];
        [alert show];
    }
    else if (lblNumber.text.length != 10)
    {
        // check for mobile number validation
        
        UIAlertView *alert =[[UIAlertView alloc]initWithTitle:@"" message:@"Please enter a valid mobile number!" delegate:nil cancelButtonTitle:@"Ok" otherButtonTitles:nil, nil];
        [alert show];
    }
    else if (![self validateEmail:lblEmail.text])
    {
        // check for email validation
        
        UIAlertView *alert=[[UIAlertView alloc]initWithTitle:@"" message:@"Please enter a valid email address!" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
        [alert show];
    }
    else
    {
        // Request to register with YIC
        
        WebCommunicationClass *obj=[WebCommunicationClass new];
        
        [obj setACaller:self];
        [obj GetRegestater:lblName.text mobile:lblNumber.text email:lblEmail.text city:strCityId localAddress:lblAddress.text collegeName:btnCollage.titleLabel.text course:lblCourse.text semester:btnSem.titleLabel.text];
    }
}

#pragma mark- Webservice callback

-(void) dataDidFinishDowloading:(ASIHTTPRequest*)aReq withMethood:(NSString *)MethoodName withOBJ:(WebCommunicationClass *)aObj
{
    NSError *jsonParsingError = nil;
    
    NSString *strResult=[NSJSONSerialization JSONObjectWithData:[aReq responseData]options:0 error:&jsonParsingError];
    
    NSLog(@"%@",[strResult valueForKey:@"responseObject"]);
    NSNumber * isSuccessNumber = (NSNumber *)[strResult valueForKey:@"errorCode"];
    
    if (aReq.tag==6)
    {
        if(isSuccessNumber.intValue==0)
        {
            arrCity = [strResult valueForKey:@"responseObject"];
            NSLog(@"%@",arrCity);
            
            [btnCity setTitle:[[arrCity valueForKey:@"cityName"] objectAtIndex:0] forState:UIControlStateNormal];
            strCityId = [NSString stringWithFormat:@"%@",[[arrCity valueForKey:@"cityId"] objectAtIndex:0]];
            
            [btnSem setTitle:[arrSem objectAtIndex:0] forState:UIControlStateNormal];
            
//            [lblName becomeFirstResponder];
        }
    }
    else if(aReq.tag==2)
    {
        if(isSuccessNumber.intValue==0)
        {
            arrCollage = [strResult valueForKey:@"responseObject"];
            NSLog(@"%@",arrCollage);
            
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
            GlobalDataPersistence *obj_GlobalDataPersistence=[GlobalDataPersistence sharedGlobalDataPersistence];
            obj_GlobalDataPersistence.strUserId=[NSString stringWithFormat:@"%@",[strResult valueForKey:@"responseObject"]];
            
            NSUserDefaults *defult=[NSUserDefaults standardUserDefaults];
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
    if([strBtnSelection isEqualToString:@"C"]) {
        return [arrCity count] ;
    }
    else if ([strBtnSelection isEqualToString:@"CL"]) {
        return [arrCollage count];
    }
    else {
        return [arrSem count] ;
    }
}

- (NSString *)pickerView:(UIPickerView *)pickerView titleForRow:
(NSInteger)row forComponent:(NSInteger)component {
    
    if([strBtnSelection isEqualToString:@"C"])
    {
        return [[arrCity valueForKey:@"cityName"] objectAtIndex:row];
    }
    else if ([strBtnSelection isEqualToString:@"CL"])
    {
        return [[arrCollage valueForKey:@"collegeName"] objectAtIndex:row];
    }
    else 
    {
        return [arrSem objectAtIndex:row];
    }
}

#pragma mark- Picker View Delegate

-(void)pickerView:(UIPickerView *)pickerView didSelectRow:
(NSInteger)row inComponent:(NSInteger)component {
    
    if([strBtnSelection isEqualToString:@"C"])
    {
        [btnCity setTitle:[[arrCity valueForKey:@"cityName"] objectAtIndex:row] forState:UIControlStateNormal];
        strCityId = [NSString stringWithFormat:@"%@",[[arrCity valueForKey:@"cityId"] objectAtIndex:row]];
        NSLog(@"%@",strCityId);
    }
    else if ([strBtnSelection isEqualToString:@"CL"])
    {
        [btnCollage setTitle:[[arrCollage valueForKey:@"collegeName"] objectAtIndex:row] forState:UIControlStateNormal];
        
        GlobalDataPersistence *obj_GlobalDataPersistence=[GlobalDataPersistence sharedGlobalDataPersistence];
        obj_GlobalDataPersistence.strCollageId = [NSString stringWithFormat:@"%@",[[arrCollage valueForKey:@"collegeId"] objectAtIndex:row]];
        
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
    
    if (textField == lblName) {
        [lblNumber becomeFirstResponder];
    }
    else if (textField == lblNumber) {
        [lblEmail becomeFirstResponder];
    }
    else if (textField == lblEmail) {
        [lblAddress becomeFirstResponder];
    }
    else if (textField == lblAddress) {
        [lblCourse becomeFirstResponder];
    }
    
    return YES;
}

- (void)textFieldDidBeginEditing:(UITextField *)textField
{
    [self hidePickerView];
    
    if(textField.tag==10) {
        [self animateViewUp:YES];
    }
}

- (void)textFieldDidEndEditing:(UITextField *)textField
{
    if(textField.tag==10) {
        [self animateViewUp:NO];
    }
}

- (void) animateViewUp:(BOOL)up
{
    [UIView beginAnimations: @"anim" context: nil];
    [UIView setAnimationBeginsFromCurrentState: YES];
    [UIView setAnimationDuration:0.3f];
    
    const int movementDistance = 130;
    int movement = (up ? -movementDistance : movementDistance);
    
    self.view.frame=CGRectOffset(self.view.frame, 0, movement);
    
    [UIView commitAnimations];
}

@end
