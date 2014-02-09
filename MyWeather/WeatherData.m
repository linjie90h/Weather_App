//
//  WeatherData.m
//  MyWeather
//
//  Created by 林 杰 on 14-1-18.
//  Copyright (c) 2014年 林 杰. All rights reserved.
//

#import "WeatherData.h"


@implementation WeatherForecast

- (void)encodeWithCoder:(NSCoder *)aCoder
{
    
}
- (id)initWithCoder:(NSCoder *)aDecoder
{
    
    return self;
}
@end

@implementation WeatherData

-(id)init
{
    self = [super init];
    if (self) {
        self.currentWeather = [[WeatherForecast alloc] init];
        self.futuureWeather = [[NSMutableArray alloc] initWithCapacity:3];
    }
    return self;
}
- (void)encodeWithCoder:(NSCoder *)aCoder
{

}
- (id)initWithCoder:(NSCoder *)aDecoder
{

    return self;
}

@end
