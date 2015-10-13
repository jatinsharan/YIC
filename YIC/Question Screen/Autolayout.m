//
//  Autolayout.m
//  YIC
//
//  Created by ROHIT on 14/10/15.
//
//

#import "Autolayout.h"

@implementation Autolayout

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

- (void)layoutSubviews
{
    [super layoutSubviews];
    
    self.preferredMaxLayoutWidth = CGRectGetWidth(self.bounds);    
    [super layoutSubviews];
}

@end
