//
//  WOValidation+NSString.h
//  WOKE
//
//  Created by mac on 12/9/15.
//  Copyright © 2015 Themesoft. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSString (emailValidation)
- (BOOL)isValidEmail;
-(NSString *) empty;
@end
