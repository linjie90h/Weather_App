//
//  WeatherDataDownloader.m
//  MyWeather
//
//  Created by 林 杰 on 14-1-14.
//  Copyright (c) 2014年 林 杰. All rights reserved.
//

#import "WeatherDataDownloader.h"
#import "WeatherData.h"
#import "NSString+weatherStringChange.h"

@implementation WeatherDataDownloader


#define kAPI_KEY @"7b9a623f90b27887"



-(instancetype) init
{
    self = [super init];
    if (self) {
        _geocoder = [[CLGeocoder alloc] init];
    }
    return self;
}
-(WeatherData *)parseData:(id)Data
{
    NSDictionary *allDataDic = (NSDictionary *)Data;
    NSArray *currentObservation = [allDataDic objectForKey:@"current_observation"];
    NSArray *forecast = [allDataDic objectForKey:@"forecast"];
    NSArray *simpleforecast= [forecast valueForKey:@"simpleforecast"];
    NSArray *forecastday = [simpleforecast valueForKey:@"forecastday"];
    
    NSArray *forecastday0 = [forecastday objectAtIndex:0];
    NSArray *forecastday1 = [forecastday objectAtIndex:1];
    NSArray *forecastday2 = [forecastday objectAtIndex:2];
    NSArray *forecastday3 = [forecastday objectAtIndex:3];
    
    WeatherData *data = [[WeatherData alloc] init];
    //最高和最低气温
    NSString *currenthighWeather = [[forecastday0 valueForKey:@"high"] valueForKey:@"celsius"];
    data.currentWeather.highWeather = currenthighWeather;
    
    NSString *currentlowWeather = [[forecastday0 valueForKey:@"low"] valueForKey:@"celsius"];
    data.currentWeather.lowWeather = currentlowWeather;
    
    //当前的气温
    GLfloat todatWeather = ceilf([[currentObservation valueForKey:@"temp_c"] doubleValue]) ;
    NSString *todayWeatherStr = [NSString stringWithFormat:@"%.0f℃",todatWeather];
    data.currentWeather.currentWeather = todayWeatherStr;
    
    //天气状态，晴 雨 阴
    data.currentWeather.weatherState = [currentObservation valueForKey:@"weather"];
    
    //国家和地区
    data.currentWeather.country = [[currentObservation valueForKey:@"display_location"]valueForKey:@"state_name"];
    
    data.currentWeather.state = [[currentObservation valueForKey:@"display_location"] valueForKey:@"city"];;
    
    //预测第二天天气情况
    WeatherForecast *forecastOneDay = [[WeatherForecast alloc] init];
    forecastOneDay.dayOfTheWeek = [[forecastday1 valueForKey:@"date"] valueForKey:@"weekday_short"];
    forecastOneDay.weatherState = [self compare:[forecastday1 valueForKey:@"conditions"]];
    forecastOneDay.highWeather = [[forecastday1 valueForKey:@"high"] valueForKey:@"celsius"];
    forecastOneDay.highWeather = [[forecastday1 valueForKey:@"low"] valueForKey:@"celsius"];
    
    [data.futuureWeather addObject:forecastOneDay];

    WeatherForecast *forecastTwoDay = [[WeatherForecast alloc] init];
    forecastTwoDay.dayOfTheWeek = [[forecastday2 valueForKey:@"date"] valueForKey:@"weekday_short"];
    forecastTwoDay.highWeather = [[forecastday2 valueForKey:@"high"] valueForKey:@"celsius"];
    forecastTwoDay.highWeather = [[forecastday2 valueForKey:@"low"] valueForKey:@"celsius"];
    [data.futuureWeather addObject:forecastTwoDay];
    
    WeatherForecast *forecastThreeDay = [[WeatherForecast alloc] init];
    forecastThreeDay.dayOfTheWeek = [[forecastday3 valueForKey:@"date"] valueForKey:@"weekday_short"];
    forecastThreeDay.highWeather = [[forecastday3 valueForKey:@"high"] valueForKey:@"celsius"];
    forecastThreeDay.highWeather = [[forecastday3 valueForKey:@"low"] valueForKey:@"celsius"];
    [data.futuureWeather addObject:forecastThreeDay];
    
//    forecastOneDay.currentWeather = [forecastday1 valueForKey:<#(NSString *)#>]
    
    return data;
}

-(void) requestData:(CLLocation *)location withtag:(NSInteger)tag
{
    NSString *baseUrl = @"http://api.wunderground.com/api/";
    NSString *latlngString = [NSString stringWithFormat:@"%3f,%3f",location.coordinate.latitude,location.coordinate.longitude];
    NSString *allUrl = [NSString stringWithFormat:@"%@%@/forecast/conditions/q/%@.json",baseUrl,kAPI_KEY,latlngString];
    NSURL *url = [NSURL URLWithString:allUrl];
    
    //JSON请求方式······················································
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    [manager GET:allUrl parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
        WeatherData *data  = [[WeatherData alloc] init];
        data = [self parseData:responseObject];
        
        [_geocoder reverseGeocodeLocation:location completionHandler:^(NSArray *placemarks, NSError *error) {
            
                data.placemark = [placemarks lastObject];
       
            
            [self.delegate didDownloader:data withtag:tag];
        
        }];
        
        
    }
         failure:^(AFHTTPRequestOperation *operation, NSError *error) {
             NSLog(@"ERROR:%@",error);
         }];
    
    
    //XML请求方式························································
//    NSURLRequest *request = [NSURLRequest requestWithURL:url];
//    AFHTTPRequestOperation *op = [[AFHTTPRequestOperation alloc] initWithRequest:request];
//    op.responseSerializer = [AFXMLParserResponseSerializer serializer];
//    [op setCompletionBlockWithSuccess:^(AFHTTPRequestOperation *operation, id responseObject) {
//        NSLog(@"JSON: %@", responseObject);
//        NSXMLParser *xmlParser = responseObject;
//        xmlParser.delegate = self;
//        [xmlParser parse];
//
//    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
//        NSLog(@"Error: %@", error);
//    }];
//    [[NSOperationQueue mainQueue] addOperation:op];
    
    
    
}

-(NSString *)compare:(NSString *)string
{
    NSString *weatherStateName = @"Clear";
    if ([string findTheSame:@"Clear"]) {
        weatherStateName = @"Clear";
    }
    else if ([string findTheSame:@"Cloudy"]) {
        weatherStateName = @"Cloudy";
    }
    else if ([string findTheSame:@"Rain"])
    {
        weatherStateName = @"Rain";
    }
    else if ([string findTheSame:@"Haze"])
    {
        weatherStateName = @"Haze";
    }
    else if ([string findTheSame:@"Overcast"])
    {
        weatherStateName = @"Overcast";
    }
    return weatherStateName;
}

@end
