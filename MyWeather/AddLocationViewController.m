//
//  AddLocationViewController.m
//  MyWeather
//
//  Created by 林 杰 on 14-1-22.
//  Copyright (c) 2014年 林 杰. All rights reserved.
//

#import "AddLocationViewController.h"

@interface AddLocationViewController ()

@end

@implementation AddLocationViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        self.modalTransitionStyle = UIModalTransitionStyleCrossDissolve;
        self.view.backgroundColor = [UIColor clearColor];
        self.view.opaque = NO;
        geocoder = [[CLGeocoder alloc] init];
        
        doneBar = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemDone target:self action:@selector(doneAction)];
        
        navigationBar = [[UINavigationBar alloc] initWithFrame:CGRectMake(0, 0, self.view.bounds.size.width, 64)];
        [self.view addSubview:navigationBar];
        
        searchBar = [[UISearchBar alloc] initWithFrame:CGRectMake(0, 0, self.view.bounds.size.width, 64)];
        searchBar.delegate = self;
//        searchBar.searchBarStyle = UISearchBarStyleDefault;
        searchBar.placeholder = @"Name of City";
        searchBar.autocapitalizationType = UITextAutocapitalizationTypeNone;
        
        searchDisplayController = [[UISearchDisplayController alloc] initWithSearchBar:searchBar contentsController:self];
        searchDisplayController.displaysSearchBarInNavigationBar = YES;
        searchDisplayController.delegate = self;
        searchDisplayController.searchResultsDelegate = self;
        searchDisplayController.searchResultsDataSource = self;
        searchDisplayController.navigationItem.rightBarButtonItem = doneBar;
        navigationBar.items = @[searchDisplayController.navigationItem];
        
    }
    return self;
}

#pragma mark --DoneAction
-(void)doneAction
{
    [self.delegate dismissAddLocationViewController];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    [searchDisplayController setActive:YES animated:NO];
    [searchDisplayController.searchBar becomeFirstResponder];
	// Do any additional setup after loading the view.
}
- (void) viewDidDisappear:(BOOL)animated
{
    [super viewDidDisappear:animated];
    [searchDisplayController setActive:NO animated:NO];
    [searchDisplayController.searchBar resignFirstResponder];
}
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark --TableViewDataDelegate
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [self.searchData count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *cellIdentifier = @"CellIdentifier";
//    [tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:cellIdentifier];
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier];
    if(tableView == self.searchDisplayController.searchResultsTableView) {
        cell.backgroundColor = [UIColor clearColor];
        cell.textLabel.textColor = [UIColor whiteColor];
    }
        CLPlacemark *placemark = [self.searchData objectAtIndex:indexPath.row];
        NSString *city = placemark.locality;
        NSString *country = placemark.country;
        NSString *cellText = [NSString stringWithFormat:@"%@, %@", city, country];
        if([[country lowercaseString] isEqualToString:@"united states"]) {
            NSString *state = placemark.administrativeArea;
            cellText = [NSString stringWithFormat:@"%@, %@", city, state];
        }
        cell.textLabel.text = cellText;
    }
    return cell;
}

#pragma mark
- (BOOL)searchDisplayController:(UISearchDisplayController *)controller shouldReloadTableForSearchString:(NSString *)searchString;

{
    [geocoder geocodeAddressString:searchString completionHandler:^(NSArray *placemarks, NSError *error) {
        self.searchData = [[NSMutableArray alloc] initWithCapacity:1];
//        CLPlacemark * placeMark = [placemarks objectAtIndex:0];
        for(CLPlacemark *placemark in placemarks) {
            if(placemark.locality) {
                [self.searchData addObject:placemark];
            }
        }
//        [self.searchData addObject:placeMark];
        [controller.searchResultsTableView reloadData];
    }];
    return NO;
}

- (void)searchDisplayController:(UISearchDisplayController *)controller willShowSearchResultsTableView:(UITableView *)tableView
{
    [tableView setFrame:CGRectMake(0, navigationBar.bounds.size.height, self.view.bounds.size.width,
                                   self.view.bounds.size.height - self->navigationBar.bounds.size.height)];
    tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    tableView.backgroundColor = [UIColor clearColor];
    tableView.delegate = self;
    [self.view bringSubviewToFront:self->navigationBar];
}

@end
