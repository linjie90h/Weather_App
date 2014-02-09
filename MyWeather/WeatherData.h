//
//  WeatherData.h
//  MyWeather
//
//  Created by 林 杰 on 14-1-18.
//  Copyright (c) 2014年 林 杰. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface WeatherForecast : NSObject<NSCoding>


@property (nonatomic,strong) NSString *weatherState;

@property (nonatomic,strong) NSString *highWeather;

@property (nonatomic,strong) NSString *lowWeather;

@property (nonatomic,strong) NSString *currentWeather;

@property (nonatomic,strong) NSString *dayOfTheWeek;

@property (nonatomic, strong) NSString *country;

@property (nonatomic,strong) NSString *state;

@end

@interface WeatherData : NSObject<NSCoding>



@property (nonatomic,strong) NSMutableArray *futuureWeather;

@property (nonatomic,strong) WeatherForecast *currentWeather;
@property (nonatomic,strong) CLPlacemark *placemark;


@end
