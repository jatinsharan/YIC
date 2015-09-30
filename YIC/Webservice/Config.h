
/*
 *  System Versioning Preprocessor Macros
 */

#define SYSTEM_VERSION_EQUAL_TO(v)                  ([[[UIDevice currentDevice] systemVersion] compare:v options:NSNumericSearch] == NSOrderedSame)
#define SYSTEM_VERSION_GREATER_THAN(v)              ([[[UIDevice currentDevice] systemVersion] compare:v options:NSNumericSearch] == NSOrderedDescending)
#define SYSTEM_VERSION_GREATER_THAN_OR_EQUAL_TO(v)  ([[[UIDevice currentDevice] systemVersion] compare:v options:NSNumericSearch] != NSOrderedAscending)
#define SYSTEM_VERSION_LESS_THAN(v)                 ([[[UIDevice currentDevice] systemVersion] compare:v options:NSNumericSearch] == NSOrderedAscending)
#define SYSTEM_VERSION_LESS_THAN_OR_EQUAL_TO(v)     ([[[UIDevice currentDevice] systemVersion] compare:v options:NSNumericSearch] != NSOrderedDescending)

//************************************END********************************************



#define KALERT(TITLE,MSG,DELEGATE) [[UIAlertView alloc]initWithTitle:TITLE message:MSG delegate:DELEGATE cancelButtonTitle:@"OK" otherButtonTitles:nil, nil]

#define KALERT_YN(TITLE,MSG,DELEGATE) [[UIAlertView alloc]initWithTitle:TITLE message:MSG delegate:DELEGATE cancelButtonTitle:@"Ok" otherButtonTitles:@"YES", nil]

//#define AppDelegate (AppDelegate*)[UIApplication sharedApplication].delegate

//#define APP_ManageObject ((AppDelegate*)iTicket_AppDelegate).managedObjectContext

#define whiteCharacterSet [NSCharacterSet whitespaceAndNewlineCharacterSet]


#define KApplicationName @"CL-YIC"


#define BASE_URL_STRING @"http://52.74.7.59:8081/YICServer/rest/service/"



#define IS_IPhone (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPhone)




#define kAPNS_WEBSERVICE @"registerPushNotificationId"
#define KgetColleges @"getColleges"

#define kregisterUser @"registerUser"
#define kgetUserNotices @"getUserNotices"


