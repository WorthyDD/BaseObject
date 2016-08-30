//
//  BaseObject.m
//  EmployeeAssistant
//
//  Created by 武淅 段 on 16/8/30.
//  Copyright © 2016年 xxkuaipao. All rights reserved.
//

#import "BaseObject.h"

@implementation BaseObject

+ (NSDictionary *)JSONMap
{
    return nil;
}

+ (NSDictionary *)arrayElementMap
{
    return nil;
}

+ (NSDictionary *)classMap
{
    return nil;
}

- (instancetype) initWithJsonObject:(NSDictionary *)jsonObject
{
    self = [self init];
    if(self){
        NSDictionary *map = [[self class] JSONMap];
        NSDictionary *classMap = [[self class] classMap];
        NSDictionary *arrayMap = [[self class] arrayElementMap];
        
        for(NSString *key in map.allKeys){
            
            id value = [jsonObject objectForKey:key];
            NSString *localKey = [map objectForKey:key];
            if(localKey == nil){
                continue;
            }
            
            //数组
            if([value isKindOfClass:[NSArray class]]){
                NSString *className = [arrayMap objectForKey:key];
                if(className){
                    NSMutableArray *arr = [NSMutableArray new];
                    
                    Class class = NSClassFromString(className);
                    for(id elementValue in value){
                        id elementObj = [[class alloc]initWithJsonObject:elementValue];
                        [arr addObject:elementObj];
                    }
                    [self setValue:arr.copy forKey:localKey];
                    
                }
                else{
                    [self setValue:value forKey:localKey];
                }
            }
            else{
                
                //class
                NSString *className = [classMap objectForKey:key];
                if(className){
                    Class class = NSClassFromString(className);
                    id obj = [[class alloc]initWithJsonObject:value];
                    [self setValue:obj forKey:localKey];
                }
                else{
                    [self setValue:value forKey:localKey];
                }
            }
            
            
            /*
             id localValue = [self valueForKey:localKey];
             if([localValue isKindOfClass:[BaseObject class]]){
             Class class = [localValue class];
             id obj = [[class alloc]initWithJsonObject:value];
             [self setValue:obj forKey:localKey];
             }
             else if([localValue isKindOfClass:[NSArray class]]){
             if(![value isKindOfClass:[NSArray class]]){
             continue;
             }
             NSMutableArray *arr = [NSMutableArray new];
             id className = [[[self class] arrayElementMap] objectForKey:key];
             if(className != nil){
             Class class = NSClassFromString(className);
             for(id elementValue in value){
             id elementObj = [[class alloc]initWithJsonObject:elementValue];
             [arr addObject:elementObj];
             }
             }
             [self setValue:arr forKey:localKey];
             }
             else{
             [self setValue:value forKey:localKey];
             }*/
        }

    }
    
    return self;
}

@end
