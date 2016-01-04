//
//  WOActivityViewController.h
//  WOKE
//
//  Created by mac on 1/4/16.
//  Copyright © 2016 Themesoft. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface WOActivityViewController : UIViewController
@property (weak, nonatomic) IBOutlet UIImageView *profileImageView;
@property (weak, nonatomic) IBOutlet UILabel *profileName;
@property (weak, nonatomic) IBOutlet UITableView *activityTableView;
- (IBAction)settingsButtonClicked:(id)sender;
@property (strong, nonatomic)NSMutableArray *categList;

@end
