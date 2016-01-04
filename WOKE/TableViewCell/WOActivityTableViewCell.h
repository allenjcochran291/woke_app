//
//  WOActivityTableViewCell.h
//  WOKE
//
//  Created by mac on 1/4/16.
//  Copyright © 2016 Themesoft. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface WOActivityTableViewCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UIImageView *profileImageView;
@property (weak, nonatomic) IBOutlet UILabel *profileName;
@property (weak, nonatomic) IBOutlet UILabel *statesAndCity;
@property (weak, nonatomic) IBOutlet UILabel *lastActive;
@property (weak, nonatomic) IBOutlet UILabel *statusMessage;
@property (weak, nonatomic) IBOutlet UIButton *locationButton;
@property (weak, nonatomic) IBOutlet UIButton *muteButton;
@end
