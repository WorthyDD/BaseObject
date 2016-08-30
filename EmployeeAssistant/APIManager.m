//
//  APIManager.m
//  EmployeeAssistant
//
//  Created by 武淅 段 on 16/8/30.
//  Copyright © 2016年 xxkuaipao. All rights reserved.
//

#import "APIManager.h"
static NSString* baseURL = @"http://api.xxkuaipao.com:8018";


@implementation APIManager

+ (instancetype)shareManager
{
    static APIManager *manager;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        manager = [[APIManager alloc]initWithBaseURL:[NSURL URLWithString:baseURL]];
        [manager.responseSerializer.acceptableContentTypes setByAddingObjectsFromArray:@[@"text/html", @"text/plain"]];
        
    });
    return manager;
}

- (NSURLSessionDataTask *) GETWithAPIWithPath : (NSString *)apiPath params : (NSDictionary *)params completion : (void(^)(id jsonObject, NSError *error))completion{
    
    NSURLSessionDataTask *task = nil;
    task = [self GET:apiPath parameters:params progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSInteger code = [[responseObject valueForKey:@"code"]integerValue];
        if(code != 0){
            NSString *msg = [responseObject valueForKey:@"msg"] ?: @"未知错误";
            completion(nil, [NSError errorWithDomain:@"com.papayamobile.api" code:code userInfo:@{@"msg" : msg}]);
        }
        else{
            id result = [responseObject valueForKey:@"data"];
            completion(result, nil);
        }
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSLog(@"\n-----------------------\nerror---%@\n\n", error);
        completion(nil, [NSError errorWithDomain:@"com.papayamobile.api" code:error.code userInfo:@{@"msg" : @"网络错误或服务器故障"}]);
    }];
    
    return task;
}


@end
