 


#import "WebCommunicationClass.h"
#import "ASIHTTPRequest.h"
#import "ASIFormDataRequest.h"
#import "SVProgressHUD.h"
#import "Config.h"
#import "AppDelegate.h"
@implementation WebCommunicationClass

@synthesize aCaller,MethoodName;

- (id)init {
    self = [super init];
    if (self)
	{
		AnAppDelegatObj=(AppDelegate *)[[UIApplication sharedApplication] delegate];
		
    }
    return self;
}
- (void)dealloc
{
//    NSLog(@"%s",__PRETTY_FUNCTION__);
    [aCaller release];
    aCaller = nil;
    [super dealloc];
}

#pragma mark -
#pragma mark - User Defined Methods

-(void)GetRegestater:(NSString*)name  mobile:(NSString*)mobile email:(NSString*)email city:(NSString*)city localAddress:(NSString*)localAddress collegeName:(NSString*)collegeName course:(NSString*)course semester:(NSString*)semester
{    

    [SVProgressHUD showWithStatus:@"Please wait..."];
    NSMutableDictionary *aUserInfo= [NSMutableDictionary dictionary];
    [aUserInfo setValue:name forKey:@"name"];
    [aUserInfo setValue:mobile forKey:@"mobile"];
    [aUserInfo setValue:email forKey:@"email"];

    [aUserInfo setValue:city forKey:@"city"];
    [aUserInfo setValue:localAddress forKey:@"localAddress"];
    [aUserInfo setValue:collegeName forKey:@"collegeName"];

    [aUserInfo setValue:course forKey:@"course"];
    [aUserInfo setValue:semester forKey:@"semester"];
    
    
    //    [self ASICallSyncToServerWithFunctionName:Login_MethodName PostDataDictonery:aUserInfo];
    [self retain];
    
    [[ALServiceInvoker sharedInstance] serviceInvokerRequestWithParams:aUserInfo requestAPI:kregisterUser reqTag:1 delegate:self];
}

-(void)GetCollage:(NSString *)cityId
{
    [SVProgressHUD showWithStatus:@"Please wait..."];
    NSMutableDictionary *aUserInfo= [NSMutableDictionary dictionary];
    [aUserInfo setValue:cityId forKey:@"cityId"];
    [self retain];

    
     [[ALServiceInvoker sharedInstance] serviceInvokerRequestWithParams:aUserInfo requestAPI:KgetColleges reqTag:2 delegate:self];

}


-(void)getUserNotices:(NSString *)userId

{
    [SVProgressHUD showWithStatus:@"Please wait..."];
    NSMutableDictionary *aUserInfo= [NSMutableDictionary dictionary];
    [aUserInfo setValue:userId forKey:@"userId"];
    
    [self retain];
    
    
    [[ALServiceInvoker sharedInstance] serviceInvokerRequestWithParams:aUserInfo requestAPI:kgetUserNotices reqTag:3 delegate:self];

}

-(void)GetOtp:(NSString*)userId otp:(NSString*)otp
{
    [SVProgressHUD showWithStatus:@"Please wait..."];
    NSMutableDictionary *aUserInfo= [NSMutableDictionary dictionary];
    [aUserInfo setValue:userId forKey:@"userId"];
    [aUserInfo setValue:otp forKey:@"otp"];
    
    
    [self retain];
    
    
    [[ALServiceInvoker sharedInstance] serviceInvokerRequestWithParams:aUserInfo requestAPI:kOtp reqTag:4 delegate:self];
    
}

