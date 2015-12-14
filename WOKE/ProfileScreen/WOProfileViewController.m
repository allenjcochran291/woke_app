//
//  ProfileViewController.m
//  WOKE
//
//  Created by mac on 9/30/15.
//  Copyright © 2015 Themesoft. All rights reserved.
//

#import "WOProfileViewController.h"
#import "WOContactTableViewCell.h"
#import "AppDelegate.h"
#import "UIImageView+AFNetworking.h"
#import "AFHTTPRequestOperation.h"
@interface WOProfileViewController ()<UITextFieldDelegate, UITextViewDelegate>
{
    NSArray *contactLabelArry;
    NSArray *contactImageArry;

}
@property (weak, nonatomic) IBOutlet UIImageView *profileImageView;
@property (strong, nonatomic)  UITextField *currentField;

@property (weak, nonatomic) IBOutlet UIButton *profileImage;

@property (weak, nonatomic) IBOutlet UILabel *profileName;
@property (weak, nonatomic) IBOutlet UILabel *profileAddress;
@property (weak, nonatomic) IBOutlet UILabel *lastSeen;
@property (weak, nonatomic) IBOutlet UILabel *statusMessage;
@property (weak, nonatomic) IBOutlet UITableView *profileTableView;

- (IBAction)logoutAction:(UIButton *)sender;
@property (weak, nonatomic) IBOutlet UIButton *logoutButton;
@property (strong, nonatomic)  UIButton *profileImageButton;
@property (strong, nonatomic)  AppDelegate* appdelegateObj;
- (IBAction)cancelAction:(id)sender;
- (IBAction)doneAction:(id)sender;

@end

@implementation WOProfileViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    _appdelegateObj = (AppDelegate*)[[UIApplication sharedApplication]delegate];

    self.takeController = [[FDTakeController alloc] init];
    self.takeController.delegate = (id)self;
    self.logoutButton.layer.borderColor =[UIColor blackColor].CGColor;

    self.profileImageView.layer.borderColor =[UIColor whiteColor].CGColor;
    self.profileImageView.image =[UIImage imageNamed:@"email1"];
    self.profileTableView.backgroundColor =[UIColor clearColor];
    self.profileTableView.separatorColor= [UIColor clearColor];
    contactLabelArry =[NSArray arrayWithObjects:@"mobile",@"Mobile Phone",@"Email Address",@"Office Address",@"Home Address" ,nil];
    contactImageArry =[NSArray arrayWithObjects:@"WOK_MOBILE_ICON",@"WOK_PHONE_ICON",@"WOK_EMAIL_ICON",@"WOK_OFFICE_ICON",@"WOK_HOUSE_ICON", nil];
    self.profileTableView.allowsSelection = NO;
    self.statusMessage.text =@"Hey I am at Grocery";
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillShow:) name:UIKeyboardWillShowNotification object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillHide:) name:UIKeyboardWillHideNotification object:nil];


//self.profileTableView.tableFooterView = [UIView new];
   
    // Do any additional setup after loading the view.
}
- (IBAction)addProfile:(UIButton *)sender {
    _profileImageButton = sender;
    [_currentField resignFirstResponder];
    [self.takeController takePhotoOrChooseFromLibrary];

}

