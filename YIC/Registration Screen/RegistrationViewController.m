//
//  RegistrationViewController.m
//  CL-YIC
//
//  Created by Jatin on 9/5/15.
//
//

#import "RegistrationViewController.h"
#import "WebCommunicationClass.h"
#import "PPPinPadViewController.h"
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
    arrCity=[[NSArray alloc] initWithObjects:@"Agra",@"Ahmedabad",@"Ajmer",@"Allahabad",@"Ambala",@"Amritsar",@"Asansol",@"Bangalore",@"Bathinda",@"Bhagalpur",@"Bhilai",@"Bhilwara",@"Bhopal",@"Bhubaneswar",@"Bhopal",@"Bhubaneswar",@"Chandigarh",@"Chennai",@"Cochin",@"Dehradun",@"Dhanbad",@"Durgapur",@"Faridabad",@"Gandhinagar",@"Ghaziabad",@"Greater Noida",@"Gurgaon",@"Gwalior",@"Haldwani",@"Hissar",@"Hyderabad",@"Indore",@"Jabalpur",@"Jalandhar",@"Jammu",@"Jamshedpur",@"Jodhpur",@"Kanpur",@"karnal",@"Jaipur",@"Kolkata",@"Kullu",@"Kurukshetra",@"Lucknow",@"Ludhiana",@"Meerut",@"Moradabad",@"Mumbai",@"Nagpur",@"New Delh",@"Noida",@"Patiala",@"Patna",@"Pune",@"Raipur",@"Rajkot",@"Ranchi",@"Rewa",@"Rohtak",@"Roorkee",@"Rudrapur",@"Saharanpur",@"Siliguri",@"Udaipur",@"Varanasi",@"Yamunanagar",nil];
    
    // Do any additional setup after loading the view from its nib.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/
-(void)CreateCity
{
    
}
- (IBAction)Click_City:(id)sender {
    
    strBtnSelection=@"C";
    pickerReg.delegate = self;
    pickerReg.dataSource = self;
    [pickerReg reloadAllComponents];
    
    [UIView beginAnimations:nil context:NULL];
    [UIView setAnimationDuration:0.3];
    vwReg.frame = CGRectMake(0,(self.view.frame.size.width==375?450:347), self.view.frame.size.width, 222);
    [UIView commitAnimations];
    
    [self.view addSubview:vwReg];
    
}

- (IBAction)Click_Collage:(id)sender {
    
    strBtnSelection=@"Cl";
    
    WebCommunicationClass *obj=[WebCommunicationClass new];
    
    [obj setACaller:self];
    
    [obj GetCity:@"1"];
}

- (IBAction)Click_Sem:(id)sender {
    
    strBtnSelection=@"S";
    pickerReg.delegate = self;
    pickerReg.dataSource = self;
    [pickerReg reloadAllComponents];
    [UIView beginAnimations:nil context:NULL];
    [UIView setAnimationDuration:0.3];
    vwReg.frame = CGRectMake(0,(self.view.frame.size.width==375?450:347), self.view.frame.size.width, 222);
    [UIView commitAnimations];
    
    [self.view addSubview:vwReg];
}

- (IBAction)Click_Submit:(id)sender {
    
    OTPassViewController * pinViewController = [[OTPassViewController alloc] init];
    
    [self.navigationController pushViewController:pinViewController animated:YES];
    
    
//    WebCommunicationClass *obj=[WebCommunicationClass new];
//    
//    [obj setACaller:self];
//    [obj GetRegestater:lblName.text mobile:lblNumber.text email:lblEmail.text city:strCityId localAddress:lblAddress.text collegeName:btnCollage.titleLabel.text course:lblCourse.text semester:btnSem.titleLabel.text];
}
- (BOOL)checkPin:(NSString *)pin {
    
    return [pin isEqualToString:@"123456"];
    
}


- (NSInteger)pinLenght {
    return 6 ;
}
#pragma mark- Webservice callback
#pragma mark-
-(void) dataDidFinishDowloading:(ASIHTTPRequest*)aReq withMethood:(NSString *)MethoodName withOBJ:(WebCommunicationClass *)aObj
{
    NSError *jsonParsingError = nil;
    
    NSString *strResult=[NSJSONSerialization JSONObjectWithData:[aReq responseData]options:0 error:&jsonParsingError];
    
    NSLog(@"%@",[strResult valueForKey:@"errorCode"]);
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
        
        [UIView beginAnimations:nil context:NULL];
        [UIView setAnimationDuration:0.3];
        vwReg.frame = CGRectMake(0,(self.view.frame.size.width==375?450:347), self.view.frame.size.width, 222);
        [UIView commitAnimations];
        
        [self.view addSubview:vwReg];
    }
    }
    else
    {
        if(isSuccessNumber)
        {
                        
        }
    
    
    }
}

#pragma mark - Picker View Data source
-(NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView{
    return 1;
}
-(NSInteger)pickerView:(UIPickerView *)pickerView
numberOfRowsInComponent:(NSInteger)component{
    
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
    [btnCity setTitle:[arrCity objectAtIndex:row] forState:UIControlStateNormal];
        strCityId=[NSString stringWithFormat:@"%ld",row+1];
        NSLog(@"%@",strCityId);
    }
    else if ([strBtnSelection isEqualToString:@"Cl"])
    {
    
    [btnCollage setTitle:[[arrCollage valueForKey:@"collegeName"] objectAtIndex:row] forState:UIControlStateNormal];
        GlobalDataPersistence *obj_GlobalDataPersistence=[GlobalDataPersistence sharedGlobalDataPersistence];
        obj_GlobalDataPersistence.strCollageId=[NSString stringWithFormat:@"%@",[[arrCollage valueForKey:@"collegeId"] objectAtIndex:row]];
    }
    
    else
    {
    [btnSem setTitle:[arrSem objectAtIndex:row] forState:UIControlStateNormal];
    }
    [UIView beginAnimations:nil context:NULL];
    [UIView setAnimationDuration:0.3];
    vwReg.frame = CGRectMake(0,750, self.view.frame.size.width, 222);
    [UIView commitAnimations];
    
    //[txtjobdesc resignFirstResponder];
    [self.view addSubview:vwReg];
    
    
}
- (NSString *)pickerView:(UIPickerView *)pickerView titleForRow:
(NSInteger)row forComponent:(NSInteger)component{
    
    if([strBtnSelection isEqualToString:@"C"])
    {
        return [arrCity objectAtIndex:row];
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
-(IBAction)btn_Back:(id)sender
{

    [self.navigationController popViewControllerAnimated:YES];
}

@end
