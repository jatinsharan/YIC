//
//  AppDelegate.h
//  YIC
//
//  Created by Jatin on 9/30/15.
//
//

#import <UIKit/UIKit.h>
#import "StartUpViewController.h"
#import "HomeViewController.h"
@interface AppDelegate : UIResponder <UIApplicationDelegate>

@property (strong, nonatomic) UIWindow *window;
@property (strong, nonatomic) UINavigationController *navigation;
@property (strong, nonatomic) StartUpViewController *viewController;
@property (strong, nonatomic) HomeViewController *SecviewController;

@end

