//
//  GlobalDataPersistence.h
//  FingerOlympic
//
//  Created by RahulSharma on 6/5/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface GlobalDataPersistence : NSObject
{
    
}
@property(nonatomic,strong)NSArray *arrQuestions;
@property(nonatomic,strong)NSString *strCollageId;
@property(nonatomic,assign)int correctPoint;


+ (GlobalDataPersistence *)sharedGlobalDataPersistence;
+ (void)resetGlobalDataPersistence;

@end
