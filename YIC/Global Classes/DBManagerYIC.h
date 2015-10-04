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

- (NSString *)getHourlyCode:(NSString*)timeString;
- (NSMutableArray*)getAllRandomQuestion;
- (void)getUniquecode:(NSString*)strCode;
@end
