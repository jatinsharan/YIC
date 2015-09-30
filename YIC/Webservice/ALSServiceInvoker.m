//
//  ALServiceInvoker.m
//  AliveAirtel
//
//  Created by Bhupendra on 2/5/13.
//  Copyright (c) 2013 __MyCompanyName__. All rights reserved.
//

#import "ALServiceInvoker.h"
#import "ALUtilityClass.h"
#import "Config.h"

@implementation ALServiceInvoker

@synthesize delegate = _delegate;

#pragma mark - Singleton Class Method
 
+ (ALServiceInvoker*)sharedInstance {
	static ALServiceInvoker* instance = nil;
	
	@synchronized(self) {
		if(instance == nil) {
			instance = [[self alloc] init];
		}
	}
	return(instance);
}


#pragma mark - USER_API Request Methods

- (void)serviceInvokerRequestWithParams:(NSDictionary *)postParams requestAPI:(NSString *)stringURL reqTag:(NSInteger)tag delegate:(id<ALServiceInvokerDelegate>)delegate {

    @try {
        
        self.delegate = delegate;
        
        if ([ALUtilityClass isNetworkAvailable])
        {
            // ********* Initialise Request ******** //
            NSURL *url = [NSURL URLWithString:[BASE_URL_STRING stringByAppendingString:stringURL]];
            
            ASIFormDataRequest *request = [[ASIFormDataRequest alloc]initWithURL:url];
            request.tag = tag;
            
            if (postParams != nil)
            {
                for (NSString *key in postParams)
                {
                    [request addPostValue:[postParams objectForKey:key] forKey:key];
                    
                    if ([key isEqualToString:@"file"]) {
                        [request addData:[postParams objectForKey:key] withFileName:@"image.jpg" andContentType:@"image/jpeg" forKey:@"file"];
                    }
                }
            }
            
            [request addPostValue:[ALUtilityClass getDeviceIdentifier] forKey:@"deviceId"];
            
            
            __weak typeof(request) weakRequest = request;
            
            [request setCompletionBlock:^{
                
                __strong typeof(request) strongRequest = weakRequest;
                
                switch(strongRequest.responseStatusCode)
                {
                    case 200:
                    {
                        if ([strongRequest.url.path isEqualToString:@"/SchoolApp/rest/service/uploadHomeworkAttachment"]) {
                            
                            if([_delegate respondsToSelector:@selector(serviceInvokerRequestFinished:)]){
                                [_delegate performSelector:@selector(serviceInvokerRequestFinished:) withObject:strongRequest];
                            }
                            
                            return;
                        }
                        
                        NSError *error = nil;
                        NSDictionary *responseDict = [NSJSONSerialization JSONObjectWithData:strongRequest.responseData options:NSJSONReadingMutableLeaves error:&error];
                        
                        if (error == nil && responseDict != nil)
                        {
                            if ([[[responseDict objectForKey:@"errorCode"] stringValue] isEqualToString:@"0"])
                            {
                                if([_delegate respondsToSelector:@selector(serviceInvokerRequestFinished:)]){
                                    [_delegate performSelector:@selector(serviceInvokerRequestFinished:) withObject:strongRequest];
                                }
                            }
                            else
                            {
                                
                                if([_delegate respondsToSelector:@selector(serviceInvokerRequestFailed:)]) {
                                    [_delegate serviceInvokerRequestFailed:strongRequest];
                                }
                                
                                [ALUtilityClass showAlertwithTitle:@"Error" message:[responseDict objectForKey:@"errorMessage"]];
                            }
                        }
                        else
                        { // Error scenarios covered.
                            
                            //if (error != nil)
//                                [ALUtilityClass showAlertwithTitle:@"Error" message:@"Unfortunately We are unable to serve your request, Please try again later."];
                            // [ALUtilityClass showAlertwithTitle:@"Error" message:@"Unfortunately server connection failed, Please try again."];
                            
                            if([_delegate respondsToSelector:@selector(serviceInvokerRequestFailed:)]) {
                                [_delegate serviceInvokerRequestFailed:strongRequest];
                            }
                        }
                        
                        break;
                    }
                        
                    default:
                    {
                        NSLog(@"failed: server error code: %i",strongRequest.responseStatusCode);
                        
                        [ALUtilityClass showAlertwithTitle:@"Error" message:@"Unfortunately We are unable to serve your request, Please try again later."];
                        
                        if([_delegate respondsToSelector:@selector(serviceInvokerRequestFailed:)]) {
                            [_delegate serviceInvokerRequestFailed:strongRequest];
                        }
                        
                        break;
                    }
                }
                
                //nslog(@"API service Response: %@",strongRequest.responseString);
            }];
            
            
            [request setFailedBlock:^{ // Some error b/w the server-client communication
                
                __strong typeof(request) strongRequest = weakRequest;
                
                if([_delegate respondsToSelector:@selector(serviceInvokerRequestFailed:)]) {
                    [_delegate serviceInvokerRequestFailed:strongRequest];
                }
                
                [ALUtilityClass showAlertwithTitle:@"Error" message:[[[strongRequest.error userInfo] objectForKey:NSUnderlyingErrorKey] localizedDescription]];
            
            }];
            
            request.timeOutSeconds = 120;
            [request setShouldAttemptPersistentConnection:NO];
            [request startAsynchronous];
        }
        else { // Show alert for Data connectivity failure.
            [ALUtilityClass showAlertwithTitle:@"Network Connectivity Error!" message:@"Please check your network connection and try again."];
            if([_delegate respondsToSelector:@selector(serviceInvokerRequestFailed:)]) {
                [_delegate serviceInvokerRequestFailed:nil];
            }
        }
    }
    @catch (NSException *exception) {
        //nslog(@"exception catch : %@",exception.description);
    }
    @finally {
        
    }
}



@end
