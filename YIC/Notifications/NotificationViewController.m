//
//  NotificationViewController.m
//  YIC
//
//  Created by Jatin on 10/5/15.
//
//

#import "NotificationViewController.h"

#import "WebCommunicationClass.h"
//#import "Config.h"
#import "GlobalDataPersistence.h"
@interface NotificationViewController ()

@end

@implementation NotificationViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    WebCommunicationClass *obj=[WebCommunicationClass new];
    [obj setACaller:self];
    [obj getUserNotices:[[NSUserDefaults standardUserDefaults] valueForKey:@"UserId"]];
}

-(IBAction)click_Back:(id)sender
{
    [self.navigationController popViewControllerAnimated:YES];
}


#pragma mark- Webservice callback

-(void) dataDidFinishDowloading:(ASIHTTPRequest*)aReq withMethood:(NSString *)MethoodName withOBJ:(WebCommunicationClass *)aObj
{
    NSError *jsonParsingError = nil;
    
    NSDictionary *resultDict=[NSJSONSerialization JSONObjectWithData:[aReq responseData]options:0 error:&jsonParsingError];
    
    NSLog(@"%@",[resultDict valueForKey:@"responseObject"]);
    NSNumber * isSuccessNumber = (NSNumber *)[resultDict valueForKey:@"errorCode"];
    
    if(isSuccessNumber.intValue==0)
    {
        arrayNotifications = [resultDict valueForKey:@"responseObject"];
        
        //[arrayNotifications objectAtIndex:<#(NSUInteger)#>] will result
/*        {
        "noticeId": "1",
        "notice": "Hi",
        "noticeDescription": "My name is Vibhor",
        "date": ""
        }
 */
        
        // TODO: load data into tableView.
        
    }
}



@end
