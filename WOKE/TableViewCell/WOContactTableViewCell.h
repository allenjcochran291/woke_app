//
//  ProfileContactTableViewCell.h
//  WOKE
//
//  Created by mac on 9/30/15.
//  Copyright © 2015 Themesoft. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface WOContactTableViewCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UIImageView *contactIcon;
@property (weak, nonatomic)  UIImageView *profileImageView;

@property (weak, nonatomic) IBOutlet UILabel *contactTitle;
@property (weak, nonatomic) IBOutlet UILabel *phoneNoLabel;
@property (weak, nonatomic) IBOutlet UITextField *address2;
@property (weak, nonatomic) IBOutlet UIImageView *emergencyProfileImageView;
@property (weak, nonatomic) IBOutlet UILabel *emergencyContactName;
@property (weak, nonatomic) IBOutlet UILabel *emergencyPhoneNo;
@property (weak, nonatomic) IBOutlet UITextView *statusMessage;
@property (weak, nonatomic) IBOutlet UIButton *profileImage;
@property (weak, nonatomic) IBOutlet UITextField *state;

@property (weak, nonatomic) IBOutlet UITextField *address1;
@property (weak, nonatomic) IBOutlet UITextField *nameTextField;
@property (weak, nonatomic) IBOutlet UITextField *contactTextField;
@end
