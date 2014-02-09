//
//  WeatherView.m
//  MyWeather
//
//  Created by 林 杰 on 14-1-19.
//  Copyright (c) 2014年 林 杰. All rights reserved.
//

#import "WeatherView.h"

@implementation WeatherView

#define colourViewWidth @"colourBarView.bounds.size.width";
#define colourViewHeight @"colourBarView.bounds.size.width";
- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
        //白色透明的VIew条
        colourBarView = [[UIView alloc] initWithFrame:CGRectMake(0, 0.6*self.bounds.size.height, self.bounds.size.width, 80)];
        colourBarView.backgroundColor = [UIColor colorWithWhite:1.0 alpha:0.4];
        [self addSubview:colourBarView];
        
        //预测第二天天气情况布局（星期几）
        _dateOfWeakOne = [[UILabel alloc] initWithFrame:CGRectMake(105, 0, 70, 40)];
        _dateOfWeakOne.backgroundColor = [UIColor clearColor];
        [_dateOfWeakOne setTextAlignment:NSTextAlignmentCenter];
        [_dateOfWeakOne  setFont:[UIFont systemFontOfSize:20.0]];
        [_dateOfWeakOne setTextColor:[UIColor colorWithWhite:1.0 alpha:1.0]];
        [colourBarView addSubview:_dateOfWeakOne];
        
        _dateOfWeakTwo = [[UILabel alloc] initWithFrame:CGRectMake(175, 0, 70, 40)];
        _dateOfWeakTwo.backgroundColor = [UIColor clearColor];
        [_dateOfWeakTwo setTextAlignment:NSTextAlignmentCenter];
        [_dateOfWeakTwo  setFont:[UIFont systemFontOfSize:20.0]];
        [_dateOfWeakTwo setTextColor:[UIColor colorWithWhite:1.0 alpha:1.0]];
        [colourBarView addSubview:_dateOfWeakTwo];
        
        _dateOfWeakThree = [[UILabel alloc] initWithFrame:CGRectMake(245, 0, 70, 40)];
        _dateOfWeakThree.backgroundColor = [UIColor clearColor];
        [_dateOfWeakThree setTextAlignment:NSTextAlignmentCenter];
        [_dateOfWeakThree  setFont:[UIFont systemFontOfSize:20.0]];
        [_dateOfWeakThree setTextColor:[UIColor colorWithWhite:1.0 alpha:1.0]];
        [colourBarView addSubview:_dateOfWeakThree];
        
        [self forecastDayWeatherState];
        //天气图标
        _weatherState = [[UIImageView alloc] initWithFrame:CGRectMake(self.bounds.size.width/2-50, 100, 100, 100)];
        _weatherState.backgroundColor = [UIColor clearColor];
        
        [self addSubview:_weatherState];
        
        //天气状态
        _currentWeatherState = [[UILabel alloc] initWithFrame:CGRectMake(self.bounds.size.width/2-75, 200, 150, 50)];
        _currentWeatherState.backgroundColor = [UIColor clearColor];
        [_currentWeatherState setTextAlignment:NSTextAlignmentCenter];
        [_currentWeatherState setFont:[UIFont systemFontOfSize:34.0]];
        _currentWeatherState.textColor = [UIColor colorWithWhite:1.0 alpha:1.0];
        [self addSubview:_currentWeatherState];
        
        //当前气温
        _currentWeather = [[UILabel alloc] initWithFrame:CGRectMake(5,0,100,50)];
        [_currentWeather setTextAlignment:NSTextAlignmentCenter];
        _currentWeather.backgroundColor = [UIColor clearColor];
        [_currentWeather setFont:[UIFont systemFontOfSize:40.0]];
        _currentWeather.textColor = [UIColor colorWithWhite:1.0 alpha:1.0];
        [colourBarView addSubview:_currentWeather];
        
        //预计当前最高温和最低温
        _highAndlowWeather = [[UILabel alloc] initWithFrame:CGRectMake(0,50,100,30)];
        [_highAndlowWeather  setTextAlignment:NSTextAlignmentCenter];
        _highAndlowWeather .backgroundColor = [UIColor clearColor];
        [_highAndlowWeather  setFont:[UIFont systemFontOfSize:20.0]];
        _highAndlowWeather .textColor = [UIColor colorWithWhite:1.0 alpha:1.0];
        [colourBarView addSubview:_highAndlowWeather ];
        
        //所在地名称
        _subLocality = [[UILabel alloc] initWithFrame:CGRectMake(self.bounds.size.width/2-75, 40, 150, 50)];
        [_subLocality  setTextAlignment:NSTextAlignmentCenter];
        _subLocality .backgroundColor = [UIColor clearColor];
        _subLocality.font = [UIFont fontWithName:@"Arial-ItalicMT" size:30];
//        [_subLocality  s    etFont:[UIFont fontWithName:@"Baskerville" size:30]];
        _subLocality .textColor = [UIColor colorWithWhite:1.0 alpha:1.0];
        [self addSubview:_subLocality];
        
        _countryAndstate = [[UILabel alloc] initWithFrame:CGRectMake(self.bounds.size.width/2-75, 245, 150, 40)];
        _countryAndstate.backgroundColor = [UIColor clearColor];
        [_countryAndstate setTextAlignment:NSTextAlignmentCenter];
        [_countryAndstate setFont:[UIFont systemFontOfSize:18.0]];
        _countryAndstate.textColor = [UIColor colorWithWhite:1.0 alpha:1.0];
        [self addSubview:_countryAndstate];
        
        
    }
    return self;
}

-(void)forecastDayWeatherState
{
    _weatherStateButtonOne = [UIButton buttonWithType:UIButtonTypeCustom];
    _weatherStateButtonTwo = [UIButton buttonWithType:UIButtonTypeCustom];
    _weatherStateButtonThree = [UIButton buttonWithType:UIButtonTypeCustom];
    _weatherStateButtonOne.frame = CGRectMake(120, 40, 40, 35);
    _weatherStateButtonTwo.frame = CGRectMake(190, 40, 40, 40);
    _weatherStateButtonThree.frame = CGRectMake(260, 40, 40, 40);
    [colourBarView addSubview:_weatherStateButtonOne];
    [colourBarView addSubview:_weatherStateButtonOne];
    [colourBarView addSubview:_weatherStateButtonOne];
}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
}
*/

@end
