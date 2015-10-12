//
//  GlobalGameSettings.m
//  FingerOlympic
//
//  Created by RahulSharma on 6/5/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "GlobalDataPersistence.h"

@implementation GlobalDataPersistence

+ (GlobalDataPersistence *)sharedGlobalDataPersistence
{
    static GlobalDataPersistence *sharedGlobalDataPersistence = nil;

    @synchronized(self) {
        
        if(sharedGlobalDataPersistence == nil) {
            sharedGlobalDataPersistence = [[GlobalDataPersistence alloc] init];
        }
    }
	
	return sharedGlobalDataPersistence;
}

@end
