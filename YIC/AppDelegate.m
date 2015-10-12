//
//  AppDelegate.m
//  YIC
//
//  Created by Jatin on 9/30/15.
//
//

#import "AppDelegate.h"

#import "Config.h"
#import "DBManagerYIC.h"
#import "ALUtilityClass.h"

#import "HomeViewController.h"
#import "StartUpViewController.h"
#import "NotificationViewController.h"

#import "GlobalDataPersistence.h"

@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    
    // delay of 3 second in splash
    [NSThread sleepForTimeInterval:3.0];
    
    DBManagerYIC *dbM = [DBManagerYIC new];
    [dbM copyDatabaseIfNeeded];
    
    
    if([[KUSER_DEFAULT valueForKey:KIS_LOGIN] isEqualToString:@"1"])
    {
        HomeViewController *vc = [[HomeViewController alloc] initWithNibName:@"HomeViewController" bundle:nil];
       
        self.navigation = [[UINavigationController alloc]initWithRootViewController:vc];
        [self.navigation setNavigationBarHidden:YES];
    }
    else
    {
        StartUpViewController *vc = [[StartUpViewController alloc] initWithNibName:@"StartUpViewController" bundle:nil];
        
        self.navigation = [[UINavigationController alloc]initWithRootViewController:vc];
        [self.navigation setNavigationBarHidden:YES];

    }
    
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    [self.window setRootViewController:self.navigation];
    [self.window makeKeyAndVisible];
    
    //***********|| APNS ||*************//
    if (SYSTEM_VERSION_LESS_THAN(@"8.0")) {
        // iOS 7 & below
        [[UIApplication sharedApplication] registerForRemoteNotificationTypes:
         (UIRemoteNotificationTypeBadge | UIRemoteNotificationTypeSound | UIRemoteNotificationTypeAlert)];
    }
    else {
        //#ifdef __IPHONE_8_0
        // iOS 8 & above
        UIUserNotificationType types = UIUserNotificationTypeAlert | UIUserNotificationTypeBadge | UIUserNotificationTypeSound;
        
        UIUserNotificationSettings *deviceNotifiSettings = [UIUserNotificationSettings settingsForTypes:types categories:nil];
        
        [[UIApplication sharedApplication] registerUserNotificationSettings:deviceNotifiSettings];
        //#endif
    }

    // Override point for customization after application launch.
    return YES;
}

#pragma mark- Push notification registration methods
#pragma mark-

#ifdef __IPHONE_8_0

- (void)application:(UIApplication *)application didRegisterUserNotificationSettings:(UIUserNotificationSettings *)notificationSettings
{
    //register to receive notifications
    [application registerForRemoteNotifications];
}

- (void)application:(UIApplication *)application handleActionWithIdentifier:(NSString *)identifier forRemoteNotification:(NSDictionary *)userInfo completionHandler:(void(^)())completionHandler
{
    //handle the actions
    if ([identifier isEqualToString:@"declineAction"]) {
        //DDLogDebug(@"notification reception Declined");
    }
    else if ([identifier isEqualToString:@"answerAction"]) {
        //DDLogDebug(@"notification reception Accepted");
    }
}

#endif

- (void)application:(UIApplication*)application didRegisterForRemoteNotificationsWithDeviceToken:(NSData*)deviceToken
{
    NSString* newToken = [deviceToken description];
    newToken = [newToken stringByTrimmingCharactersInSet:[NSCharacterSet characterSetWithCharactersInString:@"<>"]];
    newToken = [newToken stringByReplacingOccurrencesOfString:@" " withString:@""];
    
    NSLog(@"My token is: %@", newToken);
    
    [ALUtilityClass SaveDatatoUserDefault:newToken :@"deviceToken"];
}

- (void)application:(UIApplication*)application didFailToRegisterForRemoteNotificationsWithError:(NSError*)error
{
    NSLog(@"Failed to get token, error: %@", error.description);
    //    [SharedUtility saveDatatoUserDefault:@"" :@"deviceToken"];
}

- (void)application:(UIApplication *)application didReceiveRemoteNotification:(NSDictionary *)userInfo
{
    if([[KUSER_DEFAULT valueForKey:KIS_LOGIN] isEqualToString:@"1"]) {
        
        // After user login, send device token details for APNS
        if (application.applicationState == UIApplicationStateInactive ||
            application.applicationState == UIApplicationStateBackground)
        {
            // go to screen relevant to Notification content
            
            UINavigationController *navController = (UINavigationController *)self.window.rootViewController;
            [navController popToRootViewControllerAnimated:YES];
            
            NotificationViewController *vc = [[NotificationViewController alloc] initWithNibName:@"NotificationViewController" bundle:nil];
            [navController pushViewController:vc animated:YES];
            
        }
        else {
            // App is in UIApplicationStateActive (running in foreground)
            
        }
    }
    
}

- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

@end
