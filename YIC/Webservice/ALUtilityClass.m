//
//  ALUtilityClass.m
//  SelfCare
//
//  Created by Agile on 7/25/13.
//  Copyright (c) 2013 Bharti Airtel. All rights reserved.
//

#import "ALUtilityClass.h"

#import <SystemConfiguration/SystemConfiguration.h>
#import "Reachability.h"

@implementation ALUtilityClass

static BOOL _isInternetConnected;
MBProgressHUD * HUD;

//Chceck Network connection method
+(BOOL)isNetworkAvailable
{
    Reachability *networkReachability = [Reachability reachabilityForInternetConnection];
    NetworkStatus networkStatus = [networkReachability currentReachabilityStatus];
    
    if (networkStatus == NotReachable)
    {
        return false;
        //nslog(@"There iS NO internet connection");
        
    } else {
        
        //nslog(@"There iS internet connection available");
        return true;
    }
    return false;
}

+(void)updateNetworkStatus:(BOOL)status
{
	_isInternetConnected = status;
}

+(BOOL)isNetworkConnected
{
	return _isInternetConnected;
}

+ (void)showSpinnerWithMessage:(NSString*)message onView:(UIView*)controllerView {
    
//    dispatch_async(dispatch_get_main_queue(), ^{
        
        HUD = [[MBProgressHUD alloc] initWithView:controllerView];
        HUD.labelText = message;
        HUD.detailsLabelText = @"Please wait...";
        HUD.mode = MBProgressHUDModeIndeterminate;
        HUD.removeFromSuperViewOnHide = YES;
        //    HUD.tag = 121;
        [controllerView addSubview:HUD];
        [HUD show:YES];
//    });
}


+ (void)removeHudFromView:(UIView*)controllerView afterDelay:(NSTimeInterval)delay {
    
//    dispatch_async(dispatch_get_main_queue(), ^{
        
//      MBProgressHUD*  HUD = (MBProgressHUD*)[controllerView viewWithTag:121];
        if(HUD !=nil)
        {
            [HUD hide:YES afterDelay:delay];
            HUD = nil;
        }
//    });
}

#pragma mark- Screen Size

+ (CGSize)currentScreenBoundsSize
{
    return [[UIScreen mainScreen] bounds].size;
}

+ (UIBarButtonItem *)createToolbarLabelWithTitle:(NSString *)aTitle
{
    UILabel *toolBarItemlabel = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, 10,20)];
    [toolBarItemlabel setTextAlignment:NSTextAlignmentCenter];
    [toolBarItemlabel setTextColor:[UIColor whiteColor]];
    [toolBarItemlabel setFont:[UIFont boldSystemFontOfSize:16]];
    [toolBarItemlabel setBackgroundColor:[UIColor clearColor]];
    toolBarItemlabel.text = aTitle;
    UIBarButtonItem *buttonLabel = [[UIBarButtonItem alloc]initWithCustomView:toolBarItemlabel];
    return buttonLabel;
}

+(UILabel *)setLabelUnderline:(UILabel *)label
{
    CGSize expectedLabelSize = [label.text sizeWithFont:label.font constrainedToSize:label.frame.size lineBreakMode:label.lineBreakMode];
    UIView *viewUnderline=[[UIView alloc] init];
    CGFloat xOrigin=0;
    switch (label.textAlignment) {
        case NSTextAlignmentCenter:
            xOrigin=(label.frame.size.width - expectedLabelSize.width)/2;
            break;
        case NSTextAlignmentLeft:
            xOrigin=0;
            break;
        case NSTextAlignmentRight:
            xOrigin=label.frame.size.width - expectedLabelSize.width;
            break;
        default:
            break;
    }
    viewUnderline.frame=CGRectMake(xOrigin,
                                   expectedLabelSize.height+11,
                                   expectedLabelSize.width,
                                   1);
    if (viewUnderline.frame.size.width == 0) {
        CGRect frm = viewUnderline.frame;
        frm.size.width = 54;
        viewUnderline.frame = frm;
    }
    viewUnderline.backgroundColor=[UIColor blackColor];
    [label addSubview:viewUnderline];
    return label;
}

+(UILabel *)setLabelFont:(UILabel *)label size:(CGFloat)size_t
{
    [label setFont:  [UIFont fontWithName:@"ronniabasic" size:size_t]];
    return label;
}

#pragma mark- Alert Display Generic Method

+(void)showAlertwithTitle:(NSString*)Title message:(NSString*)Message
{
    UIAlertView *message = [[UIAlertView alloc] initWithTitle:Title
                                                      message:Message
                                                     delegate:nil
                                            cancelButtonTitle:@"OK"
                                            otherButtonTitles:nil];
    [message show];
}

+(void)showAlertwithTitle:(NSString*)Title message:(NSString*)Message tag:(NSInteger)alertTag delgate:(id)delegate
{
    UIAlertView *message = [[UIAlertView alloc] initWithTitle:Title
                                                      message:Message
                                                     delegate:delegate
                                            cancelButtonTitle:@"OK"
                                            otherButtonTitles:nil];
    message.tag = alertTag;
    [message show];
}


/* sha256 Encription */

#pragma mark sha256 Encription

//static NSUInteger counter = 1;

