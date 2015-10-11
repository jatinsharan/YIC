//
//  CalendarCell.h
//  SchoolZen
//
//  Created by Jatin on 7/21/15.
//  Copyright (c) 2015 Jatin. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CalendarCell : UITableViewCell

@property(nonatomic,weak)IBOutlet UILabel *lblMainHeading;
@property(nonatomic,weak)IBOutlet UILabel *lblSubHeading;
@property(nonatomic,weak)IBOutlet UILabel *lbldate;
@property(nonatomic,weak)IBOutlet UILabel *lblboxdate;
@property(nonatomic,weak)IBOutlet UIImageView *imgDate;
@property(nonatomic,weak)IBOutlet UIImageView *imgcircle;

@end
