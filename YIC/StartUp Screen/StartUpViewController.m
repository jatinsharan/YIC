//
//  StartUpViewController.m
//  CL-YIC
//
//  Created by Jatin on 9/2/15.
//
//

#import "StartUpViewController.h"
#import "RegistrationViewController.h"

@interface StartUpViewController ()

@end

@implementation StartUpViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(IBAction)Click_Registration:(id)sender
{
    RegistrationViewController *obj_HomeViewController=[RegistrationViewController new];
    [self.navigationController pushViewController:obj_HomeViewController animated:YES];
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
