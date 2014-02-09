//
//  MainViewController.h
//  MyWeather
//
//  Created by 林 杰 on 14-1-8.
//  Copyright (c) 2014年 林 杰. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "WeatherScrollView.h"
#import "SetViewController.h"
#import "AddLocationViewController.h"
#import "WeatherDataDownloader.h"
#import "WeatherView.h"

@interface MainViewController : UIViewController<UIScrollViewDelegate,SetViewControllerDelegate,CLLocationManagerDelegate,WeatherDataDownloaderDelegate>
{
    UIImageView          *_blurredOverlayView;
    CLLocationManager *weatherLocationManager;
    CLLocation *currLocation;
    
    
}

//可以滑动ScrollView
@property (nonatomic,strong) WeatherScrollView *weatherScrollView;

//分页控制
@property (nonatomic,strong) UIPageControl *pageControl;

//天气显示视图
@property (nonatomic,strong) WeatherView *weatherView;

//设置按钮
@property (nonatomic,strong) UIButton *setBar;

//添加按钮
@property (nonatomic,strong) UIButton *addBar;

@property (nonatomic, strong) SetViewController *setViewController;

@property (nonatomic,strong) AddLocationViewController *addlocationViewController;

@end
