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
    UnlockViewController *obj_UnlockViewController=[UnlockViewController new];
    [self.navigationController pushViewController:obj_UnlockViewController animated:YES];
}

- (IBAction)Click_Share:(id)sender {
    
    NSString *title = @"Hi, I am participating in CL Young India Challenge: Business Plan and Start-up Challenge.You can too by downloading the app and appearing for App based Prelim College Round. Download Now";
     NSURL *OBJURL=[NSURL URLWithString:@"https://play.google.com/store/apps/details?id=com.mobiquel.yic"];
    
    NSArray *activityItems = @[title,OBJURL];
    
    UIActivityViewController *activityViewController = [[UIActivityViewController alloc] initWithActivityItems:activityItems applicationActivities:nil];
    [activityViewController setValue:@"CL Young India Challenge: Business Plan and Start-up Challenge is around the corner" forKey:@"subject"];
    
    [self.navigationController presentViewController:activityViewController animated:YES completion:nil];
}

@end
