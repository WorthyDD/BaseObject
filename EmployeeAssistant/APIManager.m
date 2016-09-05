//
//  APIManager.m
//  EmployeeAssistant
//
//  Created by 武淅 段 on 16/8/30.
//  Copyright © 2016年 xxkuaipao. All rights reserved.
//

#import "APIManager.h"
NSString *const baseURL = @"http://api.xxkuaipao.com:8003";
NSString *const kAPIRequestOperationManagerErrorInfoMessageKey = @"message";
NSString *const kAPIRequestOperationManagerErrorInfoServerCodeKey = @"serverCode";
NSString *const kAPIRequestOperationManagerErrorInfoServerDataKey = @"serverData";

@implementation APIManager

+ (instancetype)shareManager
{
    static APIManager *manager;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        manager = [[APIManager alloc]initWithBaseURL:[NSURL URLWithString:baseURL]];
        [manager.responseSerializer.acceptableContentTypes setByAddingObjectsFromArray:@[@"text/html", @"text/plain"]];
        //监测网络状态
        NSOperationQueue *operationQueue = manager.operationQueue;
        [manager.reachabilityManager setReachabilityStatusChangeBlock:^(AFNetworkReachabilityStatus status) {
            switch (status) {
                case AFNetworkReachabilityStatusReachableViaWWAN:
                case AFNetworkReachabilityStatusReachableViaWiFi:
                    [operationQueue setSuspended:NO];
                    break;
                case AFNetworkReachabilityStatusNotReachable:
                default:
                    [operationQueue setSuspended:YES];
                    break;
            }
        }];
        [manager.reachabilityManager startMonitoring];
        
    });
    return manager;
}

- (BOOL)isOffline
{
    return self.operationQueue.isSuspended;
}

- (NSURLSessionDataTask *) GETWithAPIWithPath : (NSString *)apiPath params : (NSDictionary *)params completion : (void(^)(id jsonObject, NSError *error))completion{
    
    NSURLSessionDataTask *task = nil;
    if(self.isOffline) {
        NSString *msg = @"网络故障或服务器故障";
        completion(nil, [NSError errorWithDomain:@"com.papayamobile.api" code:101 userInfo:@{kAPIRequestOperationManagerErrorInfoMessageKey : msg}]);
        return task;
    }

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

- (NSURLSessionDataTask *)POSTWithAPIWithPath:(NSString *)apiPath params:(NSDictionary *)params completion:(void (^)(id, NSError *))completion
{
    
    NSURLSessionDataTask *task = nil;
    if(self.isOffline) {
        NSString *msg = @"网络故障或服务器故障";
        completion(nil, [NSError errorWithDomain:@"com.papayamobile.api" code:101 userInfo:@{kAPIRequestOperationManagerErrorInfoMessageKey : msg}]);
        return task;
    }
    task = [self POST:apiPath parameters:params constructingBodyWithBlock:^(id<AFMultipartFormData>  _Nonnull formData) {
        
    } progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
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

- (NSURLSessionDataTask *) UploadFileWithAPIWithPath : (NSString *)apiPath params : (NSDictionary *)params files : (NSArray<APIUploadFile *> *) files progress: (void(^)(NSInteger progress))progress completion : (void(^)(id jsonObject, NSError *error))completion
{
    NSURLSessionDataTask *task = nil;
    if(self.isOffline) {
        NSString *msg = @"网络故障或服务器故障";
        completion(nil, [NSError errorWithDomain:@"com.papayamobile.api" code:101 userInfo:@{kAPIRequestOperationManagerErrorInfoMessageKey : msg}]);
        return task;
    }
    task = [self POST:apiPath parameters:params constructingBodyWithBlock:^(id<AFMultipartFormData>  _Nonnull formData) {
        for(APIUploadFile *uploadFile in files){
            NSData *data = uploadFile.data;
            if (!data) {
                if (uploadFile.filePath) {
                    data = [NSData dataWithContentsOfFile:uploadFile.filePath];
                }
            }
            if (data) {
                [formData appendPartWithFileData:data name:uploadFile.name fileName:uploadFile.fileName mimeType:uploadFile.mineType];
            }
        }
    } progress:^(NSProgress * _Nonnull uploadProgress) {
        NSInteger percentage = uploadProgress.completedUnitCount/((double)uploadProgress.totalUnitCount)*100;
        progress(percentage);
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
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


@implementation APIUploadFile

- (NSString *)mineType
{
    if (!_mineType.length) {
        NSString *ext;
        if (_filePath.length) {
            ext = [_filePath pathExtension];
        }
        if (!ext.length) {
            ext = [_fileName pathExtension];
        }
        if (ext.length) {
            MineType *mineType = [MineType mineTypeForExtension:ext];
            if (mineType) {
                _mineType = [NSString stringWithFormat:@"%@/%@", mineType.type, mineType.subType];
            }
        }
    }
    return _mineType;
}

- (NSString *)name
{
    if (!_name.length) {
        if (_filePath.length) {
            _name = [[_filePath lastPathComponent] stringByDeletingPathExtension];
        }
        else {
            _name = [_fileName stringByDeletingPathExtension];
        }
    }
    return _name;
}

- (NSString *)fileName
{
    if (!_fileName.length) {
        if (_filePath.length) {
            _fileName = [_filePath lastPathComponent];
        }
    }
    return _fileName;
}

- (instancetype)initWithFilePath:(NSString *)filePath
{
    self = [super init];
    if (self) {
        _filePath = filePath;
    }
    return self;
}

- (instancetype)initWithName:(NSString *)name fileName:(NSString *)fileName data:(NSData *)data mineType:(NSString *)mineType
{
    self = [super init];
    if (self) {
        _name = name;
        _fileName = fileName;
        _data = data;
        _mineType = mineType;
    }
    return self;
}

@end
