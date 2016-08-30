//
//  CoachList.m
//  EmployeeAssistant
//
//  Created by 武淅 段 on 16/8/30.
//  Copyright © 2016年 xxkuaipao. All rights reserved.
//

#import "CoachList.h"

@implementation CoachList

+ (NSDictionary *)JSONMap
{
    static NSDictionary *config;
    if ( !config ){
        config = @{@"coach" : @"coachList"};
    }
    return config;
}

+ (NSDictionary *)arrayElementMap
{
    static NSDictionary *config;
    if ( !config ){
        config = @{@"coach" : @"Coach"};
    }
    return config;
}

@end


@implementation Coach

+ (NSDictionary *)JSONMap
{
    static NSDictionary *config;
    if ( !config ){
        config = @{@"id" : @"identifier",
                   @"name" : @"name",
                   @"img_url" : @"imgUrl"};
    }
    return config;
}

@end
