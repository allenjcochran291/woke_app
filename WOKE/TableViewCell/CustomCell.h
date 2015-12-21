//
//  CustomCell.h
//  SimpleTableViewController
//
//  Created by Krzysztof Satola on 07.12.2012.
//  Copyright (c) 2012 API-SOFT. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CustomCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UITextField *valueField;
@property (weak, nonatomic) IBOutlet UILabel *labelField;
@property (weak, nonatomic) IBOutlet UISwitch *switchButton;
@property (weak, nonatomic) IBOutlet UIButton *switchbuttonPro;

@end
