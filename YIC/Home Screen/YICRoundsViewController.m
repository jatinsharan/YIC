//
//  YICRoundsViewController.m
//  CL-YIC
//
//  Created by Jatin on 9/3/15.
//
//

#import "YICRoundsViewController.h"

@interface YICRoundsViewController ()

@end

@implementation YICRoundsViewController

- (void)viewDidLoad {
    
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    CGSize screenSize = [UIScreen mainScreen].bounds.size;
    [scrYic setContentSize:CGSizeMake(screenSize.width,2524)];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(IBAction)ClickBack:(id)sender{
    [self.navigationController popViewControllerAnimated:YES];
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
