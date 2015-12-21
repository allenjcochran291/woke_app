//
//  ViewController.h
//  TableSearch
//
//  Created by Jobin Kurian on 10/02/12.
//  Copyright (c) 2012 Fafadia Tech, Mumbai. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AppDelegate.h"
@interface WOMatesViewController : UIViewController <UITableViewDelegate, UITableViewDataSource> {
    
    NSMutableArray *contentList;
    NSMutableArray *categList;
    UIPickerView *pickerView;
    NSMutableArray *filteredContentList;
    BOOL isSearching;
    AppDelegate* appdelegateObj;
    NSString *categId;
    NSString *mateUserId;

}
@property (strong, nonatomic) NSMutableArray *filteredContentList;
@property (strong, nonatomic) UIPickerView *pickerView;

@property (strong, nonatomic) IBOutlet UITableView *tblContentList;
@property (strong, nonatomic) IBOutlet UISearchBar *searchBar;
@property (weak, nonatomic) IBOutlet UISegmentedControl *segment;

@property (strong, nonatomic)NSDictionary* matesDict;
@property (strong, nonatomic) IBOutlet UISearchDisplayController *searchBarController;

@end