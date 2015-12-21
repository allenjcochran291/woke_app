//
//  MateTableViewCell.h
//  WOKE
//
//  Created by mac on 12/21/15.
//  Copyright © 2015 Themesoft. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MateTableViewCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UIButton *inviteButton;
@property (weak, nonatomic) IBOutlet UILabel *userTitle;
@property (weak, nonatomic) IBOutlet UILabel *phoneNo;

@end
