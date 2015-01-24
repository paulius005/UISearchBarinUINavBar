//
//  PDSearchExampleTableViewController.m
//  UISearchBarInUINavBar
//
//  Created by PAULIUS DRAGUNAS on 1/23/15.
//  Copyright (c) 2015 PauliusDragunas. All rights reserved.
//

#import "PDSearchExampleTableViewController.h"

@interface PDSearchExampleTableViewController () <UISearchDisplayDelegate, UISearchBarDelegate>

@end

@implementation PDSearchExampleTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    _searchBar.delegate = self;
    _sampleDataArray = [[NSMutableArray alloc] init];
    _filteredSampleDataArray = [[NSMutableArray alloc] init];
    [_sampleDataArray addObject:@"a"];
    [_sampleDataArray addObject:@"ab"];
    [_sampleDataArray addObject:@"abc"];
    [_sampleDataArray addObject:@"abcd"];
    [_sampleDataArray addObject:@"abcde"];
    [_sampleDataArray addObject:@"abcdef"];
    [_sampleDataArray addObject:@"abcdefg"];
    [_sampleDataArray addObject:@"abcdefgh"];
    [_sampleDataArray addObject:@"abcdefghi"];
    [_sampleDataArray addObject:@"abcdefghij"];
    [_sampleDataArray addObject:@"abcdefghijk"];
    [_sampleDataArray addObject:@"abcdefghijkl"];
    [_sampleDataArray addObject:@"abcdefghijklm"];
    [_sampleDataArray addObject:@"abcdefghijklmn"];
    [_sampleDataArray addObject:@"abcdefghijklmno"];
    [_sampleDataArray addObject:@"abcdefghijklmnop"];
    [_sampleDataArray addObject:@"Lorem"];
    [_sampleDataArray addObject:@"Ipsum"];

    
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
     [self.tableView reloadData];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    // Return the number of rows in the section.
    if (searching) {
        return [_filteredSampleDataArray count];
    } else {
        return [_sampleDataArray count];
    }
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"sampleSearchCell" forIndexPath:indexPath];
    
    
    if (searching) {
        cell.textLabel.text = [_filteredSampleDataArray objectAtIndex:indexPath.row];
    } else {
        cell.textLabel.text = [_sampleDataArray objectAtIndex:indexPath.row];
    }
    
    return cell;
}

- (IBAction)searchButtonClicked:(id)sender {
    self.navigationItem.rightBarButtonItem = nil;
    _searchBar = [[UISearchBar alloc] init];
    _searchBar.delegate = self;
    _searchBar.placeholder = @"Search Sample Data";
    [_searchBar sizeToFit];
    self.navigationItem.titleView = _searchBar;
    [_searchBar becomeFirstResponder];
    [_searchBar.window makeKeyAndVisible];
}

- (void)searchBarTextDidBeginEditing:(UISearchBar *)searchBar {
    [_searchBar setShowsCancelButton:YES animated:YES];
}

- (void)searchBarTextDidEndEditing:(UISearchBar *)searchBar {
    
}

- (void)searchBarCancelButtonClicked:(UISearchBar *)searchBar {
    searching = NO;
    [self.tableView reloadData];
    self.navigationItem.titleView = nil;
    UIBarButtonItem *rightBarButton = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemSearch target:self action:@selector(searchButtonClicked:)];
    [_searchBar setShowsCancelButton:NO];
    [_searchBar resignFirstResponder];
    self.navigationItem.rightBarButtonItem = rightBarButton;
}

- (void)searchBar:(UISearchBar *)searchBar textDidChange:(NSString *)searchText {
    [_filteredSampleDataArray removeAllObjects];
    
    if ([searchText length] != 0) {
        searching = YES;
        [self searchData];
    } else {
        searching = NO;
    }
    
    [self.tableView reloadData];
}

- (void)searchData {
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"SELF contains[c] %@", _searchBar.text];
    NSArray *tempArray = [_sampleDataArray filteredArrayUsingPredicate:predicate];
    NSLog(@"%@", tempArray);
    _filteredSampleDataArray = [NSMutableArray arrayWithArray:tempArray];
}

/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    } else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath {
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
