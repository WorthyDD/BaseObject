//
//  GymList.m
//  EmployeeAssistant
//
//  Created by 武淅 段 on 16/8/30.
//  Copyright © 2016年 xxkuaipao. All rights reserved.
//

#import "GymList.h"

@implementation GymList

+ (NSDictionary *)JSONMap
{
    static NSDictionary *config;
    if ( !config ){
        config = @{@"has_more" : @"hasMore",
                   @"next_offset" : @"offset",
                   @"gyms" : @"gyms"};
    }
    return config;
}

+ (NSDictionary *)arrayElementMap
{
    static NSDictionary *config;
    if ( !config ){
        config = @{@"gyms" : @"Gym"};
    }
    return config;
}

@end

@implementation Gym

+ (NSDictionary *)JSONMap
{
    static NSDictionary *config;
    if ( !config ){
        config = @{@"name" : @"name",
                   @"is_followed" : @"followed",
                   @"fans_count" : @"fansCount",
                   @"location" : @"location",
                   @"courses" : @"courseArr"};
    }
    return config;
}

+ (NSDictionary *)arrayElementMap
{
    static NSDictionary *config;
    if ( !config ){
        config = @{@"courses" : @"Course"};
    }
    return config;
}
@end

@implementation Course

+ (NSDictionary *)JSONMap
{
    static NSDictionary *config;
    if ( !config ){
        config = @{@"name" : @"name",
                   @"desc" : @"desc",
                   @"date" : @"date",
                   @"course_type" : @"type"};
    }
    return config;
}

@end