-(void)GetSaveUserdetail:(NSString*)userId
                testDate:(NSString*)testDate
                passcode:(NSString*)passcode
               timeTaken:(NSString*)timeTaken
                   marks:(NSString*)marks
{
    
    [SVProgressHUD showWithStatus:@"Please wait..."];
    
    NSMutableDictionary *aUserInfo= [NSMutableDictionary dictionary];
    
    [aUserInfo setValue:userId forKey:@"userId"];
    [aUserInfo setValue:testDate forKey:@"testDate"];
    [aUserInfo setValue:passcode forKey:@"passcode"];
    
    [aUserInfo setValue:timeTaken forKey:@"timeTaken"];
    [aUserInfo setValue:marks forKey:@"marks"];
    
    // [self ASICallSyncToServerWithFunctionName:Login_MethodName PostDataDictonery:aUserInfo];
    [self retain];
    
    [[ALServiceInvoker sharedInstance] serviceInvokerRequestWithParams:aUserInfo requestAPI:ksaveUserTest reqTag:5 delegate:self];
}

-(void)Getcity
{
    [SVProgressHUD showWithStatus:@"Please wait..."];
    NSMutableDictionary *aUserInfo= [NSMutableDictionary dictionary];
    [self retain];
    
    [[ALServiceInvoker sharedInstance] serviceInvokerRequestWithParams:aUserInfo requestAPI:KgetCities reqTag:6 delegate:self];
}

/*
-(void)checkCompanyExist:(NSString*)companyName
{
    [SVProgressHUD showWithStatus:@"Please wait..."];
    //    NSString *url = [ServerAdd stringByAppendingFormat:@"%@?email=%@&password=%@",Login_MethodName,username,password];
    //    [self ASICallSyncToServerWithUrl:url FunctionName:Login_MethodName];
    NSMutableDictionary *aUserInfo= [NSMutableDictionary dictionary];
    
    [aUserInfo setValue:companyName forKey:@"companyName"];
	[aUserInfo setValue:companyName_MethodName forKey:@"action"];
    
    NSLog(@"to=%@",aUserInfo);
    //NSString *json=[[NSString alloc]initWithString:[aTodayEvent JSONFragment]];
	//NSLog( @"%@",json);=admin&=123456
    [self ASICallSyncToServerWithFunctionName:companyName_MethodName PostDataDictonery:aUserInfo];
}
-(void)registerUser:(NSMutableDictionary *)userData
{
    [SVProgressHUD showWithStatus:@"Loading..."];
    [self ASICallSyncToServerWithFunctionName:SignUp_MethodName PostDataDictonery:userData];
}

-(void)updateUserProfile:(NSMutableDictionary *)userData
{
    [SVProgressHUD showWithStatus:@"Loading..."];
    [self ASICallSyncToServerWithFunctionName:UpdateUser PostDataDictonery:userData];
}

-(void)updateCompanyDetails:(NSMutableDictionary *)dictCompnayDetails
{
    [SVProgressHUD showWithStatus:@"Loading..."];
    [self ASICallSyncToServerWithFunctionName:UpdateUser PostDataDictonery:dictCompnayDetails];
}

-(void)fetchAllUsers:(NSMutableDictionary *)dictCompany
{
    [SVProgressHUD showWithStatus:@"Loading..."];
    [self ASICallSyncToServerWithFunctionName:FetchAllUers PostDataDictonery:dictCompany];
}

-(void)changeUserStatus:(NSMutableDictionary *)dictUser
{
    [self ASICallSyncToServerWithFunctionName:kChangeUserStatus PostDataDictonery:dictUser];
}

-(void)deleteUser: (NSMutableDictionary *) dictUser
{
    [self ASICallSyncToServerWithFunctionName:kDeleteUser PostDataDictonery:dictUser];
}

-(void)editUserInUserPanel:(NSMutableDictionary *) dictUser
{
    [SVProgressHUD showWithStatus:@"Loading..."];
    [self ASICallSyncToServerWithFunctionName:kEditUserInUserPanel PostDataDictonery:dictUser];
}

-(void)addImporter:(NSMutableDictionary *) dictImporter
{
    [self ASICallSyncToServerWithFunctionName:kAddImporter PostDataDictonery:dictImporter];
}

-(void)addExporter:(NSMutableDictionary *) dictExporter
{
    [self ASICallSyncToServerWithFunctionName:kAddExporter PostDataDictonery:dictExporter];
}


-(void)fetchExporters:(NSMutableDictionary *)dict
{
    [self ASICallSyncToServerWithFunctionName:kListExporter PostDataDictonery:dict];
}

-(void)fetchImporters:(NSMutableDictionary *)dict
{
    [self ASICallSyncToServerWithFunctionName:kListImporter PostDataDictonery:dict];
}

-(void)addSample:(NSMutableDictionary *)dict
{
    [SVProgressHUD showWithStatus:@"Loading..."];
    [self ASICallSyncToServerWithFunctionName:kAddSample PostDataDictonery:dict];
}
-(void)addDulicateSample:(NSMutableDictionary *)dict
{
    [SVProgressHUD showWithStatus:@"Loading..."];
    [self ASICallSyncToServerWithFunctionName:kAddDuplicateSample PostDataDictonery:dict];
}
-(void)setSampleReportStatus:(NSMutableDictionary *)dict
{
    [SVProgressHUD showWithStatus:@"Loading..."];
    [self ASICallSyncToServerWithFunctionName:kSetSampleReportStatus PostDataDictonery:dict];
}
-(void)updateLocation:(NSMutableDictionary *)dict
{
    [self ASICallSyncToServerWithFunctionName:kUpdateUserLocation PostDataDictonery:dict];
}

-(void)fetchAllSample:(NSMutableDictionary *)dict
{
    [SVProgressHUD showWithStatus:@"Loading..."];
    [self ASICallSyncToServerWithFunctionName:kListSample PostDataDictonery:dict];
}
-(void)getNearestUserList:(NSString *)userId
{
    [SVProgressHUD showWithStatus:@"Loading..."];
    NSMutableDictionary *dict= [NSMutableDictionary dictionary];
    
    [dict setValue:userId forKey:@"userId"];
    [self ASICallSyncToServerWithFunctionName:kGetNearestUserList PostDataDictonery:dict];
}
-(void)allowGuestUser:(NSMutableDictionary *)dict
{
    [SVProgressHUD showWithStatus:@"Loading..."];
    [self ASICallSyncToServerWithFunctionName:kAllowGuestUser PostDataDictonery:dict];
}
-(void)addCupping:(NSMutableDictionary *)dict
{
    [SVProgressHUD showWithStatus:@"Loading..."];
    [self ASICallSyncToServerWithFunctionName:kAddCupping PostDataDictonery:dict];
}
*/





