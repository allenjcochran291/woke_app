//
//  ViewController.m
//  Woke
//
//  Created by Nandhakumar V on 02/10/15.
//  Copyright (c) 2015 InvicibleDevs. All rights reserved.
//

#import "ViewController.h"
#import "WOProfileNameTableViewCell.h"
#import "WOProfileContactTableViewCell.h"
#import "WOProfileAddressTableViewCell.h"
#import "WOEmergencyContactTableViewCell.h"
#import "WOProfileFooterTableViewCell.h"

@interface ViewController ()

@property (weak, nonatomic) IBOutlet UITableView *tableVIew;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    static NSString *cellIdentifier = @"WOProfileFooterTableViewCell";
    WOProfileFooterTableViewCell *footerCell = [self.tableVIew dequeueReusableCellWithIdentifier:cellIdentifier];
    footerCell.headerLabel.text = @"Add Emergency Contact";
    self.tableVIew.tableFooterView = footerCell;
    // Do any additional setup after loading the view, typically from a nib.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 5;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    int rowcount = 1;
    switch (section) {
        case 1:
            rowcount = 3;
            break;
        case 2:
            rowcount = 1;
            break;
        case 3:
            rowcount = 2;
            break;
        case 4:
            rowcount = 5;
            break;
            
        default:
            break;
    }
    return rowcount;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    CGFloat headerHeight = 0.0;
    switch (section) {
        case 4:
            headerHeight = 44;
            break;
            
        default:
            break;
    }
    return headerHeight;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    switch (section) {
        case 4:
        {
            static NSString *cellIdentifier = @"WOProfileFooterTableViewCell";
            WOProfileFooterTableViewCell *headerCell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
            headerCell.headerLabel.text = @"Emergency Contacts";
            return headerCell;
        }
            break;
        default:
            break;
    }
    return nil;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    CGFloat cellHeight = 0.0;
    switch (indexPath.section) {
        case 0:
            cellHeight = 180;
            break;
        case 1:
            cellHeight = 50;
            break;
        case 2:
            cellHeight = 50;
            break;
        case 3:
            cellHeight = 120;
            break;
        case 4:
            cellHeight = 80;
            break;
            
        default:
            break;
    }
    return cellHeight;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath;
{
    switch (indexPath.section) {
        case 0:
        {
            static NSString *cellIdentifier = @"WOProfileNameTableViewCell";
            WOProfileNameTableViewCell *profileNameCell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
            return profileNameCell;
        }
            break;
        case 1:
        {
            static NSString *cellIdentifier = @"WOProfileContactTableViewCell";
            WOProfileContactTableViewCell *profileContactCell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
            return profileContactCell;
        }
            break;
        case 2:
        {
            static NSString *cellIdentifier = @"WOProfileContactTableViewCell";
            WOProfileContactTableViewCell *profileContactCell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
            return profileContactCell;
        }
            break;
        case 3:
        {
            static NSString *cellIdentifier = @"WOProfileAddressTableViewCell";
            WOProfileAddressTableViewCell *profileAddressCell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
            return profileAddressCell;
        }
            break;
        case 4:
        {
            static NSString *cellIdentifier = @"WOEmergencyContactTableViewCell";
            WOEmergencyContactTableViewCell *profileEmergencyContactCell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
            return profileEmergencyContactCell;
        }
            break;
            
        default:
            break;
    }
    return nil;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    CGFloat footerHeight = 0.0;
    switch (section) {
        case 1:
            footerHeight = 44;
            break;
        case 2:
            footerHeight = 44;
            break;
            
        default:
            break;
    }
    return footerHeight;
}

- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section
{
    switch (section) {
        case 1:
        {
            static NSString *cellIdentifier = @"WOProfileFooterTableViewCell";
            WOProfileFooterTableViewCell *footerCell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
            footerCell.headerLabel.text = @"Add Phone";
            return footerCell;
        }
            break;
        case 2:
        {
            static NSString *cellIdentifier = @"WOProfileFooterTableViewCell";
            WOProfileFooterTableViewCell *footerCell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
            footerCell.headerLabel.text = @"Add Email";
            return footerCell;
        }
            break;
        default:
            break;
    }
    return nil;
}
//
//- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
//    switch (indexPath.section) {
//        case 1:
//            return YES;
//            break;
//        case 2:
//            return YES;
//            break;
//        case 4:
//            return YES;
//            break;
//            
//        default:
//            break;
//    }
//    return NO;
//}
//
//// Override to support editing the table view.
//- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
//    if (editingStyle == UITableViewCellEditingStyleDelete) {
//        //add code here for when you hit delete
//    }
//}
@end
