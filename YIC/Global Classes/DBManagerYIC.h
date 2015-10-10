//
//  DBManagerYIC.h
//  YIC
//
//  Created by ROHIT on 01/10/15.
//
//

#import <Foundation/Foundation.h>
#import <sqlite3.h>

@interface DBManagerYIC : NSObject

- (void) copyDatabaseIfNeeded;

- (NSMutableArray*)getAllRandomQuestion;

- (BOOL)checkLockCode:(NSString*)lockCode;
- (NSString*)getHourlyCode:(NSString*)timeString;

@end