//-(void)resetCouping:(NSMutableDictionary *)dict
//{
//    [SVProgressHUD showWithStatus:@"Loading..."];
//    [self ASICallSyncToServerWithFunctionName:kResetCouping PostDataDictonery:dict];
//}
//-(void)getOpenSampleData:(NSMutableDictionary *)dict
//{
//    [SVProgressHUD showWithStatus:@"Loading..."];
//    [self ASICallSyncToServerWithFunctionName:kGetOpenSampleData PostDataDictonery:dict];
//}



#pragma mark - Class Methods


+ (NSString *)urlEncodeValue:(NSString *)str
{
	NSString *result = (NSString *) CFURLCreateStringByAddingPercentEscapes(kCFAllocatorDefault, (CFStringRef)str, NULL, CFSTR("?=&+"), kCFStringEncodingUTF8);
	return [result autorelease];
}
+ (NSString *)urlDecodeValue:(NSString *)str
{
	//NSString *result = (NSString *) CFURLCreateStringByReplacingPercentEscapes(kCFAllocatorDefault, (CFStringRef)str, NULL, CFSTR("?=&+"), kCFStringEncodingUTF8);
	NSString *result = (NSString *) CFURLCreateStringByReplacingPercentEscapesUsingEncoding(kCFAllocatorDefault, (CFStringRef)str,  CFSTR("?=&+"), kCFStringEncodingUTF8);
	return [result autorelease];
}

