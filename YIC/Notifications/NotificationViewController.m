//
//  NotificationViewController.m
//  YIC
//
//  Created by Jatin on 10/5/15.
//
//

#import "NotificationViewController.h"

#import "WebCommunicationClass.h"
#import "GlobalDataPersistence.h"
#import "CalendarCell.h"

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

        if (arrayNotifications.count > 0) {
            // TODO: load data into tableView.
            tblNotification.hidden = NO;
            [tblNotification reloadData];
        }
        else {
            // TODO: display an alert.

        }
        
        //[arrayNotifications objectAtIndex:] will result
/*        {
        "noticeId": "1",
        "notice": "Hi",
        "noticeDescription": "My name is Vibhor",
        "date": ""
        }
 */
        
        
    }
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    // Return the number of rows.
    return arrayNotifications.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 90;
}

// Customize the appearance of table view cells.
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    static NSString *CellIdentifier = @"NotificationCellID";
    
    CalendarCell *cell = (CalendarCell *)[tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        UIViewController *view = [[UIViewController alloc]initWithNibName:@"CalendarCell" bundle:nil];
        cell = (CalendarCell *)view.view;
    }
    
    NSDictionary *notice = (NSDictionary*)[arrayNotifications objectAtIndex:indexPath.row];
    
    cell.lblMainHeading.text = [notice valueForKey:@"notice"];
    cell.lblSubHeading.text = [notice valueForKey:@"noticeDescription"];
    
    NSArray* dateArray = [[notice valueForKey:@"date"] componentsSeparatedByString: @" "];
    cell.lblboxdate.text = [dateArray objectAtIndex:0];
    cell.lbldate.text = [NSString stringWithFormat:@"%@ %@",[dateArray objectAtIndex:1],[dateArray objectAtIndex:2]];
    
    cell.imgDate.layer.cornerRadius=cell.imgDate.frame.size.width/2;
    cell.imgDate.clipsToBounds=YES;
    
    cell.selectionStyle = UITableViewCellSeparatorStyleNone;
    cell.selectedBackgroundView.backgroundColor = [UIColor clearColor];
    
    return cell;
}

#pragma mark - Table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
}


@end
