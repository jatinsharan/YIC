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
@interface TestViewController ()

@end

@implementation TestViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self copyDatabaseIfNeeded];
    
    GlobalDataPersistence *obj_GlobalDataPersistence=[GlobalDataPersistence sharedGlobalDataPersistence];
    NSLog(@"%@",obj_GlobalDataPersistence.strCollageId);
   
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"hh:mm a"];
    NSLog(@"Current Date: %@", [formatter stringFromDate:[NSDate date]]);
    
    NSString *strhourlycode=[self getHourlyCode:[formatter stringFromDate:[NSDate date]]];
    
    NSLog(@"%@",strhourlycode);
    
    
    // Do any additional setup after loading the view from its nib.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
#pragma mark Class functions
- (NSString *) getDBPath {
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory , NSUserDomainMask, YES);
    NSString *documentsDir = [paths objectAtIndex:0];
    return [documentsDir stringByAppendingPathComponent:@"yic.db"];
}
-(void) copyDatabaseIfNeeded {
    NSFileManager *fileManager = [NSFileManager defaultManager];
    NSError *error;
    NSString *dbPath = [self getDBPath];
    BOOL success = [fileManager fileExistsAtPath:dbPath];
    
    if(!success) {
        
        NSString *defaultDBPath = [[[NSBundle mainBundle] resourcePath] stringByAppendingPathComponent:@"yic.db"];
        success = [fileManager copyItemAtPath:defaultDBPath toPath:dbPath error:&error];
        
        if (!success)
            NSAssert1(0, @"Failed to create writable database file with message '%@'.", [error localizedDescription]);
    }
}

- (NSString *)getHourlyCode:(NSString*)strDate
{

    sqlite3 *database;
    ;
    NSMutableArray *result = [[NSMutableArray alloc]init] ;
    
    NSString *sql = [NSString stringWithFormat:@"SELECT * FROM hourly_code WHERE slot LIKE \"%@\"",strDate];
    sqlite3_stmt * statement;
    
    if(sqlite3_open([[self getDBPath] UTF8String], &database) == SQLITE_OK)
    {
        int sqlResult = sqlite3_prepare_v2(database, [sql UTF8String], -1, &statement, NULL);
        
        if(sqlResult == SQLITE_OK)
        {
            while(sqlite3_step(statement) == SQLITE_ROW)
            {
                //int key = sqlite3_column_int(selectStatement, 0);
               
                NSString *Strname = [NSString stringWithUTF8String:(char *)sqlite3_column_text(statement,1)];
            
                
                
                
               NSDictionary * dict1=[[NSMutableDictionary alloc]init];
                
                [dict1 setValue:Strname forKey:@"Date"];
                
                
                // Create a new animal object with the data from the database
                
                
                // Add the animal object to the animals Array
              
                
                NSLog(@"%@",dict1);
                dict1=nil;
                
                
                
                // Loop through the results and add them to the feeds array
            }

        } else
        {
            result = nil;
            printf( "could not prepare statemnt: %s\n", sqlite3_errmsg(database) );
        }
        
        sqlite3_reset(statement);
        sqlite3_finalize(statement);
        
        sqlite3_close(database);
    }
    return result;
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