//-(void)uploadImage:(NSString*)imageUrl
//{
//    
//    [UIApplication sharedApplication].networkActivityIndicatorVisible = YES;
//    NSString *Afunction=[[NSString alloc]initWithString:Image_MethodName];
//	MethoodName=Afunction;
//    
//	NSString *urlString = @"http://carpark-management.co.uk/mobile-app/users/imageUploadWithPcn";
////    NSString *urlString = @"http://122.160.205.84/iticket/users/imageUploadWithPcn";
//    
//	NSURL *aUrl=[[NSURL alloc]initWithString:urlString];
//	ASIFormDataRequest *request = [[[ASIFormDataRequest alloc] initWithURL:aUrl] autorelease];
//    request.shouldAttemptPersistentConnection = NO;
////    [request setPostValue:GDP.kUserID forKey:@"UserID"];
////    [request setPostValue:GDP.PCN forKey:@"PCN"];
//    
//	[request setDidFailSelector:@selector(dataDownloadFail:)];
//
//    [request setDidFinishSelector:@selector(dataDidFinishDowloading:)];
//    [request setDelegate:self];
//    [request setFile:imageUrl forKey:@"img"];
//    [request setPersistentConnectionTimeoutSeconds:1800.0];
//    [request startAsynchronous];
//
//    [Afunction release];
//    [aUrl release];
//}
/*-(void)ASICallSyncToServerWithUrl:(NSString *)urlString FunctionName:(NSString*)FunctionName
{	
    if ([AppDelegate checkNetwork])
    {
        [self retain];
        {
            [UIApplication sharedApplication].networkActivityIndicatorVisible = YES;

            MethoodName=FunctionName;
            NSURL *aUrl=[[[NSURL alloc]initWithString:urlString]autorelease];
            
            ASIFormDataRequest *anASIReq = [ASIFormDataRequest requestWithURL:aUrl];
            anASIReq.delegate = self;
            anASIReq.didFailSelector = @selector(dataDownloadFail:);
            anASIReq.didFinishSelector = @selector(dataDidFinishDowloading:);
            anASIReq.requestMethod = @"POST";
            [anASIReq startAsynchronous];
        }
        
    }
    else
    {
        [SVProgressHUD dismiss];
    }
}*/

