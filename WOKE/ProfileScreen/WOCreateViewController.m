//
//  WOCreateViewController.m
//  WOKE
//
//  Created by mac on 12/1/15.
//  Copyright © 2015 Themesoft. All rights reserved.
//

#import "WOCreateViewController.h"
#import "AppDelegate.h"
@interface WOCreateViewController ()
@property (weak, nonatomic) IBOutlet UITextField *userNameTxt;
@property (weak, nonatomic) IBOutlet UITextField *passWordTxt;
@property (strong, nonatomic)  UITextField *currentTextfield;
@property (weak, nonatomic) IBOutlet UIButton *forgotPasswordButton;
@property (weak, nonatomic) IBOutlet UIButton *signInButton;
@property (weak, nonatomic) IBOutlet UIButton *createAccountButton;
- (IBAction)loginButtonClicked:(UIButton *)sender;
@end

@implementation WOCreateViewController




- (void)viewDidLoad {
    [super viewDidLoad];
    self.createAccountButton.layer.borderColor =[UIColor blackColor].CGColor;
    
    CALayer *border = [CALayer layer];
    CGFloat borderWidth = 1;
    border.borderColor = [UIColor lightGrayColor].CGColor;
    border.frame = CGRectMake(0, _userNameTxt.frame.size.height - borderWidth, _userNameTxt.frame.size.width, _userNameTxt.frame.size.height);
    border.borderWidth = borderWidth;
    [_userNameTxt.layer addSublayer:border];
    _userNameTxt.layer.masksToBounds = YES;
    
    
    CALayer *border1 = [CALayer layer];
    CGFloat borderWidth1 = 1;
    border1.borderColor = [UIColor lightGrayColor].CGColor;
    border1.frame = CGRectMake(0, _passWordTxt.frame.size.height - borderWidth1, _userNameTxt.frame.size.width, _userNameTxt.frame.size.height);
    border1.borderWidth = borderWidth;
    [_passWordTxt.layer addSublayer:border1];
    _passWordTxt.layer.masksToBounds = YES;
    
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#define kOFFSET_FOR_KEYBOARD 100.0


-(void)keyboardWillShow {
    // Animate the current view out of the way
    if (self.view.frame.origin.y >= 0)
    {
        [self setViewMovedUp:YES withTextfield:self.currentTextfield];
    }
    else if (self.view.frame.origin.y < 0)
    {
        //        [self setViewMovedUp:NO withTextfield:self.currentTextfield];
    }
}

-(void)keyboardWillHide {
    if (self.view.frame.origin.y >= 0)
    {
        [self setViewMovedUp:YES withTextfield:self.currentTextfield];
    }
    else if (self.view.frame.origin.y < 0)
    {
        [self setViewMovedUp:NO withTextfield:self.currentTextfield];
    }
}

-(void)textFieldDidBeginEditing:(UITextField *)sender
{
    self.currentTextfield =sender;
    if ([sender isEqual:self.passWordTxt]||[sender isEqual:self.userNameTxt])
    {
        //move the main view, so that the keyboard does not hide it.
        if  (self.view.frame.origin.y >= 0)
        {
            [self setViewMovedUp:YES withTextfield:self.currentTextfield];
        }
    }
    
    
    
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField{
    NSLog(@"textFieldShouldReturn:");
    if (textField.tag == 100) {
        UITextField *passwordTextField = (UITextField *)[self.view viewWithTag:101];
        [passwordTextField becomeFirstResponder];
    }
    else {
        [textField resignFirstResponder];
    }
    return YES;
}

//method to move the view up/down whenever the keyboard is shown/dismissed
-(void)setViewMovedUp:(BOOL)movedUp withTextfield:(UITextField *)textField
{
    [UIView beginAnimations:nil context:NULL];
    [UIView setAnimationDuration:0.3]; // if you want to slide up the view
    
    CGRect rect = self.view.frame;
    if (movedUp)
    {
        // 1. move the view's origin up so that the text field that will be hidden come above the keyboard
        // 2. increase the size of the view so that the area behind the keyboard is covered up.
        rect.origin.y -= kOFFSET_FOR_KEYBOARD;
        rect.size.height += kOFFSET_FOR_KEYBOARD;
    }
    else
    {
        // revert back to the normal state.
        rect.origin.y += kOFFSET_FOR_KEYBOARD;
        rect.size.height -= kOFFSET_FOR_KEYBOARD;
    }
    self.view.frame = rect;
    
    [UIView commitAnimations];
}


- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    // register for keyboard notifications
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(keyboardWillShow)
                                                 name:UIKeyboardWillShowNotification
                                               object:nil];
    
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(keyboardWillHide)
                                                 name:UIKeyboardWillHideNotification
                                               object:nil];
}

- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    // unregister for keyboard notifications while not visible.
    [[NSNotificationCenter defaultCenter] removeObserver:self
                                                    name:UIKeyboardWillShowNotification
                                                  object:nil];
    
    [[NSNotificationCenter defaultCenter] removeObserver:self
                                                    name:UIKeyboardWillHideNotification
                                                  object:nil];
}
/*
 #pragma mark - Navigation
 
 // In a storyboard-based application, you will often want to do a little preparation before navigation
 - (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
 // Get the new view controller using [segue destinationViewController].
 // Pass the selected object to the new view controller.
 }
 */

- (IBAction)loginButtonClicked:(UIButton *)sender {
    
    
    AppDelegate* appdelegateObj = (AppDelegate*)[[UIApplication sharedApplication]delegate];
    appdelegateObj.isupdateProfile =NO;

    NSString* username = [_userNameTxt text];
    NSString* password = [_passWordTxt text];

    if(username.length == 0 || password.length == 0) {
        [self presentAlert:@"Please enter the Email and Password."];
      return;
    }
    if (![username isValidEmail]) {
        //Step 1: Create a UIAlertController
        [self presentAlert:@"Please enter a valid Email!"];
        
    }
    else
    {
        [self performSegueWithIdentifier:@"showGetStartedView" sender:nil];
        appdelegateObj.userObj =[[WOUserModel alloc]init];
        appdelegateObj.userObj.userEmail =username;
        appdelegateObj.userObj.passWord = password;

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
/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
