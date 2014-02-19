//
//  MainViewController.m
//  MyWeather
//
//  Created by 林 杰 on 14-1-8.
//  Copyright (c) 2014年 林 杰. All rights reserved.
//

#import "MainViewController.h"
#import "UIImage+ImageEffects.h"
#import "UIView+Screenshot.h"
#import "WeatherData.h"

@interface MainViewController ()

@end

@implementation MainViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        
        self.modalPresentationStyle = UIModalPresentationCurrentContext;
//        self.modalPresentationStyle = UIModalPresentationFormSheet;
        self.modalTransitionStyle = UIModalTransitionStyleCoverVertical;
        [self _initViewController];
        [self _initPageView];
        [self _initWeatherView];
        [self _initSettingBar];
        [self _initAddBar];
        
        
        //必须把模糊的放在所有view的前面
        [self.view bringSubviewToFront:_blurredOverlayView];
    }
    return self;
}

-(void) _initViewController
{
    _setViewController = [[SetViewController alloc] initWithNibName:Nil bundle:Nil];
    _setViewController.delegate = self;
    
    _addlocationViewController = [[AddLocationViewController alloc] initWithNibName:Nil bundle:Nil];
    _addlocationViewController.delegate = self;
    
}
-(void) _initPageView
{
    _weatherScrollView = [[WeatherScrollView alloc] initWithFrame:[UIScreen mainScreen].bounds];
    _weatherScrollView.delegate = self;
    [self.view addSubview:self.weatherScrollView];
    
    _pageControl = [[UIPageControl alloc] initWithFrame:CGRectMake(0, self.view.bounds.size.height-32, self.view.bounds.size.width,32)];
    [_pageControl setHidesForSinglePage:YES];
    [self.view addSubview:self.pageControl];
    
    _blurredOverlayView = [[UIImageView alloc] initWithImage:[[UIImage alloc] init]];
    [_blurredOverlayView setFrame:self.view.bounds];
    [self.view addSubview:_blurredOverlayView];
    
    
}

-(void) _initWeatherView
{
    _weatherView = [[WeatherView alloc] initWithFrame:[UIScreen mainScreen].bounds];
    _weatherView.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"gradient0.png"]];
//    _weatherScrollView.delegate = self;
    _weatherView.tag = 1;
    [self.weatherScrollView addSubview:self.weatherView];
    self.pageControl.numberOfPages += 1;
}

-(void) _initSettingBar
{
    _setBar = [UIButton buttonWithType:UIButtonTypeInfoLight];
    [_setBar setFrame:CGRectMake(4, self.view.bounds.size.height-44, 44, 44)];
    [_setBar setTintColor:[UIColor whiteColor]];
    [_setBar setShowsTouchWhenHighlighted:YES];
    [_setBar addTarget:self action:@selector(touchSetBar) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:self.setBar];
    
}

-(void)_initAddBar
{
    _addBar = [UIButton buttonWithType:UIButtonTypeCustom];
    [_addBar setFrame:CGRectMake(self.view.bounds.size.width-48, self.view.bounds.size.height-44, 44, 44)];
    UILabel *addTitle = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 44 , 44)];
    [addTitle setText:@"+"];
    [addTitle setFont:[UIFont systemFontOfSize:35.0]];
    [addTitle setTextColor:[UIColor whiteColor]];
    [addTitle setTextAlignment:NSTextAlignmentCenter];
    [self.addBar addSubview:addTitle];
    [_addBar setTintColor:[UIColor whiteColor]];
    [_addBar setShowsTouchWhenHighlighted:YES];
    [_addBar addTarget:self action:@selector(touchAddBar) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:self.addBar];
}

#pragma mark -----actionButton
-(void) touchSetBar
{
    [self showBlurredOverlayView:YES];
    [self presentViewController:self.setViewController animated:YES completion:nil];
}

-(void) touchAddBar
{
    [self showBlurredOverlayView:YES];
    
    [self presentViewController:self.addlocationViewController animated:YES completion:nil];
}


#pragma mark Using a SOLMainViewController

- (void)showBlurredOverlayView:(BOOL)show
{
    if(show) {
        UIImage *screenshot = [self.view screenshot];
        
        UIImage *blurredScreenshot = [screenshot applyBlurWithRadius:10.0
                                                           tintColor:[UIColor colorWithWhite:0.0 alpha:0.25]
                                               saturationDeltaFactor:1.0
                                                           maskImage:nil];
        [_blurredOverlayView setImage:blurredScreenshot];
    }
    
    [UIView animateWithDuration:0.1 animations: ^ {
        _blurredOverlayView.alpha = (show)? 1.0: 0.0;}];
}

#pragma mark --locationManagerDelegate
- (void)locationManager:(CLLocationManager *)manager
	 didUpdateLocations:(NSArray *)locations
{
    currLocation = [locations lastObject];
    WeatherDataDownloader *weatherDownloader = [[WeatherDataDownloader alloc] init];
    weatherDownloader.delegate = self;
    if (!self.weatherView.hasData) {
        [weatherDownloader requestData:currLocation withtag:1];
    }
    
}