-(void)ASICallSyncToServerWithFunctionName:(NSString *)FunctionName getDataDictonery :(NSMutableDictionary *)Dictionery
{
    
    
    [self retain];
    NSString *JsonString=nil;
    NSError *error;
    NSData *jsonData = [NSJSONSerialization dataWithJSONObject:Dictionery
                                                       options:NSJSONWritingPrettyPrinted
                                                         error:&error];
    
    if (! jsonData) {
        NSLog(@"Got an error: %@", error);
    } else {
        JsonString = [[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];
        [UIApplication sharedApplication].networkActivityIndicatorVisible = YES;
        
        NSLog(@"FunctionName-->> %@",FunctionName);
        NSLog(@"requestjson-->> %@",JsonString);
        
        MethoodName=FunctionName;
        NSString *urlString = [NSString stringWithFormat:@"%@",BASE_URL_STRING];
        NSLog(@"ServerAdd-->> %@",BASE_URL_STRING);
        NSURL *aUrl=[[[NSURL alloc]initWithString:urlString]autorelease];
        
        ASIFormDataRequest *anASIReq = [ASIFormDataRequest requestWithURL:aUrl];
        
//        anASIReq.methodName=FunctionName;

        
               NSLog(@"Json Data %@",JsonString);
        
        if([[Dictionery allKeys]containsObject:@"file"])
        {
            NSString *imagePath = [Dictionery objectForKey:@"file"];
            
            NSLog(@"%@",[Dictionery objectForKey:@"file"]);
            if ([imagePath stringByTrimmingCharactersInSet:whiteCharacterSet].length)
            {
                NSString *fileNAme = [NSString stringWithFormat:@"%@",[[imagePath componentsSeparatedByString:@"/"] lastObject]];
                
                
                [anASIReq setFile:[NSData dataWithContentsOfFile:imagePath] withFileName:fileNAme andContentType:@"Image/" forKey:[NSString stringWithFormat:@"file"]];
                
                
                
                
                
                NSLog(@"%@",imagePath);
                
                //  [anASIReq setFile:imagePath forKey:@"image1"];
            }
        }
        
        [anASIReq setPostValue:FunctionName forKey:@"action"];
        [anASIReq setPostValue:JsonString forKey:@"jsAxon"];
        
        anASIReq.delegate = self;
        anASIReq.didFailSelector = @selector(dataDownloadFail:);
        anASIReq.didFinishSelector = @selector(dataDidFinishDowloading:);
        anASIReq.requestMethod = @"POST";
        
        [JsonString release];
        [anASIReq startAsynchronous];
    }
    
    
}
-(void)ASICallSyncToServerWithFunctionName:(NSString *)FunctionName PostDataDictonery :(NSMutableDictionary *)postParams
{
    
//if ([AppDelegate checkNetwork])
       // {
            [self retain];
//            NSString *JsonString=nil;
//            NSError *error;
//            NSData *jsonData = [NSJSONSerialization dataWithJSONObject:Dictionery
//            options:NSJSONWritingPrettyPrinted
//            error:&error];
    
//            if (! jsonData) {
//                NSLog(@"Got an error: %@", error);
//                } else {
//                 JsonString = [[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];
                 [UIApplication sharedApplication].networkActivityIndicatorVisible = YES;
                    
                 NSLog(@"FunctionName-->> %@",FunctionName);
//                 NSLog(@"requestjson-->> %@",JsonString);
                    
                 MethoodName=FunctionName;
                 NSString *urlString = [NSString stringWithFormat:@"%@%@",BASE_URL_STRING,FunctionName];
                 NSLog(@"ServerAdd-->> %@",BASE_URL_STRING);
                 NSURL *aUrl=[[[NSURL alloc]initWithString:urlString]autorelease];
                    
                 ASIFormDataRequest *anASIReq = [ASIFormDataRequest requestWithURL:aUrl];
                    
//                 anASIReq.methodName=FunctionName;
                    
                    
                    
                    
//                    NSLog(@"Json Data %@",JsonString);
                    
                    [anASIReq setPostValue:FunctionName forKey:@"action"];
//                    [anASIReq setPostValue:JsonString forKey:([FunctionName isEqualToString:Reg_MethodName]?@"User":@"json")];
    
    if (postParams != nil) {
        for (NSString *key in [postParams allKeys]) {
            [anASIReq setPostValue:[postParams objectForKey:key] forKey:key];
        }
    }

    
                    anASIReq.delegate = self;
                    anASIReq.didFailSelector = @selector(dataDownloadFail:);
                    anASIReq.didFinishSelector = @selector(dataDidFinishDowloading:);
                    anASIReq.requestMethod = @"POST";
                    
//                    [JsonString release];
                    [anASIReq startAsynchronous];
//                    }
            
//}
   // else
      //  {
       //     [SVProgressHUD dismiss];
//zs}
}




-(void)ASICallSyncToServerWithFunctionName:(NSString *)FunctionName
{/*
    if ([AppDelegate checkNetwork])
    {
        NSString *urlString = [NSString stringWithFormat:@"%@",ServerAdd1];
        NSLog(@"ServerAdd-->> %@",ServerAdd1);
        NSURL *aUrl=[[[NSURL alloc]initWithString:urlString]autorelease];

        ASIFormDataRequest *anASIReq = [ASIFormDataRequest requestWithURL:aUrl];
        
       
        anASIReq.delegate = self;
        anASIReq.didFailSelector = @selector(dataDownloadFail:);
        anASIReq.didFinishSelector = @selector(dataDidFinishDowloading:);
        anASIReq.requestMethod = @"GET";
        
        
        [anASIReq startAsynchronous];

        
    }*/
}



#pragma mark- ALServiceInvoker Delegate
#pragma mark-

- (void)serviceInvokerRequestFailed:(ASIFormDataRequest *)request
{
    // ****** Hide activity Indicator ******** //
    
    [SVProgressHUD dismiss];
    NSLog(@"DATA DOWNLOAD Error--%@",request.error);
    [UIApplication sharedApplication].networkActivityIndicatorVisible = NO;
    
    if([aCaller respondsToSelector:@selector(dataDownloadFail:withMethood:)])
    {
        [aCaller dataDownloadFail:request withMethood:request.url.path];
        NSLog(@"DATA DOWNLOAD Error--%@",request.error);
//        UIAlertView *alert=[[UIAlertView alloc]initWithTitle:@"Jackpot Vacantion" message:[NSString stringWithFormat:@"%@",request.error] delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
//        alert.delegate=self;
//        [alert show];
    }

}

- (void)serviceInvokerRequestFinished:(ASIFormDataRequest *)request
{
    // ****** Hide activity Indicator ******** //
    [UIApplication sharedApplication].networkActivityIndicatorVisible = NO;
    [SVProgressHUD dismiss];
    
//    NSError *error = nil;
//    NSDictionary *responseDict = [NSJSONSerialization JSONObjectWithData:request.responseData options:NSJSONReadingMutableLeaves error:&error];
    
    
    NSString *string=[[NSString alloc]initWithData:[request responseData] encoding:NSUTF8StringEncoding];
    
    NSLog(@"%@",string);
    
    [self.aCaller dataDidFinishDowloading:request withMethood:MethoodName withOBJ:self];
    
    //    if([aReq.methodName isEqualToString:Login_MethodName])
    //    {
    //
    //            [self.aCaller dataDidFinishDowloading:aReq withMethood:MethoodName withOBJ:self];
    //    }
    //   else if([aReq.methodName isEqualToString:Reg_MethodName])
    //    {
    //
    //
    //    }
    
    [aCaller release];
    aCaller = nil;
    
}

/*
#pragma mark - Response Methods
-(void) dataDidFinishDowloading:(ASIHTTPRequest*)aReq
{
    
    NSLog(@"Successful");
    
//    [self navigateWithData:aReq];
    

}
-(void) dataDownloadFail:(ASIHTTPRequest*)aReq
{
    [SVProgressHUD dismiss];
     NSLog(@"DATA DOWNLOAD Error--%@",aReq.error);
	[UIApplication sharedApplication].networkActivityIndicatorVisible = NO;
    if([aCaller respondsToSelector:@selector(dataDownloadFail:withMethood:)])
    {
        [aCaller dataDownloadFail:aReq withMethood:aReq.url.path];
        NSLog(@"DATA DOWNLOAD Error--%@",aReq.error);
        UIAlertView *alert=[[UIAlertView alloc]initWithTitle:@"Jackpot Vacantion" message:[NSString stringWithFormat:@"%@",aReq.error] delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
        alert.delegate=self;
        [alert show];
    }
}

#pragma mark - Navigation methods
- (void)navigateWithData:(ASIHTTPRequest*)aReq
{
    
    
}
*/
-(void)removeWebComm:(WebCommunicationClass*)webComm
{
    @try {
        if (webComm) {
            
            [webComm setACaller:nil];
            [webComm release];
            webComm = nil;
            
        }
    }
    @catch (NSException *exception) {
        NSLog(@"Exception : %@ %s",exception.description,__PRETTY_FUNCTION__);
    }
    @finally {
        
    }
    
}

@end
