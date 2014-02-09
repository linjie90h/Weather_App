//
//  AddLocationViewController.h
//  MyWeather
//
//  Created by 林 杰 on 14-1-22.
//  Copyright (c) 2014年 林 杰. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol AddLocationViewControllerDelegate <NSObject>

- (void)dismissAddLocationViewController;

@end
@interface AddLocationViewController : UIViewController<UISearchBarDelegate,UISearchDisplayDelegate,UITableViewDataSource,UITableViewDelegate>
{
    CLGeocoder *geocoder;
    UINavigationBar *navigationBar;
    UIBarButtonItem *doneBar;
    UISearchDisplayController *searchDisplayController;
    UISearchBar *searchBar;
}

@property (nonatomic,strong) NSMutableArray *searchData;
@property (nonatomic,strong) id<AddLocationViewControllerDelegate> delegate;
@end

