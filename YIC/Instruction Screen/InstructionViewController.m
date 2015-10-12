//
//  InstructionViewController.m
//  YIC
//
//  Created by Jatin on 10/1/15.
//
//

#import "InstructionViewController.h"
#import "QuestionViewController.h"

@interface InstructionViewController ()

@end

@implementation InstructionViewController

- (void)viewDidLoad {
    
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    [scrInstrucation setContentSize:CGSizeMake(self.view.frame.size.width, 1298)];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(IBAction)Click_Back:(id)sender
{
    [self.navigationController popViewControllerAnimated:YES];
}

-(IBAction)Click_StartTest:(id)sender
{
    BOOL isTestAttempted = [[NSUserDefaults standardUserDefaults] boolForKey:@"IS_TEST_ATTEMPTED"];
    if (!isTestAttempted) {
        QuestionViewController *obj_QuestionViewController=[QuestionViewController new];
        [self.navigationController pushViewController:obj_QuestionViewController animated:YES];
    }
    else {
        
        // Test already attempted by user, display alert
        
        UIAlertView *alert =[[UIAlertView alloc]initWithTitle:@"" message:@"Test Submitted! Kindly check notifications for Final Results." delegate:nil cancelButtonTitle:@"Ok" otherButtonTitles:nil, nil];
        [alert show];
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

@end
