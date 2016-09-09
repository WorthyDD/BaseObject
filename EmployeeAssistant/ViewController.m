//
//  ViewController.m
//  EmployeeAssistant
//
//  Created by 武淅 段 on 16/8/26.
//  Copyright © 2016年 xxkuaipao. All rights reserved.
//

#import "ViewController.h"
#import <MBProgressHUD.h>
#import "APIObjects.h"
#import "KVNProgress.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    UIButton *b = [[UIButton alloc]initWithFrame:CGRectMake(20, 80, 60, 30)];
    [b setTitle:@"test api" forState:UIControlStateNormal];
    [b addTarget:self action:@selector(testAPI2:) forControlEvents:UIControlEventTouchUpInside];
    [b setBackgroundColor:[UIColor redColor]];
    [self.view addSubview:b];
    
    [self testUploadPhoto];
}

//上传图片测试
- (void) testUploadPhoto
{
    UIImage *image = [UIImage imageNamed:@"unknown.jpg"];
    NSData *data = UIImageJPEGRepresentation(image, 1.0);
    NSString *url = @"http://192.168.30.29:5000/upload";
    APIUploadFile *upload = [[APIUploadFile alloc]initWithName:@"file" fileName:@"unkoen.jpg" data:data mineType:@"image"];
    AFHTTPSessionManager *manager = [[AFHTTPSessionManager alloc]init];
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    [manager.responseSerializer.acceptableContentTypes setByAddingObjectsFromArray:@[@"text/html", @"text/plain", @"image/jpeg", @"image/jpg"]];
    [manager POST:url parameters:nil constructingBodyWithBlock:^(id<AFMultipartFormData>  _Nonnull formData) {
        [formData appendPartWithFileData:data name:upload.name fileName:upload.fileName mimeType:upload.mineType];
    } progress:^(NSProgress * _Nonnull uploadProgress) {
        NSInteger percentage = uploadProgress.completedUnitCount/((double)uploadProgress.totalUnitCount)*100;
        NSLog(@"\n上传中... %%%ld", percentage);
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
        NSLog(@"\ncomplete----%@", responseObject);
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSLog(@"\n error---%@", error);
    }];
    
}


- (void)testAPI : (id)sender{
    
    [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    
    __weak typeof(self) WeakSelf = self;
    [[APIManager shareManager] GETWithAPIWithPath:@"/client/gym/3481/coach-with-erp" params:nil completion:^(id jsonObject, NSError *error) {
        [MBProgressHUD hideHUDForView:WeakSelf.view animated:YES];
        
//        NSLog(@"\n\nresult---%@\n\nerror---%@", jsonObject, error);
        CoachList *list = [[CoachList alloc]initWithJsonObject:jsonObject];
//        CoachList *list = [[CoachList alloc]init];
        NSLog(@"\n\ncoach list---%@", list.coachList);
        for(Coach *coach in list.coachList){
            NSLog(@"coach---\n%ld\n%@\n%@\n", coach.identifier,coach.name,coach.imgUrl);
        }
        
    }];
}

- (void) testAPI1 : (id)sender{
    [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    
    __weak typeof(self) WeakSelf = self;
    NSDictionary *params = @{@"city" : @"北京",
                             @"lat" : @(39.999430),
                             @"lng" : @(116.338788),
                             @"offset" : @(0)};
    [[APIManager shareManager] GETWithAPIWithPath:@"/client/gym/list" params:params completion:^(id jsonObject, NSError *error) {
        [MBProgressHUD hideHUDForView:WeakSelf.view animated:YES];
        
        //        NSLog(@"\n\nresult---%@\n\nerror---%@", jsonObject, error);
        GymList *list = [[GymList alloc]initWithJsonObject:jsonObject];
        //        CoachList *list = [[CoachList alloc]init];
        NSLog(@"\n\ncoach list---\n%d\n%ld", list.hasMore, list.offset);
        for(Gym *gym in list.gyms){
            NSLog(@"gym---\n%ld\n%@\n%@\n%d\n", gym.fansCount, gym.name, gym.location, gym.followed);
        }
        
    }];

}

- (void) testAPI2 : (id)sender{
    
    NSString *url = @"/gym/show_gyms_in_client";
    NSDictionary *params = @{@"city" : @"北京",
                             @"page" : @(1),
                             @"perpage" : @(20)};
    
    __weak typeof(self) WeakSelf = self;
    [KVNProgress show];
    [[APIManager shareManager] GETWithAPIWithPath:url params:params completion:^(id jsonObject, NSError *error) {
        
        [KVNProgress dismiss];
        if(error){
            NSLog(@"error---%@", error);
        }
        if(jsonObject){
            NSLog(@"jsonObject----%@", jsonObject);
            GymList *list = [[GymList alloc]initWithJsonObject:jsonObject];
            NSLog(@"gymlist:--%@", list);
            
            BaseViewController *vc = [self.storyboard instantiateViewControllerWithIdentifier:@"testVC"];
            [WeakSelf.navigationController pushViewController:vc animated:YES];
            
        }
    }];
}

@end
