//
//  WOUserModel.h
//  WOKE
//
//  Created by mac on 12/9/15.
//  Copyright © 2015 Themesoft. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface WOUserModel : NSObject
@property (strong,atomic)NSString *userEmail;
@property (strong,atomic)NSString *passWord;
@property (strong,atomic)NSString *firstName;
@property (strong,atomic)NSString *phoneNo;
@property (strong,atomic)NSString *officeAddress1;
@property (strong,atomic)NSString *homeAddress1;
@property (strong,atomic)NSString *officeAddress2;
@property (strong,atomic)NSString *homeAddress2;
@property (strong,atomic)NSString *fullName;
@property (strong,atomic)NSString *statusMessage;
@property (strong,atomic)UIImage  *profileImage;
@property (strong,atomic)NSString *homeAddressState;
@property (strong,atomic)NSString *officeAdressState;
@property (strong,atomic)NSString *profilePath;
@property (strong,atomic)NSString *userid;

@end
