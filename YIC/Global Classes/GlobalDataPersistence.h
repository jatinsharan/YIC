//
//  GlobalDataPersistence.h
//  FingerOlympic
//
//  Created by RahulSharma on 6/5/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#define KUSER_DEFAULT [NSUserDefaults standardUserDefaults]

#define KCOLLAGE_ID @"COLLAGE_ID"
#define KUSER_ID @"USER_ID"
#define KPASSCODE @"PASSCODE"

#define KIS_OTP @"ISOTP"
#define KIS_LOGIN @"ISLOGIN"

#define KTOTALMARK @"TOTALMARK"
#define KTIME_TAKEN @"TIMETAKEN"

#define KIS_TEST_ATTEMPTED @"IS_TEST_ATTEMPTED"
#define KIS_TEST_SYNCED @"IS_TEST_SYNCED"

#define KDEFAULT_RECT CGRectMake(20, 8, 280, 21)
#define KOPTION_RECT CGRectMake(12, 8, 280, 24)
#define KMAX_WIDTH 280

#import <Foundation/Foundation.h>

@interface GlobalDataPersistence : NSObject

@property(nonatomic,assign)int correctPoint;

+ (GlobalDataPersistence *)sharedGlobalDataPersistence;

@end
