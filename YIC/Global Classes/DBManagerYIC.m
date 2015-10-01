//
//  DBManagerYIC.m
//  YIC
//
//  Created by ROHIT on 01/10/15.
//
//

#import "DBManagerYIC.h"
#import "QuestionYIC.h"

@implementation DBManagerYIC

#pragma mark - Db setup

- (NSString *) getDBPath {
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory , NSUserDomainMask, YES);
    NSString *documentsDir = [paths objectAtIndex:0];
    return [documentsDir stringByAppendingPathComponent:@"yic.db"];
}

- (void) copyDatabaseIfNeeded {
    
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

#pragma mark - datasource methods

- (NSString *)getHourlyCode:(NSString*)strDate
{
    sqlite3 *database;
    
    NSString *result = @"";
    
    NSString *sql = [NSString stringWithFormat:@"SELECT * FROM hourly_code WHERE slot LIKE \"%@\"",strDate];
    sqlite3_stmt * statement;
    
    if(sqlite3_open([[self getDBPath] UTF8String], &database) == SQLITE_OK)
    {
        int sqlResult = sqlite3_prepare_v2(database, [sql UTF8String], -1, &statement, NULL);
        
        if(sqlResult == SQLITE_OK)
        {
            while(sqlite3_step(statement) == SQLITE_ROW)
            {
                //int id = sqlite3_column_int(selectStatement, 0);
                result = [NSString stringWithUTF8String:(char *)sqlite3_column_text(statement,1)];
            }
            
        }
        else {
            result = nil;
            printf( "could not prepare statemnt: %s\n", sqlite3_errmsg(database) );
        }
        
        sqlite3_reset(statement);
        sqlite3_finalize(statement);
        
        sqlite3_close(database);
    }
    
    return result;
}

- (NSMutableArray*)getAllRandomQuestion
{
    NSMutableArray *result = [NSMutableArray new];
    
    int startId = 0;
    int endId = 20;
    
    while (result.count<45) {
        
        NSArray *arrQuestion = [self getQuestionsRandomWhereStartId:startId andEndID:endId];
        [result addObjectsFromArray:arrQuestion];
        
        if (endId<80) {
            startId = startId+20;
            endId = endId+20;
        }
        else if (endId<83) {
            if (myRandom()==1) {
                startId = 80;
                endId = 83;
            }
            else {
                startId = 83;
                endId = 86;
            }
        }
        else {
            if (myRandom()==1) {
                startId = 86;
                endId = 88;
            }
            else {
                startId = 88;
                endId = 90;
            }
        }
    }
    
    NSLog(@"%@",[result valueForKey:@"qId"]);
    return result;
}

- (NSMutableArray *)getQuestionsRandomWhereStartId:(int)startId andEndID:(int)endId
{
    sqlite3 *database;
    
    NSMutableArray *result = [NSMutableArray new];
    
    NSString *sql = [NSString stringWithFormat:@"SELECT * FROM questions where question_id > %d AND question_id <= %d order by random() limit 10",startId,endId];
    
    sqlite3_stmt * statement;
    
    if(sqlite3_open([[self getDBPath] UTF8String], &database) == SQLITE_OK)
    {
        int sqlResult = sqlite3_prepare_v2(database, [sql UTF8String], -1, &statement, NULL);
        
        if(sqlResult == SQLITE_OK)
        {
            while(sqlite3_step(statement) == SQLITE_ROW)
            {
                QuestionYIC *question = [QuestionYIC new];
                
                question.qSection = [NSString stringWithUTF8String:(char *)sqlite3_column_text(statement,0)];
                question.qId = sqlite3_column_int(statement, 1);
                
                question.qLevel = [NSString stringWithUTF8String:(char *)sqlite3_column_text(statement,2)];
                question.qInstruction = [NSString stringWithUTF8String:(char *)sqlite3_column_text(statement,3)];
                
                question.qQuestion = [NSString stringWithUTF8String:(char *)sqlite3_column_text(statement,4)];
                question.qOption_1 = [NSString stringWithUTF8String:(char *)sqlite3_column_text(statement,5)];
                question.qOption_2 = [NSString stringWithUTF8String:(char *)sqlite3_column_text(statement,6)];
                question.qOption_3 = [NSString stringWithUTF8String:(char *)sqlite3_column_text(statement,7)];
                question.qOption_4 = [NSString stringWithUTF8String:(char *)sqlite3_column_text(statement,8)];

                question.qCorrectOption = [NSString stringWithUTF8String:(char *)sqlite3_column_text(statement,9)];
                question.qMarks = sqlite3_column_int(statement, 10);
                
                [result addObject:question];
            }
            
        }
        else {
            result = nil;
            printf( "could not prepare statemnt: %s\n", sqlite3_errmsg(database) );
        }
        
        sqlite3_reset(statement);
        sqlite3_finalize(statement);
        
        sqlite3_close(database);
    }
    
    return result;
}

int myRandom() {
    return (arc4random() % 2 ? 1 : 0);
}

@end
