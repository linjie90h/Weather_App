//
//  SetViewController.h
//  MyWeather
//
//  Created by 林 杰 on 14-1-9.
//  Copyright (c) 2014年 林 杰. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol SetViewControllerDelegate <NSObject>

//设置代理消隐掉设置，返回主界面 由次界面声明代理，主界面界面调用
- (void)dismissSettingsViewController;

@end
@interface SetViewController : UIViewController

@property (nonatomic,strong) UINavigationBar *setNavigationBar;

@property (nonatomic,strong) UIBarButtonItem *DoneBar;

@property (weak,nonatomic) id<SetViewControllerDelegate> delegate;
@end
