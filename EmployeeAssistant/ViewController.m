//
//  ViewController.m
//  EmployeeAssistant
//
//  Created by 武淅 段 on 16/8/26.
//  Copyright © 2016年 xxkuaipao. All rights reserved.
//

#import "ViewController.h"
#import "APIManager.h"
#import <MBProgressHUD.h>
#import "CoachList.h"
#import "GymList.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    UIButton *b = [[UIButton alloc]initWithFrame:CGRectMake(20, 20, 60, 30)];
    [b setTitle:@"test api" forState:UIControlStateNormal];
    [b addTarget:self action:@selector(testAPI1:) forControlEvents:UIControlEventTouchUpInside];
    [b setBackgroundColor:[UIColor redColor]];
    [self.view addSubview:b];
    
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

@end
