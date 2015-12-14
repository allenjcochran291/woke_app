//
//  ProfileViewController.h
//  WOKE
//
//  Created by mac on 9/30/15.
//  Copyright © 2015 Themesoft. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "FDTakeController.h"
@interface WOProfileViewController : UIViewController
@property FDTakeController *takeController;
@property(nonatomic,readwrite)BOOL isupdateProfile;
@property(nonatomic,readwrite)BOOL isDownloaded;

@end
