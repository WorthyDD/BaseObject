//
//  BannerView.m
//  EmployeeAssistant
//
//  Created by 武淅 段 on 16/9/9.
//  Copyright © 2016年 xxkuaipao. All rights reserved.
//

#import "BannerView.h"
#include "Tookit.h"
#import "constant.h"
#include <AFNetworking.h>
#import "BaseWebViewController.h"

@interface BannerView()<UIScrollViewDelegate>

@property (nonatomic) UIScrollView *scrollView;
@property (nonatomic) NSMutableArray<UIImageView *> *imageViews;
@property (nonatomic) UIPageControl *pageControl;

@end
@implementation BannerView

- (void)awakeFromNib
{
    [super awakeFromNib];
    _scrollView = [[UIScrollView alloc]initWithFrame:self.bounds];
    [_scrollView setContentOffset:CGPointMake(0, 0)];
    [_scrollView setPagingEnabled:YES];
    [_scrollView setBounces:NO];
    [_scrollView setShowsVerticalScrollIndicator:NO];
    [_scrollView setShowsHorizontalScrollIndicator:NO];
    _scrollView.delegate = self;
    [self addSubview:_scrollView];
    _imageViews = [NSMutableArray new];
    _pageControl = [[UIPageControl alloc]initWithFrame:CGRectMake(0, 0, 200, 20)];
    [self addSubview:_pageControl];
    _pageControl.hidden = YES;
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    _scrollView.frame = self.bounds;
    [_scrollView setContentSize:CGSizeMake(self.width*_imgUrls.count, self.height)];
    for(int i = 0; i < _imgUrls.count;i++){
        NSString *imgUrl = _imgUrls[i];
        UIImageView *iv = _imageViews[i];
        [iv setImageWithURL:[NSURL URLWithString:imgUrl]];
        CGFloat offset = self.width*i;
        iv.frame = CGRectMake(offset, 0, self.width, self.height);
        [iv setContentMode:UIViewContentModeScaleAspectFill];
    }
    _pageControl.hidden = _imgUrls.count <= 1;
    _pageControl.center = CGPointMake(self.centerX, self.height-_pageControl.height/2.0);
    [_pageControl setNumberOfPages:_imgUrls.count];
    [_pageControl setCurrentPage:0];
}

- (void)setImgUrls:(NSArray<NSString *> *)imgUrls
{
    _imgUrls = imgUrls;
    //少增多减
    if(imgUrls.count > _imageViews.count){
        
        NSInteger count = imgUrls.count-_imageViews.count;
        for(int i = 0;i < count; i++){
            UIImageView *iv = [[UIImageView alloc]initWithFrame:self.bounds];
            UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(didTapImage:)];
            iv.userInteractionEnabled = YES;
            [iv addGestureRecognizer:tap];
            [iv setClipsToBounds:YES];
            [_imageViews addObject:iv];
            [_scrollView addSubview:iv];
        }
    }
    else if(imgUrls.count<_imageViews.count){
        NSInteger count = _imageViews.count-imgUrls.count;
        for(int i = 0;i < count; i++){
            UIImageView *iv = [_imageViews lastObject];
            [iv removeFromSuperview];
        }
    }
    [self layoutIfNeeded];
}

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
    CGFloat x = scrollView.contentOffset.x;
    NSInteger index = x/self.width;
    [_pageControl setCurrentPage:index];
}

#pragma mark - click action

- (void) didTapImage : (UITapGestureRecognizer *)tap
{
    NSString *url = @"http://www.baidu.com";
    BaseWebViewController *webVC = [[BaseWebViewController alloc]init];
    webVC.urlString = url;
    
    if(_owner){
        [_owner.navigationController pushViewController:webVC animated:YES];
    }
}

@end
