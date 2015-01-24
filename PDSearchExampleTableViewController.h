//
//  PDSearchExampleTableViewController.h
//  UISearchBarInUINavBar
//
//  Created by PAULIUS DRAGUNAS on 1/23/15.
//  Copyright (c) 2015 PauliusDragunas. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface PDSearchExampleTableViewController : UITableViewController
{
    BOOL searching;
}

@property (strong, nonatomic) UISearchBar *searchBar;
@property (strong, nonatomic) NSMutableArray *sampleDataArray;
@property (strong, nonatomic) NSMutableArray *filteredSampleDataArray;


- (IBAction)searchButtonClicked:(id)sender;

@end
