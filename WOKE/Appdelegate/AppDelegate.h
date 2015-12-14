//
//  AppDelegate.h
//  WOKE
//
//  Created by mac on 9/29/15.
//  Copyright © 2015 Themesoft. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "WOUserModel.h"
@interface AppDelegate : UIResponder <UIApplicationDelegate>

@property (strong, nonatomic) UIWindow *window;
@property (strong, nonatomic) WOUserModel *userObj;
@property(nonatomic,readwrite)BOOL isupdateProfile;

@end

