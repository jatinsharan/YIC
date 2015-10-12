//
//  InstructionViewController.m
//  YIC
//
//  Created by Jatin on 10/1/15.
//
//

#import "InstructionViewController.h"
#import "QuestionViewController.h"
#import "GlobalDataPersistence.h"

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
    QuestionViewController *obj_QuestionViewController=[QuestionViewController new];
    [self.navigationController pushViewController:obj_QuestionViewController animated:YES];
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
