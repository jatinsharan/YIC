//
//  HomeViewController.m
//  CL-YIC
//
//  Created by Jatin on 9/3/15.
//
//

#import "HomeViewController.h"
#import "YICRoundsViewController.h"
#import "UnlockViewController.h"
#import "NotificationViewController.h"
#import "InstructionViewController.h"

#import "WebCommunicationClass.h"
#import "GlobalDataPersistence.h"

@interface HomeViewController ()

@end

@implementation HomeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)viewWillAppear:(BOOL)animated {
    
    [super viewWillAppear:YES];
    
    BOOL isTestAttempted = [KUSER_DEFAULT boolForKey:KIS_TEST_ATTEMPTED];
    BOOL isTestSynced = [KUSER_DEFAULT boolForKey:KIS_TEST_SYNCED];

    if (isTestAttempted && !isTestSynced) {
        btnSync.hidden = NO;
    }
    else {
        btnSync.hidden = YES;
    }
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

- (IBAction)Click_YICRounds:(id)sender {
    
    YICRoundsViewController *obj_HomeViewController=[YICRoundsViewController new];
    [self.navigationController pushViewController:obj_HomeViewController animated:YES];
}

- (IBAction)Click_Notifications:(id)sender {
    NotificationViewController *obj_NotificationViewController=[NotificationViewController new];
    [self.navigationController pushViewController:obj_NotificationViewController animated:YES];
}

- (IBAction)Click_TakeTest:(id)sender {
    
    BOOL isTestAttempted = [KUSER_DEFAULT boolForKey:KIS_TEST_ATTEMPTED];
    if (!isTestAttempted) {
        UnlockViewController *obj_UnlockViewController=[UnlockViewController new];
        [self.navigationController pushViewController:obj_UnlockViewController animated:YES];
    }
    else {
        
        // Test already attempted by user, display alert
        
        UIAlertView *alert =[[UIAlertView alloc]initWithTitle:@"" message:@"Test Submitted! Kindly check notifications for Final Results." delegate:nil cancelButtonTitle:@"Ok" otherButtonTitles:nil, nil];
        [alert show];
    }
    
}

- (IBAction)Click_Share:(id)sender {
    
    NSString *body = @"Hi, I am participating in CL Young India Challenge: Business Plan and Start-up Challenge.You can too by downloading the app and appearing for App based Prelim College Round. Download Now";
    
    NSString *itunesAPPID = @"1047789943";
    NSString *appStoreURL = [NSString stringWithFormat:@"itms-apps://itunes.apple.com/app/id%@",itunesAPPID];
    
    NSArray *activityItems = @[body,appStoreURL];
    
    UIActivityViewController *activityViewController = [[UIActivityViewController alloc] initWithActivityItems:activityItems applicationActivities:nil];
    [activityViewController setValue:@"CL Young India Challenge: Business Plan and Start-up Challenge is around the corner" forKey:@"subject"];
    
    [self.navigationController presentViewController:activityViewController animated:YES completion:nil];
}

- (IBAction)Click_Sync:(id)sender {
    
    NSDateFormatter *formatter = [NSDateFormatter new];
    [formatter setDateFormat:@"dd/MM/yyyy"];
    NSString *testDate = [formatter stringFromDate:[NSDate date]];
    
    WebCommunicationClass *obj = [WebCommunicationClass new];
    [obj setACaller:self];
    
    [obj GetSaveUserdetail:[KUSER_DEFAULT valueForKey:KUSER_ID]
                  testDate:[NSString stringWithFormat:@"%@",testDate]
                  passcode:[KUSER_DEFAULT valueForKey:KPASSCODE]
                 timeTaken:[NSString stringWithFormat:@"%ld",(long)[KUSER_DEFAULT integerForKey:KTIME_TAKEN]]
                     marks:[NSString stringWithFormat:@"%ld",(long)[KUSER_DEFAULT integerForKey:KTOTALMARK]]];
    
}

- (void)dataDidFinishDowloading:(ASIHTTPRequest*)aReq withMethood:(NSString *)MethoodName withOBJ:(WebCommunicationClass *)aObj
{
    NSError *jsonParsingError = nil;
    
    NSDictionary *resultDict = (NSDictionary*)[NSJSONSerialization JSONObjectWithData:[aReq responseData]options:0 error:&jsonParsingError];
    NSLog(@"%@",[resultDict valueForKey:@"errorCode"]);
    
    NSNumber * isSuccessNumber = (NSNumber *)[resultDict valueForKey:@"errorCode"];
    if(isSuccessNumber.intValue == 0) {
        
        // Test Result successfully synced to server
        
        [KUSER_DEFAULT setBool:TRUE forKey:@"IS_TEST_SYNCED"];
        [KUSER_DEFAULT synchronize];
        
        btnSync.hidden = YES;
    }
    else {
        
        // Error
        
    }
}

-(void) dataDownloadFail:(ASIHTTPRequest*)aReq  withMethood:(NSString *)MethoodName
{
    
}

@end