- (void)takeController:(FDTakeController *)controller gotPhoto:(UIImage *)photo withInfo:(NSDictionary *)info
{
    
    [_profileImageButton setBackgroundImage:photo forState:UIControlStateNormal];
    _profileImageButton.layer.cornerRadius = 30;
   _profileImageButton.layer.masksToBounds = YES;
    self.appdelegateObj.userObj.profileImage =photo;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (void)textViewDidBeginEditing:(UITextView *)textView
{
    if ([textView.text isEqualToString:@"Create your first status update!"]) {
        textView.text = @"";
    }
    [textView becomeFirstResponder];
}

- (void)textViewDidEndEditing:(UITextView *)textView
{
    if ([textView.text isEqualToString:@""]) {
        textView.text = @"Create your first status update!";
    }
    [textView resignFirstResponder];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;    //count of section
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    if (section==0) {
        return [contactLabelArry count];
    }
    return 5;    //count number of row from counting array hear cataGorry is An Array
}

-(void)viewWillAppear:(BOOL)animated{

    AppDelegate* appdelegateObj = (AppDelegate*)[[UIApplication sharedApplication]delegate];
    self.isupdateProfile = appdelegateObj.isupdateProfile;
    
}
-(void)viewWillDisappear:(BOOL)animated
{
}
- (UITableViewCell *)tableView:(UITableView *)tableView
         cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
//    if (indexPath.section==0) {
        if ((indexPath.row==1 || indexPath.row==2)) {
            static NSString *MyIdentifier = @"contactCell2";
            
            WOContactTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:MyIdentifier];
            
            if (cell == nil)
            {
                cell = [[WOContactTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault
                                                          reuseIdentifier:MyIdentifier];
            }
            [cell.contactTextField setClearButtonMode:UITextFieldViewModeWhileEditing];
            cell.backgroundColor =[UIColor clearColor];
            cell.contactTitle.text =[contactLabelArry objectAtIndex:indexPath.row];
            cell.contactIcon.image = [UIImage imageNamed:[contactImageArry objectAtIndex:indexPath.row]];
            if (indexPath.row == 0)                 cell.nameTextField.text = _appdelegateObj.userObj.fullName;

            if (indexPath.row == 1)
            {
                [cell.contactTextField setKeyboardType:UIKeyboardTypeNumberPad];
                cell.contactTextField.text = _appdelegateObj.userObj.phoneNo;
            }

            if (indexPath.row == 2)                 cell.contactTextField.text = _appdelegateObj.userObj.userEmail;

        
            return cell;
        }
     
        else if(indexPath.row==4||indexPath.row == 3){
            static NSString *MyIdentifier = @"addressCell";

            WOContactTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:MyIdentifier];

            if (cell == nil)
            {
                cell = [[WOContactTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault
                                                     reuseIdentifier:MyIdentifier];
            }
            cell.contactTitle.text =[contactLabelArry objectAtIndex:indexPath.row];
            cell.contactIcon.image = [UIImage imageNamed:[contactImageArry objectAtIndex:indexPath.row]];
            if (indexPath.row == 3){
                cell.address1.tag =103;
                cell.address2.tag =104;
                cell.state.tag =102;

                cell.address1.text = _appdelegateObj.userObj.officeAddress1;
                cell.address2.text = _appdelegateObj.userObj.officeAddress2;
                cell.state.text = _appdelegateObj.userObj.officeAdressState;
            }
            
            if (indexPath.row == 4)
                
            {cell.address1.tag =105;
                cell.address2.tag =106;
                cell.state.tag =107;
                cell.address1.text = _appdelegateObj.userObj.homeAddress1;
                cell.address2.text = _appdelegateObj.userObj.homeAddress2;
                cell.state.text = _appdelegateObj.userObj.homeAddressState;

            }
                cell.backgroundColor =[UIColor clearColor];
            return cell;
        }
        else{
            static NSString *MyIdentifier = @"contactCell";
            
            WOContactTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:MyIdentifier];
            
            if (cell == nil)
            {
                cell = [[WOContactTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault
                                                          reuseIdentifier:MyIdentifier];
            }
            [cell.nameTextField setClearButtonMode:UITextFieldViewModeWhileEditing];

            cell.backgroundColor =[UIColor clearColor];
            cell.contactTitle.text =[contactLabelArry objectAtIndex:indexPath.row];
            cell.contactIcon.image = [UIImage imageNamed:[contactImageArry objectAtIndex:indexPath.row]];
            if (self.appdelegateObj.userObj.profileImage!=nil) {
                [cell.profileImage setBackgroundImage:self.appdelegateObj.userObj.profileImage forState:UIControlStateNormal];
                cell.profileImage.layer.cornerRadius = 30;
                cell.profileImage.layer.masksToBounds = YES;
            }
            else
            {
            
                if (self.appdelegateObj.userObj.profilePath!=nil && [self.appdelegateObj.userObj.profilePath containsString:@"png"] && !_isDownloaded) {
                    NSURL *url = [NSURL URLWithString:self.appdelegateObj.userObj.profilePath];
                    NSData *data = [NSData dataWithContentsOfURL:url];
                    UIImage *img = [[UIImage alloc] initWithData:data];
                    [cell.profileImage setBackgroundImage:img forState:UIControlStateNormal];
                    cell.profileImageView.image = img;
                    cell.profileImage.layer.cornerRadius = 30;
                    cell.profileImage.layer.masksToBounds = YES;
                    _isDownloaded=YES;
                }
              
//                __weak UITableViewCell *weakCell = cell;
//                [cell.profileImageView setImageWithURLRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:self.appdelegateObj.userObj.profilePath]] placeholderImage:nil success:^(NSURLRequest *request,   NSHTTPURLResponse *response, UIImage *image) {
//                    if (weakCell)
//                    {
//                        weakCell.imageView.image = image;
//                        [cell.profileImage setBackgroundImage:image forState:UIControlStateNormal];
//                        [weakCell setNeedsLayout];
//                    }
//                } failure:^(NSURLRequest *request, NSHTTPURLResponse *response, NSError *error) {
//                    NSLog(@"Error: %@", error);
//                }];


            }
            
    
            cell.phoneNoLabel.text =@"000-000-000";
     cell.statusMessage.text=self.appdelegateObj.userObj.statusMessage;
       cell.nameTextField.text = _appdelegateObj.userObj.fullName;
            return cell;
        }
    
}


- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    if (section==1) {
        return 50.0;
    }
    return 0;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    static NSString *HeaderCellIdentifier = @"emergencyHeader";
    
    WOContactTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:HeaderCellIdentifier];
    if (cell == nil) {
        cell = [[WOContactTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:HeaderCellIdentifier];
    }
    cell.backgroundColor =[UIColor clearColor];
    
    // Configure the cell title etc
  
    
    return cell;
}


- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 0) {
        if (indexPath.row == 0)
            return 192;
        else if (indexPath.row == 3)
            return 117;
        else if (indexPath.row == 4)
            return 117;
        else
            return 90;
    }
    if (indexPath.section ==1 ) {
    return 73;
    }
    return 238;
    
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    

    
}
- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string {
    BOOL result = YES;
    
    
    
  
    NSIndexPath *indexPath = [self.profileTableView indexPathForCell:(WOContactTableViewCell*)[[textField superview] superview]]; // this should return you your current indexPath
    
    // From here on you can (switch) your indexPath.section or indexPath.row
    // as appropriate to get the textValue and assign it to a variable, for instance:
    if (indexPath.section == 0 && indexPath.row==1) {
    if (string.length != 0) {
        NSMutableString *text = [NSMutableString stringWithString:[[textField.text componentsSeparatedByCharactersInSet:[[NSCharacterSet decimalDigitCharacterSet] invertedSet]] componentsJoinedByString:@""]];
        [text insertString:@"(" atIndex:0];
        
        if (text.length > 3)
            [text insertString:@") " atIndex:4];
        
        if (text.length > 8)
            [text insertString:@"-" atIndex:9];
        
        if (text.length > 13) {
            text = [NSMutableString stringWithString:[text substringToIndex:14]];
            result = NO;
        }
        textField.text = text;
    }
    
    }
    return result;
}
- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField
{
    _currentField =textField;
    return YES;
}
- (void) textFieldDidEndEditing:(UITextField *)textField {

NSIndexPath *indexPath = [self.profileTableView indexPathForCell:(WOContactTableViewCell*)[[textField superview] superview]]; // this should return you your current indexPath

// From here on you can (switch) your indexPath.section or indexPath.row
// as appropriate to get the textValue and assign it to a variable, for instance:
if (indexPath.section == 0) {
    if (indexPath.row == 0) self.appdelegateObj.userObj.fullName = textField.text;
    if (indexPath.row == 1) self.appdelegateObj.userObj.phoneNo = textField.text;
    if (indexPath.row == 2) self.appdelegateObj.userObj.userEmail = textField.text;
    if (indexPath.row == 3)
    {
        if (textField.tag==103) {
            self.appdelegateObj.userObj.officeAddress1 = textField.text;
        }
        else if (textField.tag==102) {
            self.appdelegateObj.userObj.officeAdressState = textField.text;
        }
        else
        {
            self.appdelegateObj.userObj.officeAddress2 = textField.text;

        }
    }
    if (indexPath.row == 4)  {
        if (textField.tag==105) {
            self.appdelegateObj.userObj.homeAddress1 = textField.text;
        }
        else if ((textField.tag==107))
        {
            self.appdelegateObj.userObj.homeAddressState = textField.text;

        }
        else
        {
            self.appdelegateObj.userObj.homeAddress2 = textField.text;
            
        }
    }
}
}
/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

