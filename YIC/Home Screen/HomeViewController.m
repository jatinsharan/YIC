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
    
    NSURL *OBJURL=[NSURL URLWithString:@"https://play.google.com/store/apps/details?id=com.mobiquel.yic"];
    NSArray *postItems = @[@"CL-YIC", OBJURL];
    
    UIActivityViewController *activityVC = [[UIActivityViewController alloc]
                                            initWithActivityItems:postItems
                                            applicationActivities:nil];
    
    [self presentViewController:activityVC animated:YES completion:nil];
}
@end
