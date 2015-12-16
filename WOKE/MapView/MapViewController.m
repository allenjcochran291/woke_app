//
//  MapViewController.m
//  WOKE
//
//  Created by mac on 12/16/15.
//  Copyright © 2015 Themesoft. All rights reserved.
//

#import "MapViewController.h"
#import "WOProfileNameTableViewCell.h"
#import "MapTableViewCell.h"

@interface MapViewController ()
@property (weak, nonatomic) IBOutlet UITableView *tableView;

@end

@implementation MapViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [_tableView reloadData];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    int rowcount = 1;
    switch (section) {
        case 0:
            rowcount = 5;
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
    return 0;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{

    return nil;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    CGFloat cellHeight = 0.0;
 
            cellHeight = 50;
            return  cellHeight;
    
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath;
{
        static NSString *cellIdentifier = @"MapTableViewCellIdentifier";
            MapTableViewCell *profileNameCell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
            profileNameCell.backgroundColor =[UIColor redColor];
            return profileNameCell;
      }



@end