- (IBAction)logoutAction:(UIButton *)sender {
    AppDelegate* appdelegateObj = (AppDelegate*)[[UIApplication sharedApplication]delegate];
    self.isupdateProfile=appdelegateObj.isupdateProfile =NO;

    [self.navigationController popToRootViewControllerAnimated:YES];
}

#pragma mark - Keyboard Notifications

- (void)keyboardWillShow:(NSNotification *)notification;
{
    NSDictionary *userInfo = [notification userInfo];
    NSValue *keyboardBoundsValue = [userInfo objectForKey:UIKeyboardFrameEndUserInfoKey];
    CGFloat keyboardHeight = [keyboardBoundsValue CGRectValue].size.height;

    CGFloat duration = [[userInfo objectForKey:UIKeyboardAnimationDurationUserInfoKey] floatValue];
    NSInteger animationCurve = [[userInfo objectForKey:UIKeyboardAnimationCurveUserInfoKey] integerValue];
    UIEdgeInsets insets = [[self profileTableView] contentInset];
    [UIView animateWithDuration:duration delay:0. options:animationCurve animations:^{
        [[self profileTableView] setContentInset:UIEdgeInsetsMake(insets.top, insets.left, keyboardHeight, insets.right)];
        [[self view] layoutIfNeeded];
    } completion:nil];
}

