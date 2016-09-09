//
//  MainPageController.m
//  EmployeeAssistant
//
//  Created by 武淅 段 on 16/9/9.
//  Copyright © 2016年 xxkuaipao. All rights reserved.
//

#import "MainPageController.h"
#import "BannerView.h"

@interface MainPageController ()<UICollectionViewDelegate, UICollectionViewDataSource>

@property (weak, nonatomic) IBOutlet UICollectionView *collectionView;
@property (weak, nonatomic) IBOutlet BannerView *bannerView;

@end

@implementation MainPageController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self setAutomaticallyAdjustsScrollViewInsets:NO];
    _collectionView.bounces = NO;
    UICollectionViewFlowLayout *layout = (UICollectionViewFlowLayout *)_collectionView.collectionViewLayout;
    CGFloat width = (SCREEN_WIDTH-2)/2;
    CGFloat height = width*0.75;
    layout.itemSize = CGSizeMake(width, height);
    layout.minimumLineSpacing = 2;
    layout.minimumInteritemSpacing = 2;
    
    
    //test banner
    
    NSArray *arr = @[@"https://img3.doubanio.com/img/celebrity/large/1364793458.23.jpg",
                     @"https://img3.doubanio.com/img/celebrity/large/24304.jpg",
                     @"https://img1.doubanio.com/img/celebrity/large/51479.jpg",
                     @"https://img1.doubanio.com/img/celebrity/large/567.jpg"];
    _bannerView.imgUrls = arr;
    _bannerView.owner = self;
}


- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    return 1;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return 8;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    UICollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"Cell" forIndexPath:indexPath];
    
    return cell;
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
