//
//  ViewController.m
//  WOKE
//
//  Created by mac on 9/29/15.
//  Copyright © 2015 Themesoft. All rights reserved.
//

#import "WelcomeViewController.h"
#import <QuartzCore/QuartzCore.h>
@interface WelcomeViewController ()
@property (weak, nonatomic) IBOutlet UIButton *signInButton;
@property (weak, nonatomic) IBOutlet UIButton *createAccountButton;
- (IBAction)signInAction:(UIButton *)sender;
- (IBAction)createAccountAction:(UIButton *)sender;

@end

@implementation WelcomeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.signInButton.layer.borderColor =[UIColor blackColor].CGColor;
        self.createAccountButton.layer.borderColor =[UIColor blackColor].CGColor;
    // Do any additional setup after loading the view, typically from a nib.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)signInAction:(UIButton *)sender {
    
    
}

- (IBAction)createAccountAction:(UIButton *)sender {
}
@end
