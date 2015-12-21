//
//  ViewController.m
//  TableSearch
//
//  Created by Jobin Kurian on 10/02/12.
//  Copyright (c) 2012 Fafadia Tech, Mumbai. All rights reserved.
//
#import <AddressBook/AddressBook.h>

#import "WOMatesViewController.h"
#import "AppDelegate.h"
#import "MateTableViewCell.h"


@implementation WOMatesViewController
@synthesize tblContentList;
@synthesize searchBar;
@synthesize searchBarController;
@synthesize filteredContentList;
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Release any cached data, images, etc that aren't in use.
}

#pragma mark - View lifecycle

- (void)viewDidLoad {
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    


    filteredContentList = [[NSMutableArray alloc] init];
   contentList= [self getContactAuthorizationFromUser];
    [self.tblContentList registerNib:[UINib nibWithNibName:@"MateTableViewCell" bundle:nil] forCellReuseIdentifier:@"Cell"];
    [self.searchBarController.searchResultsTableView registerNib:[UINib nibWithNibName:@"MateTableViewCell" bundle:nil] forCellReuseIdentifier:@"Cell"];

    [self setContacts];
    [self.tblContentList reloadData];
}
-(NSMutableArray *)getContactAuthorizationFromUser{
    NSMutableArray *finalContactList = [[NSMutableArray alloc] init];
    ABAddressBookRef addressBookRef = ABAddressBookCreateWithOptions(NULL, NULL);
    if (ABAddressBookGetAuthorizationStatus() == kABAuthorizationStatusNotDetermined) {
        ABAddressBookRequestAccessWithCompletion(addressBookRef, ^(bool granted, CFErrorRef error) {
            if (granted) {
                // First time access has been granted, add the contact
                [finalContactList addObject:[self getContacts]];
            } else {
                // User denied access
                // Display an alert telling user the contact could not be added
            }
        });
    }
    else if (ABAddressBookGetAuthorizationStatus() == kABAuthorizationStatusAuthorized) {
        // The user has previously given access, add the contact
        finalContactList = [self getContacts];
    }
    else {
        // The user has previously denied access
        // Send an alert telling user to change privacy setting in settings app
    }
    return finalContactList;
}

-(NSMutableArray *)getContacts
{
    
    NSMutableArray *newContactArray   = [[NSMutableArray alloc]init];
    ABAddressBookRef addressBook = ABAddressBookCreateWithOptions(NULL, NULL);
    NSArray *arrayOfAllPeople1 = (__bridge NSArray *) ABAddressBookCopyArrayOfAllPeople(addressBook);
    NSUInteger peopleCounter = 0;
    for (peopleCounter = 0;peopleCounter < [arrayOfAllPeople1 count]; peopleCounter++)
    {
        ABRecordRef thisPerson = (__bridge ABRecordRef) [arrayOfAllPeople1 objectAtIndex:peopleCounter];
        NSString *name = (__bridge NSString *) ABRecordCopyCompositeName(thisPerson);
        ABMultiValueRef number = ABRecordCopyValue(thisPerson, kABPersonPhoneProperty);
        for (NSUInteger emailCounter = 0; emailCounter < ABMultiValueGetCount(number); emailCounter++)
        {
            NSString *email = (__bridge NSString *)ABMultiValueCopyValueAtIndex(number, emailCounter);
            if ([email length]!=0)
            {
                NSString* removed1=[email stringByReplacingOccurrencesOfString:@"-"withString:@""];
                NSString* removed2=[removed1 stringByReplacingOccurrencesOfString:@")"withString:@""];
                NSString* removed3=[removed2 stringByReplacingOccurrencesOfString:@" "withString:@""];
                NSString* removed4=[removed3 stringByReplacingOccurrencesOfString:@"("withString:@""];
                NSString* removed5=[removed4 stringByReplacingOccurrencesOfString:@"+"withString:@""];
                NSMutableDictionary * contantDic = [[NSMutableDictionary alloc] init];
                if ([name length]==0)
                {
                    [contantDic setValue:@"No name" forKey:@"name"];
                }
                else
                {
                    [contantDic setValue:name forKey:@"name"];
                }
                [contantDic setValue:removed5 forKey:@"phoneno"];
                [contantDic setValue:@"NO" forKey:@"isselected"];
                NSData *contactImageData = (__bridge NSData *)ABPersonCopyImageDataWithFormat(thisPerson, kABPersonImageFormatThumbnail);
                if (contactImageData!=nil)
                {
                    [contantDic setObject:contactImageData forKey:@"image"];
                }else{
                    [contantDic setObject:@"" forKey:@"image"];
                }
                [newContactArray addObject:contantDic];
            }
        }
    }
    CFRelease(addressBook);
    return newContactArray;
}

- (void)viewDidUnload {
    [self setTblContentList:nil];
    [self setSearchBar:nil];
    [self setSearchBarController:nil];
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
    // Return YES for supported orientations
    return (interfaceOrientation != UIInterfaceOrientationPortraitUpsideDown);
}





