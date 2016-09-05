//
//  APIManager.h
//  EmployeeAssistant
//
//  Created by 武淅 段 on 16/8/30.
//  Copyright © 2016年 xxkuaipao. All rights reserved.
//

#import <AFNetworking/AFNetworking.h>
#import "MineType.h"
typedef enum : NSUInteger {
    
    APIMethodGet,
    APIMethodPost
} APIMathod;

/**
 *  上传文件
 */
@interface APIUploadFile : NSObject

/**
 *  表单中的名字
 */
@property (nonatomic, copy) NSString *name;

/**
 *  上传的文件数据
 */
@property (nonatomic) NSData *data;

/**
 *  上传的文件路径  跟文件数据二者选其一  data优先
 */
@property (nonatomic, copy) NSString *filePath;

/**
 *  文件名
 */
@property (nonatomic, copy) NSString *fileName;
/**
 *  MINE类型，如果不指定，则根据fileName和fileURL推断
 */
@property (nonatomic, copy) NSString *mineType;

- (instancetype)initWithFilePath:(NSString *)filePath;
- (instancetype)initWithName:(NSString *)name fileName:(NSString *)fileName data:(NSData *)data mineType:(NSString *)mineType;

@end


@interface APIManager : AFHTTPSessionManager

+ (instancetype) shareManager;

/**
 *  发起一个GET请求
 *  @apiPath : api路径
 *  @params : 请求参数
 *  @completion : 请求完成调用的block
 */
- (NSURLSessionDataTask *) GETWithAPIWithPath : (NSString *)apiPath params : (NSDictionary *)params completion : (void(^)(id jsonObject, NSError *error))completion;

/**
 *  发起一个普通的POST请求
 *  @apiPath : api路径
 *  @params : 请求参数
 *  @completion : 请求完成调用的block
 */

- (NSURLSessionDataTask *) POSTWithAPIWithPath : (NSString *)apiPath params : (NSDictionary *)params completion : (void(^)(id jsonObject, NSError *error))completion;

/**
 *  POST上传文件
 *  @files: 待上传的文件数组
 *  @progress  : 上传进度 0-100
 *  @params : 请求参数
 *  @completion : 请求完成调用的block
 */
- (NSURLSessionDataTask *) UploadFileWithAPIWithPath : (NSString *)apiPath params : (NSDictionary *)params files : (NSArray<APIUploadFile *> *) files progress: (void(^)(NSInteger progress))progress completion : (void(^)(id jsonObject, NSError *error))completion;

@end


extern NSString *const kAPIRequestOperationManagerErrorInfoMessageKey;
extern NSString *const kAPIRequestOperationManagerErrorInfoServerCodeKey;
extern NSString *const kAPIRequestOperationManagerErrorInfoServerDataKey;