//
//  WeatherScrollView.m
//  MyWeather
//
//  Created by 林 杰 on 14-1-8.
//  Copyright (c) 2014年 林 杰. All rights reserved.
//

#import "WeatherScrollView.h"

@implementation WeatherScrollView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.pagingEnabled = YES;
        self.backgroundColor = [UIColor clearColor];
        self.showsHorizontalScrollIndicator = NO;
        self.showsVerticalScrollIndicator = NO;
        self.alwaysBounceHorizontal = YES;
        // Initialization code
    }
    return self;
}

#pragma mark Configuring a Paging Scroll View

- (void)addSubview:(UIView *)weatherView
{
    [super addSubview:weatherView];
    [weatherView setFrame:CGRectMake(self.bounds.size.width * (self.subviews.count - 1), 0,
                                     weatherView.bounds.size.width, weatherView.bounds.size.height)];
    [self setContentSize:CGSizeMake(self.bounds.size.width * self.subviews.count, self.contentSize.height)];

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
