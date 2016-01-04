//
//  WOActivityViewController.m
//  WOKE
//
//  Created by mac on 1/4/16.
//  Copyright © 2016 Themesoft. All rights reserved.
//

#import "WOActivityViewController.h"
#import "AppDelegate.h"
#import "WOActivityTableViewCell.h"
@interface WOActivityViewController ()

@end

@implementation WOActivityViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.activityTableView registerNib:[UINib nibWithNibName:@"WOActivityTableViewCell" bundle:nil] forCellReuseIdentifier:@"Cell"];
    self.profileImageView.layer.cornerRadius = 50;
    self.profileImageView.layer.masksToBounds = YES;
    [self getCategoriesList];
    AppDelegate* appdelegateObj = (AppDelegate*)[[UIApplication sharedApplication]delegate];
    self.profileName.text =appdelegateObj.userObj.fullName;
    if (appdelegateObj.userObj.profileImage!=nil) {
        [self.profileImageView setImage:appdelegateObj.userObj.profileImage];
            }
    else
       [self.profileImageView setImageWithURL:[NSURL URLWithString:appdelegateObj.userObj.profilePath] placeholderImage:[UIImage imageNamed:@"00053_WOKE_ONSCRN_AVATAR-OFF"]];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
-(void)getCategoriesList
{
    
    
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    hud.mode = MBProgressHUDModeIndeterminate;
    hud.labelText = @"Loading";
    
    [self.activityTableView addSubview:hud];
    [self.view setUserInteractionEnabled:NO];
    
    NSURL *url = [NSURL URLWithString:@"http://www.creativelabinteractive.com/woke/api/index.php?route=account/getactivityofmatesbyuserid"];
    AFHTTPClient *httpClient = [[AFHTTPClient alloc] initWithBaseURL:url];
    NSDictionary *params = [NSDictionary dictionaryWithObjectsAndKeys:
                            API_KEY,@"client_key",
                            @"1", @"user_id",
                            @"fffff",@"device_id",
                            nil];
    
    [httpClient postPath:@"" parameters:params success:^(AFHTTPRequestOperation *operation, id responseObject) {
        
        NSError* error;
        NSDictionary  *categDict = [NSJSONSerialization JSONObjectWithData:responseObject
                                                                   options:kNilOptions
                                                                     error:&error];
        
        NSLog(@"LOGIN_SYNC = %@", categDict);
        _categList = [[NSMutableArray alloc]init];
        _categList  = [[categDict objectForKey:@"user_info"]mutableCopy];
     
        [_activityTableView reloadData];
     

        [hud removeFromSuperview];
        [self.view setUserInteractionEnabled:YES];
        
        
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        [hud removeFromSuperview];
        [self.view setUserInteractionEnabled:YES];
        [self presentAlert:error.localizedDescription];
        
        NSLog(@"[HTTPClient Error]: %@", error.localizedDescription);
        
    }];
    
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    // Return the number of rows in the section.
    return [_categList count];
}
-(void)presentAlert:(NSString *)message
{
    UIAlertController *myAlertController = [UIAlertController alertControllerWithTitle:@"WOKEAPP"
                                                                               message: message
                                                                        preferredStyle:UIAlertControllerStyleAlert                   ];
    
    //Step 2: Create a UIAlertAction that can be added to the alert
    UIAlertAction* ok = [UIAlertAction
                         actionWithTitle:@"OK"
                         style:UIAlertActionStyleDefault
                         handler:^(UIAlertAction * action)
                         {
                             //Do some thing here, eg dismiss the alertwindow
                             [myAlertController dismissViewControllerAnimated:YES completion:nil];
                             
                         }];
    
    //Step 3: Add the UIAlertAction ok that we just created to our AlertController
    [myAlertController addAction: ok];
    
    //Step 4: Present the alert to the user
    [self presentViewController:myAlertController animated:YES completion:nil];
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{

    return 142;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    // We are looking for cells with the Cell identifier
    // We should reuse unused cells if there are any
    static NSString *cellIdentifier = @"Cell";
    WOActivityTableViewCell *cell = (WOActivityTableViewCell *)[tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    
    // If there is no cell to reuse, create a new one
    if(cell == nil)
    {
        cell = [[WOActivityTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier];
        
    }
    cell.profileImageView.layer.cornerRadius = 25;
    cell.profileImageView.layer.masksToBounds = YES;
    cell.lastActive.text =[NSString stringWithFormat:@"%@",[[_categList objectAtIndex:indexPath.row]valueForKey:@"lastseen"]];
    cell.profileName.text =[NSString stringWithFormat:@"%@",[[_categList objectAtIndex:indexPath.row]valueForKey:@"first_name"]];
    
    NSMutableAttributedString *text =
    [[NSMutableAttributedString alloc]
     initWithString:[NSString stringWithFormat:@"%@ %@",[[_categList objectAtIndex:indexPath.row]valueForKey:@"last_status"],[[_categList objectAtIndex:indexPath.row]valueForKey:@"status_date"]]];
    
    [text addAttribute:NSForegroundColorAttributeName
                 value:[UIColor lightGrayColor]
                 range:NSMakeRange([[[_categList objectAtIndex:indexPath.row]valueForKey:@"last_status"] length]+1, [[[_categList objectAtIndex:indexPath.row]valueForKey:@"status_date"] length])];
    [text addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:10] range:NSMakeRange([[[_categList objectAtIndex:indexPath.row]valueForKey:@"last_status"] length]+1, [[[_categList objectAtIndex:indexPath.row]valueForKey:@"status_date"] length])];

    [cell.statusMessage setAttributedText: text];
  //  cell.statusMessage.text =[NSString stringWithFormat:@"%@ %@",[[_categList objectAtIndex:indexPath.row]valueForKey:@"last_status"],[[_categList objectAtIndex:indexPath.row]valueForKey:@"status_date"]];
    cell.statesAndCity.text =[NSString stringWithFormat:@"%@ %@",[[_categList objectAtIndex:indexPath.row]valueForKey:@"home_address_city"],[[_categList objectAtIndex:indexPath.row]valueForKey:@"home_address_state"]];
   [cell.profileImageView setImageWithURL:[NSURL URLWithString:[[_categList objectAtIndex:indexPath.row] valueForKey:@"profile_photo_path"]]placeholderImage:[UIImage imageNamed:@"00053_WOKE_ONSCRN_AVATAR-OFF"]];
    // Configure the cell before it is displayed...
    cell.muteButton.tag =indexPath.row;
    cell.locationButton.tag =indexPath.row;
    [cell.muteButton addTarget:self
                             action:@selector(muteButtonAction:)
                   forControlEvents:UIControlEventTouchUpInside];
    [cell.locationButton addTarget:self
                        action:@selector(locationButtonAction:)
              forControlEvents:UIControlEventTouchUpInside];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;
}
-(void)muteButtonAction:(UIButton *)sender
{

}
-(void)locationButtonAction:(UIButton *)sender
{
    
}
/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

- (IBAction)settingsButtonClicked:(id)sender {
    
}
@end