-(void)setContacts
{

    contentList = [self getContacts];
    //    NSSortDescriptor *contactSortDiscriptor = [[NSSortDescriptor alloc] initWithKey:@"name" ascending:YES];
    //    [addressbookConacts sortUsingDescriptors:[NSArray arrayWithObject:contactSortDiscriptor]];
    //    //NSLog(@"addressbookConacts:--->%@", addressbookConacts);
    //    newContactList = [[NSMutableDictionary alloc]init];
    //
    //    ary_ContactListIndexTitles = @[@"A", @"B", @"C", @"D", @"E", @"F", @"G", @"H", @"I", @"J", @"K", @"L", @"M", @"N", @"O", @"P", @"Q", @"R", @"S", @"T", @"U", @"V", @"W", @"X", @"Y", @"Z"];
    //    ///NSLog(@"animalIndexTitles :-->%@", ary_ContactListIndexTitles);
    //    NSPredicate *namesBeginningWithLetterPredicate = [NSPredicate predicateWithFormat:@"(name BEGINSWITH[cd] $letter)"];
    //
    //    for (int i = 0; i < ary_ContactListIndexTitles.count; i++) {
    //        NSString *keyValueForSort = [NSString stringWithFormat:@"%@", [ary_ContactListIndexTitles objectAtIndex:i]];
    //        if ([addressbookConacts filteredArrayUsingPredicate:[namesBeginningWithLetterPredicate predicateWithSubstitutionVariables:@{@"letter": keyValueForSort}]].count) {
    //            [newContactList setObject:[addressbookConacts filteredArrayUsingPredicate:[namesBeginningWithLetterPredicate predicateWithSubstitutionVariables:@{@"letter": keyValueForSort}]] forKey:keyValueForSort];
    //        }
    //
    //    }
    //    ary_ContactListSectionTitles = [[newContactList allKeys] sortedArrayUsingSelector:@selector(localizedCaseInsensitiveCompare:)];
    
}
#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    
    // Return the number of sections.
    return 1;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 70.0;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    // Return the number of rows in the section.
    if (isSearching) {
        return [filteredContentList count];
    }
    else {
        return [contentList count];
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    
    static NSString *CellIdentifier = @"Cell";
    
    MateTableViewCell *cell = (MateTableViewCell *)[tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    
    // If there is no cell to reuse, create a new one
    if(cell == nil)
    {
        cell = [[MateTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
        cell.inviteButton.tag =indexPath.row;
    }
    if (isSearching) {
        cell.userTitle.text =  [[filteredContentList objectAtIndex:indexPath.row] valueForKey:@"name"];;
        cell.phoneNo.text =  [[filteredContentList objectAtIndex:indexPath.row] valueForKey:@"phoneno"];;
        NSLog(@"userName : %@   --- %lu",[[filteredContentList objectAtIndex:indexPath.row] valueForKey:@"name"], (unsigned long)[filteredContentList count]);
    }
    else {
        cell.userTitle.text =  [[contentList objectAtIndex:indexPath.row] valueForKey:@"name"];;
        cell.phoneNo.text =  [[contentList objectAtIndex:indexPath.row] valueForKey:@"phoneno"];;
        
        
    }
    // Configure the cell before it is displayed...
    [cell.inviteButton addTarget:self
                          action:@selector(inviteButton:)
                forControlEvents:UIControlEventTouchUpInside];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;
    
}
-(void)inviteButton:(UIButton *)button
{
    NSString *userName;
    NSString *phoneNo;
    if (isSearching) {
        userName =  [[filteredContentList objectAtIndex:button.tag] valueForKey:@"name"];;
        phoneNo =  [[filteredContentList objectAtIndex:button.tag] valueForKey:@"phoneno"];;
     
    }
    else {
        userName =  [[contentList objectAtIndex:button.tag] valueForKey:@"name"];;
        phoneNo =  [[contentList objectAtIndex:button.tag] valueForKey:@"phoneno"];;        
    }

    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    hud.mode = MBProgressHUDModeIndeterminate;
    hud.labelText = @"Loading";
    
    [self.view addSubview:hud];
    [self.view setUserInteractionEnabled:NO];
    
    NSURL *url = [NSURL URLWithString:@"http://www.creativelabinteractive.com/woke/api/index.php?route=account/invitetoapp"];
    AFHTTPClient *httpClient = [[AFHTTPClient alloc] initWithBaseURL:url];
    appdelegateObj = (AppDelegate*)[[UIApplication sharedApplication]delegate];
    NSDictionary *params = [NSDictionary dictionaryWithObjectsAndKeys:
                            API_KEY,@"client_key",
                            userName, @"invitedUserName",
                            @"1", @"user_id",
                              phoneNo, @"mobile",
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

- (void)searchTableList {
    NSString *searchString = searchBar.text;
    
    for (NSDictionary *tempDict in contentList) {
        
        NSString *tempStr =  [tempDict valueForKey:@"name"];;

        NSComparisonResult result = [tempStr compare:searchString options:(NSCaseInsensitiveSearch|NSDiacriticInsensitiveSearch) range:NSMakeRange(0, [searchString length])];
        if (result == NSOrderedSame) {
            [filteredContentList addObject:tempDict];
        }
    }
}

#pragma mark - Search Implementation

- (void)searchBarTextDidBeginEditing:(UISearchBar *)searchBar {
    isSearching = YES;
}

- (void)searchBar:(UISearchBar *)searchBar textDidChange:(NSString *)searchText {
    NSLog(@"Text change - %d",isSearching);
    
    //Remove all objects first.
    [filteredContentList removeAllObjects];
    
    if([searchText length] != 0) {
        isSearching = YES;
        [self searchTableList];
    }
    else {
        isSearching = NO;
    }
    [self.tblContentList reloadData];
}

- (void)searchBarCancelButtonClicked:(UISearchBar *)searchBar {
    NSLog(@"Cancel clicked");
}

- (void)searchBarSearchButtonClicked:(UISearchBar *)searchBar {
    NSLog(@"Search Clicked");
    [self searchTableList];
}

@end