+ (NSString*)getDeviceIdentifier {
    NSUUID *id = [[UIDevice currentDevice] identifierForVendor];
    NSString* deviceId = [NSString stringWithFormat:@"%@",[id UUIDString]];
    
    NSCharacterSet *charactersToRemove = [[NSCharacterSet alphanumericCharacterSet] invertedSet];
    NSString *deviceIdAlphanumeric = [[deviceId componentsSeparatedByCharactersInSet:charactersToRemove] componentsJoinedByString:@""];
    
//    //nslog(@"DeviceIdentifier : %@",deviceIdAlphanumeric);
    
    return deviceIdAlphanumeric;
}



+(void)SaveDatatoUserDefault:(NSDictionary*)Data :(NSString*)key
{
    NSUserDefaults *prefs = [NSUserDefaults standardUserDefaults];
//    //nslog(@"%@",Data);
    NSData *dataInArchiveFormat = [NSKeyedArchiver archivedDataWithRootObject:Data];
    [prefs setObject:dataInArchiveFormat forKey:key];
    [prefs synchronize];
//    //nslog(@"%@",[prefs dictionaryForKey:key]);
}


+(id)RetrieveDataFromUserDefault:(NSString*)key
{
    NSUserDefaults *prefs = [NSUserDefaults standardUserDefaults];
//    id data = [prefs dictionaryForKey:key];
    id data = [prefs objectForKey:key];
    id data1 = [NSKeyedUnarchiver unarchiveObjectWithData:data];
    //nslog(@"%@",data1);
    return data1;
}

+(NSString*)getSalt
{
    NSUserDefaults *prefs = [NSUserDefaults standardUserDefaults];
    
    id data = [NSKeyedUnarchiver unarchiveObjectWithData:[prefs objectForKey:@"userVO"]];
    NSString *salt = [data objectForKey:@"salt"];
    return salt;
}

+(NSString*)getCurrentTimeStamp
{
   NSTimeInterval time = ([[NSDate date] timeIntervalSince1970]); // returned as a double
    long digits = (long)time; // this is the first 10 digits

//    //nslog(@"double time : %f",time);
    int decimalDigits = (int)(fmod(time, 1) * 1000); // this will get the 3 missing digits
     double timestamp = ((double)digits *1000) + decimalDigits;
    NSString *timestampString = [NSString stringWithFormat:@"%lld",(long long)timestamp];
    
    return timestampString;
    
//    NSString *timestampString = [NSString stringWithFormat:@"%ld%d",digits ,decimalDigits];
    //nslog(@"CurrentTimeStamp = %@",timestampString);
    
    return timestampString;
}

+(void)logout
{
    //nslog(@"log out");
//    AppDelegate *appDelegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
   // [appDelegate logOutAction];
    
}

+(void)loadHomePage:(UIViewController*)viewController
{
//    HomePageViewController* homePageController = [[HomePageViewController alloc]initWithNibName:@"HomePageViewController" bundle:nil];
//    [viewController.navigationController pushViewController:homePageController animated:YES];
}
+(void)loadSelectAccountPage:(UIViewController*)viewController
{
//    SelectAccountController* selectCtrl;
//    @synchronized(selectCtrl) {
//		if(selectCtrl == nil) {
//			selectCtrl = [[SelectAccountController alloc]initWithNibName:@"SelectAccountController" bundle:nil];
//		}
//	}
//    [viewController.navigationController pushViewController:selectCtrl animated:YES];
    
  
   /*
    SRSummaryViewController* summaryControl;
        @synchronized(summaryControl) {
    		if(summaryControl == nil) {
    			summaryControl = [[SRSummaryViewController alloc]initWithNibName:UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad ?
                                  @"SRSummaryViewController~iPad": @"SRSummaryViewController"  bundle:nil];
    		}
    	}
        [viewController.navigationController pushViewController:summaryControl animated:YES];
    */
}


+(NSString*)getDocumentDirectoryPath
{
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documentsDirectory = [paths objectAtIndex:0];
    //    documentsDirectory = [documentsDirectory stringByAppendingString:jsonDirectoryPathFactSheet];
    
    return documentsDirectory;
}

+(NSString*)getDocumentDirectoryPath:(NSString*)path
{
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documentsDirectory = [paths objectAtIndex:0];
    documentsDirectory = [documentsDirectory stringByAppendingString:path];
    
    return documentsDirectory;
}


+(void)CopyOrreplaceDirectoryAtDocumentFolder:(NSString*)directory
{
    NSFileManager *fileManager = [NSFileManager defaultManager];
    NSError *error;
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documentsDirectory = [paths objectAtIndex:0];
    NSString *documentDBFolderPath = [documentsDirectory stringByAppendingPathComponent:directory];
    NSString *resourceDBFolderPath = [[[NSBundle mainBundle] resourcePath] stringByAppendingPathComponent:directory];
    
    if (![fileManager fileExistsAtPath:documentDBFolderPath]) {
        //Create Directory!
        [fileManager createDirectoryAtPath:documentDBFolderPath withIntermediateDirectories:NO attributes:nil error:&error];
    } else {
        //nslog(@"Directory exists! %@", documentDBFolderPath);
    }
    NSArray *fileList = [fileManager contentsOfDirectoryAtPath:resourceDBFolderPath error:&error];
    for (NSString *s in fileList) {
        NSString *newFilePath = [documentDBFolderPath stringByAppendingPathComponent:s];
        NSString *oldFilePath = [resourceDBFolderPath stringByAppendingPathComponent:s];
        if (![fileManager fileExistsAtPath:newFilePath]) {
            //File does not exist, copy it
            [fileManager copyItemAtPath:oldFilePath toPath:newFilePath error:&error];
        } else {
            //nslog(@"File exists: %@", newFilePath);
        }
    }
}


@end