- (void)locationManager:(CLLocationManager *)manager didFailWithError:(NSError *)error

{
    
    NSLog(@"error: %@",error);
    
}
#pragma mark ---WeatherDataDownloaderDelegate
-(void)didDownloader:(WeatherData *) data withtag:(NSInteger)tag
{
    
    for (WeatherView *weatherView in self.weatherScrollView.subviews) {
        if (weatherView.tag == tag) {
            [self loadData:data withView:weatherView];
        }
    }
   
}

#pragma mark UIScrollViewDelegate Methods

- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate
{
//    self->_isScrolling = NO;
}

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
//    self->_isScrolling = NO;
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
//    self->_isScrolling = YES;
    
    /// Update the current page for the page control
    float fractionalPage = _weatherScrollView.contentOffset.x / _weatherScrollView.frame.size.width;
    _pageControl.currentPage = lround(fractionalPage);
}

#pragma mark --SetViewControllerDelegate
- (void)dismissSettingsViewController
{
    [self showBlurredOverlayView:NO];
    [self dismissViewControllerAnimated:YES completion:nil];
}

#pragma  mark --AddLocationViewControlerDelegate
- (void) didAddLocationView:(CLPlacemark *)placemark
{
    WeatherView *locationWeatherView = [[WeatherView alloc] initWithFrame:[UIScreen mainScreen].bounds];
    
    int value = (arc4random()%9)+1 ;
    NSString *gradientImageName = [NSString stringWithFormat:@"gradient%d.png",value];
    locationWeatherView.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:gradientImageName]];
    self.pageControl.numberOfPages += 1;
    locationWeatherView.tag = self.pageControl.numberOfPages+10;
    [self.weatherScrollView addSubview:locationWeatherView];
    
    
    
    WeatherDataDownloader *weatherDownloader = [[WeatherDataDownloader alloc] init];
    weatherDownloader.delegate = self;
    if (!locationWeatherView.hasData) {
        [weatherDownloader requestData:placemark.location withtag:locationWeatherView.tag];
    }

    
}

- (void)dismissAddLocationViewController
{
    [self showBlurredOverlayView:NO];
    [self dismissViewControllerAnimated:YES completion:nil];
}
- (void)viewDidLoad
{
    [super viewDidLoad];
	
    weatherLocationManager = [[CLLocationManager alloc] init];
    
    weatherLocationManager.delegate = self;
    
    weatherLocationManager.desiredAccuracy = kCLLocationAccuracyNearestTenMeters;
    weatherLocationManager.distanceFilter = 3000.0f;
}

-(void) viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    [weatherLocationManager startUpdatingLocation];
}
-(void) viewDidDisappear:(BOOL)animated
{
    [super viewDidDisappear:animated];
    [weatherLocationManager stopUpdatingLocation];
}
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)loadData:(WeatherData *)data withView:(WeatherView*)weatherView
{
 
    weatherView.hasData = YES;
    NSString *weatherStateName = [NSString stringWithString:data.currentWeather.weatherState];
    NSString *highAndlowweather = [NSString stringWithFormat:@"H:%@ L:%@",data.currentWeather.highWeather, data.currentWeather.lowWeather];
    //天气图片
    weatherView.weatherState.image = [UIImage imageNamed:weatherStateName];
    //当前天气
    weatherView.currentWeather.text = data.currentWeather.currentWeather;
    //当前天气状态
    weatherView.currentWeatherState.text = data.currentWeather.weatherState;
    //当前最高气温
    weatherView.highAndlowWeather.text = highAndlowweather;
    
    NSString *country = data.placemark.country;
    NSString *state = data.placemark.locality;
    NSString *subLocality = data.placemark.subLocality;
    weatherView.subLocality.text = subLocality;
    NSString *countryAndState = [NSString stringWithFormat:@"%@,%@", country,state];
    weatherView.countryAndstate.text = countryAndState;
    
    WeatherForecast *forecastOneDay =[data.futuureWeather objectAtIndex:0];
   weatherView.dateOfWeakOne.text = forecastOneDay.dayOfTheWeek;
    
    WeatherForecast *forecastTwoDay =[data.futuureWeather objectAtIndex:1];
    weatherView.dateOfWeakTwo.text = forecastTwoDay.dayOfTheWeek;
    
    WeatherForecast *forecastThreeDay =[data.futuureWeather objectAtIndex:2];
    weatherView.dateOfWeakThree.text = forecastThreeDay.dayOfTheWeek;
    
    
    NSString *forecastWeatherSateName = [NSString stringWithString:forecastOneDay.weatherState];
    [weatherView.weatherStateButtonOne setBackgroundImage:[UIImage imageNamed:forecastWeatherSateName] forState:UIControlStateNormal];
    
    //随机展示背景图片
    int value = (arc4random()%9)+1 ;
    NSString *gradientImageName = [NSString stringWithFormat:@"gradient%d.png",value];
    weatherView.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:gradientImageName]];
}


- (BOOL)shouldAutorotate
{
    return NO;
}

@end
