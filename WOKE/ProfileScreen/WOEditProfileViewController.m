//
//  ViewController.m
//  Woke
//
//  Created by Nandhakumar V on 02/10/15.
//  Copyright (c) 2015 InvicibleDevs. All rights reserved.
//

#import "WOEditProfileViewController.h"
#import "WOProfileNameTableViewCell.h"
#import "WOProfileContactTableViewCell.h"
#import "WOProfileAddressTableViewCell.h"
#import "WOEmergencyContactTableViewCell.h"
#import "WOProfileFooterTableViewCell.h"

@interface WOEditProfileViewController ()

@property (strong, nonatomic) IBOutlet UITableView *tableVIew;
@end

@implementation WOEditProfileViewController
- (IBAction)updatePhoto:(UIButton *)sender {
    
    [self.takeController takePhotoOrChooseFromLibrary];

}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    static NSString *cellIdentifier = @"WOProfileFooterTableViewCell";


    self.takeController = [[FDTakeController alloc] init];
    self.takeController.delegate = (id)self;
    // You can optionally override action sheet titles
    //	self.takeController.takePhotoText = @"Take Photo";
    //	self.takeController.takeVideoText = @"Take Video";
    //	self.takeController.chooseFromPhotoRollText = @"Choose Existing";
    //	self.takeController.chooseFromLibraryText = @"Choose Existing";
    //	self.takeController.cancelText = @"Cancel";
    //	self.takeController.noSourcesText = @"No Photos Available";
    // Do any additional setup after loading the view, typically from a nib.
    [_tableVIew reloadData];
    _tableVIew.backgroundColor = [UIColor blueColor];
    

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
//    int rowcount = 3;
//    switch (section) {
//        case 0:
//            rowcount = 3;
//            break;
//        case 2:
//            rowcount = 1;
//            break;
//        case 3:
//            rowcount = 2;
//            break;
//        case 4:
//            rowcount = 5;
//            break;
//            
//        default:
//            break;
//    }
    return 3;
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
    return 0;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
//    switch (section) {
//        case 4:
//        {
//            static NSString *cellIdentifier = @"WOProfileFooterTableViewCell";
//            WOProfileFooterTableViewCell *headerCell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
//            headerCell.headerLabel.text = @"Emergency Contacts";
//
//            headerCell.backgroundColor =[UIColor clearColor];
//
//            return headerCell;
//        }
//            break;
//        default:
//            break;
//    }
    return nil;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    CGFloat cellHeight = 0.0;
    switch (indexPath.section) {
        case 0:
   cellHeight = 30;
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
 
            static NSString *cellIdentifier = @"WOEmergencyContactTableViewCell";
            WOEmergencyContactTableViewCell *profileEmergencyContactCell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    
    if (profileEmergencyContactCell == nil) {
        /* instantiate cell or load nib */
        profileEmergencyContactCell = [[WOEmergencyContactTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier] ;
    }
            profileEmergencyContactCell.backgroundColor =[UIColor whiteColor];
            
            return profileEmergencyContactCell;
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
    return 0;
}

- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section
{
    

//    switch (section) {
//        case 1:
//        {
//            static NSString *cellIdentifier = @"WOProfileFooterTableViewCell";
//            WOProfileFooterTableViewCell *footerCell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
//            footerCell.headerLabel.text = @"Add Phone";
//            footerCell.backgroundColor =[UIColor clearColor];
//
//            return footerCell;
//        }
//            break;
//        case 2:
//        {
//            static NSString *cellIdentifier = @"WOProfileFooterTableViewCell";
//            WOProfileFooterTableViewCell *footerCell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
//            footerCell.headerLabel.text = @"Add Email";
//            footerCell.backgroundColor =[UIColor clearColor];
//
//            return footerCell;
//        }
//            break;
//        default:
//            break;
//    }
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
