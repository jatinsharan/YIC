//
//  NotificationViewController.h
//  YIC
//
//  Created by Jatin on 10/5/15.
//
//

#import <UIKit/UIKit.h>

@interface NotificationViewController : UIViewController <UITableViewDelegate, UITableViewDataSource> {
    NSArray *arrayNotifications;
    IBOutlet UITableView *tblNotification;
}

@end
