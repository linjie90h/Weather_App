//
//  WeatherDataDownloader.h
//  MyWeather
//
//  Created by 林 杰 on 14-1-14.
//  Copyright (c) 2014年 林 杰. All rights reserved.
//

#import <Foundation/Foundation.h>

@class WeatherData;

@protocol WeatherDataDownloaderDelegate <NSObject>

-(void)didDownloader:(WeatherData *)data;

@end
@interface WeatherDataDownloader : NSObject

@property (nonatomic,strong) CLGeocoder *geocoder;

-(void)requestData:(CLLocation *)location;

@property (nonatomic,weak) id<WeatherDataDownloaderDelegate> delegate;

//-(void)parseData:(id)Data;

@end
