//
//  SetViewController.m
//  MyWeather
//
//  Created by 林 杰 on 14-1-9.
//  Copyright (c) 2014年 林 杰. All rights reserved.
//

#import "SetViewController.h"

@interface SetViewController ()

@end

@implementation SetViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        self.modalTransitionStyle = UIModalTransitionStyleCrossDissolve;
        self.view.backgroundColor = [UIColor clearColor];
        self.view.opaque = NO;
        [self _initSetNavgationBar];
        
    }
    return self;
}

-(void) _initSetNavgationBar
{
    _setNavigationBar = [[UINavigationBar alloc] initWithFrame:CGRectMake(0,0, self.view.bounds.size.width, 64)];
    [_setNavigationBar setTranslucent:YES];
    [self.view addSubview: _setNavigationBar];
    
    _DoneBar = [[UIBarButtonItem alloc]initWithBarButtonSystemItem:UIBarButtonSystemItemDone target:self action:@selector(doneAction)];
    
    UINavigationItem *navigationItem = [[UINavigationItem alloc] initWithTitle:@"Setting"];
    navigationItem.rightBarButtonItem = _DoneBar;
    [_setNavigationBar setItems:@[navigationItem]];
    
    
}

#pragma mark -- DoneButton Action
-(void) doneAction
{
    [self.delegate dismissSettingsViewController];
}
- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
