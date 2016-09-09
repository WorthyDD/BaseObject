//
//  BaseNavigationBar.m
//  EmployeeAssistant
//
//  Created by 武淅 段 on 16/9/5.
//  Copyright © 2016年 xxkuaipao. All rights reserved.
//

#import "BaseNavigationBar.h"
#import "constant.h"
#import "Tookit.h"

@implementation BaseNavigationBar

- (void)awakeFromNib
{
    [super awakeFromNib];
//    [self setBarTintColor:THEME_COLOR];
//    [self setTranslucent:NO];
    [self setTintColor:[UIColor colorWithRGB:0x666666]];
//    [self setTitleTextAttributes:@{NSForegroundColorAttributeName : [UIColor whiteColor]}];
}

/*
- (instancetype)init
{
    self = [super init];
    if(self){
        [self setBarTintColor:THEME_COLOR];
    }
    return self;
}

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if(self){
        [self setBarTintColor:THEME_COLOR];
    }
    return self;

}

- (instancetype)initWithCoder:(NSCoder *)aDecoder
{
    self = [super initWithCoder:aDecoder];
    if(self){
        [self setBarTintColor:THEME_COLOR];
    }
    return self;
}
*/


@end
