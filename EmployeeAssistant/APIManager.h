//
//  APIManager.h
//  EmployeeAssistant
//
//  Created by 武淅 段 on 16/8/30.
//  Copyright © 2016年 xxkuaipao. All rights reserved.
//

#import <AFNetworking/AFNetworking.h>


typedef enum : NSUInteger {
    
    APIMethodGet,
    APIMethodPost
} APIMathod;

@interface APIManager : AFHTTPSessionManager

+ (instancetype) shareManager;

/**
 *  发起一个GET请求
 *  @apiPath : api路径
 *  @params : 请求参数
 *  @method : 请求类型(GET, POST)
 *  @completion : 请求完成调用的block
 */
- (NSURLSessionDataTask *) GETWithAPIWithPath : (NSString *)apiPath params : (NSDictionary *)params completion : (void(^)(id jsonObject, NSError *error))completion;

@end
