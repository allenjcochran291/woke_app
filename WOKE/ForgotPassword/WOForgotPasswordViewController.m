//
//  WOForgotPasswordViewController.m
//  WOKE
//
//  Created by mac on 11/23/15.
//  Copyright © 2015 Themesoft. All rights reserved.
//

#import "WOForgotPasswordViewController.h"
#import "AppDelegate.h"
@interface WOForgotPasswordViewController ()
@property (weak, nonatomic) IBOutlet UITextField *userNameTextField;
@property (weak, nonatomic) IBOutlet UIButton *resetButton;

@end

@implementation WOForgotPasswordViewController
- (IBAction)forgotPassword:(UIButton *)sender {
    
    //
    NSString* username = [_userNameTextField text];
    
    if(username.length == 0 ) {
        [self presentAlert:@"Please enter the Email"];
        return;
    }
    if (![username isValidEmail]) {
        //Step 1: Create a UIAlertController
        [self presentAlert:@"Please enter a valid Email!"];
        
    }
    else
    {
        MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
        hud.mode = MBProgressHUDModeIndeterminate;
        hud.labelText = @"Loading";
        
        [self.view addSubview:hud];
        [self.view setUserInteractionEnabled:NO];
        
        NSURL *url = [NSURL URLWithString:@"http://www.creativelabinteractive.com/woke/api/index.php?route=account/forgot"];
        AFHTTPClient *httpClient = [[AFHTTPClient alloc] initWithBaseURL:url];
        
        NSDictionary *params = [NSDictionary dictionaryWithObjectsAndKeys:
                                API_KEY,@"client_key",
                                username, @"email",
                                @"fffff",@"device_id",
                                nil];
        
        [httpClient postPath:@"" parameters:params success:^(AFHTTPRequestOperation *operation, id responseObject) {
            
            NSError* error;
            NSDictionary* json = [NSJSONSerialization JSONObjectWithData:responseObject
                                                                 options:kNilOptions
                                                                   error:&error];
            
            NSLog(@"LOGIN_SYNC = %@", json);
            if ((int)[[json objectForKey:@"status"]valueForKey:@"code"]==500) {
                
            }
            else{
                [self presentAlert:[[json objectForKey:@"status"]valueForKey:@"message"]];
            }
            [hud removeFromSuperview];
            [self.view setUserInteractionEnabled:YES];
            
            
            
        } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
            [hud removeFromSuperview];
            [self.view setUserInteractionEnabled:YES];
            [self presentAlert:error.localizedDescription];

            NSLog(@"[HTTPClient Error]: %@", error.localizedDescription);
            
        }];
        
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

- (void)viewDidLoad {
    [super viewDidLoad];
    self.resetButton.layer.borderColor =[UIColor blackColor].CGColor;
    CALayer *border = [CALayer layer];
    CGFloat borderWidth = 1;
    border.borderColor = [UIColor lightGrayColor].CGColor;
    border.frame = CGRectMake(0, _userNameTextField.frame.size.height - borderWidth, 251, _userNameTextField.frame.size.height);
    border.borderWidth = borderWidth;
    [_userNameTextField.layer addSublayer:border];
    _userNameTextField.layer.masksToBounds = YES;
    // Do any additional setup after loading the view.
}
- (IBAction)cancelButonAction:(UIButton *)sender {
   
    
    [self dismissViewControllerAnimated:YES completion:nil];
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

@end
