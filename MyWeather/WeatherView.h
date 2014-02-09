//
//  WeatherView.h
//  MyWeather
//
//  Created by 林 杰 on 14-1-19.
//  Copyright (c) 2014年 林 杰. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface WeatherView : UIView
{
    UIView *colourBarView;
}


//当前天气气温
@property (nonatomic,strong) UILabel *currentWeather;
//当前最高温和最低温
@property (nonatomic,strong) UILabel *highAndlowWeather;
//当前天气情况
@property (nonatomic,strong) UILabel *currentWeatherState;
//所在区域，例如龙岗区
@property (nonatomic,strong) UILabel *subLocality;
//城市和国别
@property (nonatomic,strong) UILabel *countryAndstate;
//预测的第二天
@property (nonatomic,strong) UILabel *dateOfWeakOne;
//预测的第三天
@property (nonatomic,strong) UILabel *dateOfWeakTwo;
//预测的四天
@property (nonatomic,strong) UILabel *dateOfWeakThree;
//预测的那几天的最高温和最低温
@property (nonatomic,strong) UILabel *forecastDayHighAndLow;
//当前天气状况的图片展示
@property (nonatomic,strong) UIImageView *weatherState;

//预测的三天的天气图片展示
@property (nonatomic,strong) UIButton *weatherStateButtonOne;
@property (nonatomic,strong) UIImageView *weatherStateButtonTwo;
@property (nonatomic,strong) UIImageView *weatherStateButtonThree;

//是否存在数据，存在了就不必要再加载了，以为定位时候会一直调用，不加判断会影响性能
@property (nonatomic,assign) BOOL hasData;
@end
