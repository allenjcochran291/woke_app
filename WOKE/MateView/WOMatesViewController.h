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
    NSMutableArray *filteredContentList;
    BOOL isSearching;
    AppDelegate* appdelegateObj;

}
@property (strong, nonatomic) NSMutableArray *filteredContentList;

@property (strong, nonatomic) IBOutlet UITableView *tblContentList;
@property (strong, nonatomic) IBOutlet UISearchBar *searchBar;
@property (strong, nonatomic) IBOutlet UISearchDisplayController *searchBarController;

@end
