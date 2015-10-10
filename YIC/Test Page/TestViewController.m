//
//  TestViewController.m
//  CL-YIC
//
//  Created by Jatin on 9/21/15.
//
//

#import "TestViewController.h"
#import <Foundation/Foundation.h>
#import <sqlite3.h>
#import "GlobalDataPersistence.h"
#import "DBManagerYIC.h"
@interface TestViewController ()

@end

@implementation TestViewController

- (void)viewDidLoad {

    [super viewDidLoad];
    
    GlobalDataPersistence *obj_GlobalDataPersistence = [GlobalDataPersistence sharedGlobalDataPersistence];
    NSLog(@"%@",obj_GlobalDataPersistence.strCollageId);
   
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"hh:mm a"];
    NSString *strDate = [formatter stringFromDate:[NSDate date]];
    
    DBManagerYIC *obj_DBManagerYIC=[DBManagerYIC new];
    
    NSString *strhourlycode = [obj_DBManagerYIC getHourlyCode:strDate];
    NSLog(@"%@",strhourlycode);

    NSArray *arr = [obj_DBManagerYIC getAllRandomQuestion];
    NSLog(@"%@",arr);
    
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

@end
