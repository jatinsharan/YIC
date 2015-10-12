//
//  ResultViewController.m
//  YIC
//
//  Created by Jatin on 10/1/15.
//
//

#import "ResultViewController.h"
#import "HomeViewController.h"
#import <Foundation/Foundation.h>
#import <sqlite3.h>
#import "GlobalDataPersistence.h"
#import "DBManagerYIC.h"
#import "WebCommunicationClass.h"

@interface ResultViewController ()
{
    GlobalDataPersistence *obj_GlobalDataPersistence;
}

@end

@implementation ResultViewController

- (void)viewDidLoad {
    
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.

    obj_GlobalDataPersistence = [GlobalDataPersistence sharedGlobalDataPersistence];
    lblScore.text=[NSString stringWithFormat:@"Your Score is :%d",obj_GlobalDataPersistence.correctPoint];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(IBAction)Click_Home:(id)sender
{
    HomeViewController *obj_HomeViewController=[HomeViewController new];
    [self.navigationController pushViewController:obj_HomeViewController animated:YES];
}

- (void)syncTestResult {
    
    WebCommunicationClass *obj=[WebCommunicationClass new];
    [obj setACaller:self];
    
    [obj GetSaveUserdetail:[[NSUserDefaults standardUserDefaults] valueForKey:@"UserId"]
                  testDate:[NSString stringWithFormat:@"%@",[NSDate date]]
                  passcode:obj_GlobalDataPersistence.strPasscode
                 timeTaken:[NSString stringWithFormat:@"%d",3000]
                     marks:[NSString stringWithFormat:@"%d",obj_GlobalDataPersistence.correctPoint]];
    
}

- (void)dataDidFinishDowloading:(ASIHTTPRequest*)aReq withMethood:(NSString *)MethoodName withOBJ:(WebCommunicationClass *)aObj
{
    NSError *jsonParsingError = nil;
    
    NSDictionary *resultDict = (NSDictionary*)[NSJSONSerialization JSONObjectWithData:[aReq responseData]options:0 error:&jsonParsingError];
    NSLog(@"%@",[resultDict valueForKey:@"errorCode"]);
    
    NSNumber * isSuccessNumber = (NSNumber *)[resultDict valueForKey:@"errorCode"];
    if(isSuccessNumber.intValue == 0) {
        
        // Test Result successfully synced to server
        
        [[NSUserDefaults standardUserDefaults] setBool:TRUE forKey:@"IS_TEST_SYNCED"];
        [[NSUserDefaults standardUserDefaults] synchronize];
        
    }
    else {
        
        // Error
        
    }
}

-(void) dataDownloadFail:(ASIHTTPRequest*)aReq  withMethood:(NSString *)MethoodName
{
    
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
