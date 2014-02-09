//
//  NSString+weatherStringChange.m
//  MyWeather
//
//  Created by 林 杰 on 14-1-22.
//  Copyright (c) 2014年 林 杰. All rights reserved.
//

#import "NSString+weatherStringChange.h"

@implementation NSString (weatherStringChange)

-(BOOL) findTheSame:(NSString *)string
{
    if ([self rangeOfString:string].location != NSNotFound) {
        return YES;
    }
    
    return NO;
}

@end
