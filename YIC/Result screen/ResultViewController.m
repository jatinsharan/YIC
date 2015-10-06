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
@interface ResultViewController ()
{
    GlobalDataPersistence *obj_GlobalDataPersistence;

}

@end

@implementation ResultViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    lblScore.text=[NSString stringWithFormat:@"Your Score is :%d",obj_GlobalDataPersistence.correctPoint];
       // Do any additional setup after loading the view from its nib.
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

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