- (void)keyboardWillHide:(NSNotification *)notification;
{
    NSDictionary *userInfo = [notification userInfo];
    CGFloat duration = [[userInfo objectForKey:UIKeyboardAnimationDurationUserInfoKey] floatValue];
    NSInteger animationCurve = [[userInfo objectForKey:UIKeyboardAnimationCurveUserInfoKey] integerValue];
    UIEdgeInsets insets = [[self profileTableView] contentInset];
    [UIView animateWithDuration:duration delay:0. options:animationCurve animations:^{
        [[self profileTableView] setContentInset:UIEdgeInsetsMake(insets.top, insets.left, 0., insets.right)];
        [[self view] layoutIfNeeded];
    } completion:nil];
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField {

    // Dismisses the keyboard when the "Done" button is clicked

    [textField resignFirstResponder];

    return YES;
}

-(BOOL)textViewShouldEndEditing:(UITextView *)textView
{
    NSIndexPath *indexPath = [self.profileTableView indexPathForCell:(WOContactTableViewCell*)[[textView superview] superview]]; // this should return you your current indexPath
    
    // From here on you can (switch) your indexPath.section or indexPath.row
    // as appropriate to get the textValue and assign it to a variable, for instance:
    if (indexPath.section == 0) {
        if (indexPath.row == 0) self.appdelegateObj.userObj.statusMessage = textView.text;

    [textView resignFirstResponder];
    }
    return YES;
}

- (IBAction)cancelAction:(id)sender {
     [self.navigationController popToRootViewControllerAnimated:YES];
}

- (IBAction)doneAction:(id)sender {
    
    
    if (_isupdateProfile) {
        
        if (self.appdelegateObj.userObj.fullName.length>0) {
            MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
            hud.mode = MBProgressHUDModeIndeterminate;
            hud.labelText = @"Loading";
            
            [self.view addSubview:hud];
            [self.view setUserInteractionEnabled:NO];
            
            NSURL *url = [NSURL URLWithString:@"http://www.creativelabinteractive.com/woke/api/index.php?route=account/update"];
            AFHTTPClient *httpClient = [[AFHTTPClient alloc] initWithBaseURL:url];
            
            NSDictionary *params = [NSDictionary dictionaryWithObjectsAndKeys:
                                    API_KEY,@"client_key",
                                    @"fffff",@"device_id",
                                   [self.appdelegateObj.userObj.userid empty],@"user_id",
                                    [self.appdelegateObj.userObj.userEmail empty],@"email",
                                    [self.appdelegateObj.userObj.fullName empty],@"first_name",
                                    @"",@"last_name",
                                    [self.appdelegateObj.userObj.passWord empty],@"password",
                                    [self.appdelegateObj.userObj.phoneNo empty],@"mobile_no",
                                    @"",@"home_no",
                                    @"", @"office_no",
                                    [self.appdelegateObj.userObj.homeAddress1 empty],@"home_address",
                                    [self.appdelegateObj.userObj.officeAddress1 empty],@"office_address",
                                    [self.appdelegateObj.userObj.homeAddressState empty],@"home_address_state",
                                    [self.appdelegateObj.userObj.homeAddress2 empty], @"home_address_city",
                                    [self.appdelegateObj.userObj.officeAdressState empty],@"office_address_state",
                                    [self.appdelegateObj.userObj.officeAddress2 empty], @"office_address_city",
                                    @"",@"home_address_zip",
                                    @"",@"emergency_contact",
                                    @"", @"profile_photo_path",
                                    [self.appdelegateObj.userObj.statusMessage empty],@"status_update",
                                    @"", @"phone_model",
                                    @"",@"MNC",
                                    @"",  @"MCC",
                                    @"", @"os_version",
                                    nil];
            
            [httpClient postPath:@"" parameters:params success:^(AFHTTPRequestOperation *operation, id responseObject) {
                
                NSError* error;
                NSDictionary* json = [NSJSONSerialization JSONObjectWithData:responseObject
                                                                     options:kNilOptions
                                                                       error:&error];
                
                NSLog(@"LOGIN_SYNC = %@", json);
                
                if ([[[json objectForKey:@"status"]valueForKey:@"code"]integerValue]==506) {
                    
                    NSString *userid =[NSString stringWithFormat:@"%@",[[json objectForKey:@"user_info"]valueForKey:@"user_id"]];
                    CGImageRef cgref = [self.appdelegateObj.userObj.profileImage CGImage];
                    CIImage *cim = [self.appdelegateObj.userObj.profileImage CIImage];
                    
                    if (cim == nil && cgref == NULL)
                    {
                        [hud removeFromSuperview];
                        [self.view setUserInteractionEnabled:YES];
                        [self performSegueWithIdentifier:@"showGetStartedMatesView" sender:nil];
                        NSLog(@"no underlying data");
                    }
                    else
                    {
                        NSURL *url = [NSURL URLWithString:@"http://www.creativelabinteractive.com/woke/api/index.php?route=account/updatedp"];
                        AFHTTPClient *httpClient = [[AFHTTPClient alloc] initWithBaseURL:url];
                        NSData *imgData= UIImageJPEGRepresentation(self.appdelegateObj.userObj.profileImage,0.0);
                        NSDictionary *params = [NSDictionary dictionaryWithObjectsAndKeys:
                                                API_KEY,@"client_key",
                                                [self.appdelegateObj.userObj.userid empty], @"user_id",
                                                nil];
                        NSMutableURLRequest *request1 = [httpClient multipartFormRequestWithMethod:@"POST" path:nil parameters:params constructingBodyWithBlock: ^(id <AFMultipartFormData>formData) {
                            [formData appendPartWithFileData: imgData name:@"image" fileName:@"image.png" mimeType:@"image/png"];
                        }];
                        AFHTTPRequestOperation *operation1 = [[AFHTTPRequestOperation alloc] initWithRequest:request1];
                        [operation1 setUploadProgressBlock:^(NSUInteger bytesWritten, long long totalBytesWritten, long long totalBytesExpectedToWrite) {
                            
                        }];
                        [httpClient enqueueHTTPRequestOperation:operation1];
                        
                        [operation1 setCompletionBlockWithSuccess:^(AFHTTPRequestOperation *operation, id responseObject) {
                            
                            NSData *JSONData = [operation.responseString dataUsingEncoding:NSUTF8StringEncoding];
                            NSDictionary *jsonObject = [NSJSONSerialization JSONObjectWithData:JSONData options:NSJSONReadingMutableContainers error:nil];
                            NSDictionary *status =[jsonObject objectForKey:@"status"];
                            [self performSegueWithIdentifier:@"showGetStartedMatesView" sender:nil];
                            
                            [hud removeFromSuperview];
                            [self.view setUserInteractionEnabled:YES];
                            
                        }
                                                          failure:^(AFHTTPRequestOperation *operation, NSError *error) {
                                                              NSLog(@"error: %@", operation.responseString);
                                                              NSLog(@"%@",error);
                                                              [hud removeFromSuperview];
                                                              [self.view setUserInteractionEnabled:YES];
                                                              [self presentAlert:error.localizedDescription];
                                                              
                                                          }];
                        [operation1 start];
                    }
                    
                }
                else{
                    [self presentAlert:[[json objectForKey:@"status"]valueForKey:@"message"]];
                    [hud removeFromSuperview];
                    [self.view setUserInteractionEnabled:YES];
                }
                
                
                
                
                
            } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
                [hud removeFromSuperview];
                [self.view setUserInteractionEnabled:YES];
                [self presentAlert:error.localizedDescription];
                
                NSLog(@"[HTTPClient Error]: %@", error.localizedDescription);
                
            }];
            
        }
        else
            [self presentAlert:@"Please enter the full Name!"];
    }
    else{
    
    
        if (self.appdelegateObj.userObj.fullName.length>0) {
            MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
            hud.mode = MBProgressHUDModeIndeterminate;
            hud.labelText = @"Loading";
            
            [self.view addSubview:hud];
            [self.view setUserInteractionEnabled:NO];
            
            NSURL *url = [NSURL URLWithString:@"http://www.creativelabinteractive.com/woke/api/index.php?route=account/signup"];
            AFHTTPClient *httpClient = [[AFHTTPClient alloc] initWithBaseURL:url];
            
            NSDictionary *params = [NSDictionary dictionaryWithObjectsAndKeys:
                                    API_KEY,@"client_key",
                                    @"", @"username",
                                    @"fffff",@"device_id",
                                    [self.appdelegateObj.userObj.userEmail empty],@"email",
                                    [self.appdelegateObj.userObj.fullName empty],@"first_name",
                                    @"",@"last_name",
                                    [self.appdelegateObj.userObj.passWord empty],@"password",
                                    [self.appdelegateObj.userObj.phoneNo empty],@"mobile_no",
                                    @"",@"home_no",
                                    @"", @"office_no",
                                    [self.appdelegateObj.userObj.homeAddress1 empty],@"home_address",
                                    [self.appdelegateObj.userObj.officeAddress1 empty],@"office_address",
                                    [self.appdelegateObj.userObj.homeAddressState empty],@"home_address_state",
                                    [self.appdelegateObj.userObj.homeAddress2 empty], @"home_address_city",
                                    [self.appdelegateObj.userObj.officeAdressState empty],@"office_address_state",
                                    [self.appdelegateObj.userObj.officeAddress2 empty], @"office_address_city",
                                    @"",@"home_address_zip",
                                    @"",@"emergency_contact",
                                    @"", @"profile_photo_path",
                                    [self.appdelegateObj.userObj.statusMessage empty],@"status_update",
                                    @"", @"phone_model",
                                    @"",@"MNC",
                                    @"",  @"MCC",
                                    @"", @"os_version",
                                    nil];
            
            [httpClient postPath:@"" parameters:params success:^(AFHTTPRequestOperation *operation, id responseObject) {
                
                NSError* error;
                NSDictionary* json = [NSJSONSerialization JSONObjectWithData:responseObject
                                                                     options:kNilOptions
                                                                       error:&error];
                
                NSLog(@"LOGIN_SYNC = %@", json);
                
                if ([[[json objectForKey:@"status"]valueForKey:@"code"]integerValue]==500) {
                    
                    NSString *userid =[NSString stringWithFormat:@"%@",[[json objectForKey:@"user_info"]valueForKey:@"user_id"]];
                    CGImageRef cgref = [self.appdelegateObj.userObj.profileImage CGImage];
                    CIImage *cim = [self.appdelegateObj.userObj.profileImage CIImage];
                    _isupdateProfile=YES;
                    self.appdelegateObj.isupdateProfile=YES;
                    if (cim == nil && cgref == NULL)
                    {
                        [hud removeFromSuperview];
                        [self.view setUserInteractionEnabled:YES];
                        [self performSegueWithIdentifier:@"showGetStartedMatesView" sender:nil];
                        NSLog(@"no underlying data");
                    }
                    else
                    {
                        NSURL *url = [NSURL URLWithString:@"http://www.creativelabinteractive.com/woke/api/index.php?route=account/updatedp"];
                        AFHTTPClient *httpClient = [[AFHTTPClient alloc] initWithBaseURL:url];
                        NSData *imgData= UIImageJPEGRepresentation(self.appdelegateObj.userObj.profileImage,0.0);
                        NSDictionary *params = [NSDictionary dictionaryWithObjectsAndKeys:
                                                API_KEY,@"client_key",
                                                userid, @"user_id",
                                                nil];
                        NSMutableURLRequest *request1 = [httpClient multipartFormRequestWithMethod:@"POST" path:nil parameters:params constructingBodyWithBlock: ^(id <AFMultipartFormData>formData) {
                            [formData appendPartWithFileData: imgData name:@"image" fileName:@"image.png" mimeType:@"image/png"];
                        }];
                        AFHTTPRequestOperation *operation1 = [[AFHTTPRequestOperation alloc] initWithRequest:request1];
                        [operation1 setUploadProgressBlock:^(NSUInteger bytesWritten, long long totalBytesWritten, long long totalBytesExpectedToWrite) {
                            
                        }];
                        [httpClient enqueueHTTPRequestOperation:operation1];
                        
                        [operation1 setCompletionBlockWithSuccess:^(AFHTTPRequestOperation *operation, id responseObject) {
                            
                            NSData *JSONData = [operation.responseString dataUsingEncoding:NSUTF8StringEncoding];
                            NSDictionary *jsonObject = [NSJSONSerialization JSONObjectWithData:JSONData options:NSJSONReadingMutableContainers error:nil];
                            NSDictionary *status =[jsonObject objectForKey:@"status"];
                            [self performSegueWithIdentifier:@"showGetStartedMatesView" sender:nil];
                            
                            [hud removeFromSuperview];
                            [self.view setUserInteractionEnabled:YES];
                            
                        }
                                                          failure:^(AFHTTPRequestOperation *operation, NSError *error) {
                                                              NSLog(@"error: %@", operation.responseString);
                                                              NSLog(@"%@",error);
                                                              [hud removeFromSuperview];
                                                              [self.view setUserInteractionEnabled:YES];
                                                              [self presentAlert:error.localizedDescription];
                                                              
                                                          }];
                        [operation1 start];
                    }
                    
                }
                else{
                    [hud removeFromSuperview];
                    [self.view setUserInteractionEnabled:YES];
                    [self presentAlert:[[json objectForKey:@"status"]valueForKey:@"message"]];
                }
                
                
                
                
                
            } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
                [hud removeFromSuperview];
                [self.view setUserInteractionEnabled:YES];
                [self presentAlert:error.localizedDescription];
                
                NSLog(@"[HTTPClient Error]: %@", error.localizedDescription);
                
            }];
            
        }
        else
            [self presentAlert:@"Please enter the full Name!"];
    }
    
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

@end
