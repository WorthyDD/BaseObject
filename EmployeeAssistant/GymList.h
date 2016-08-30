//
//  GymList.h
//  EmployeeAssistant
//
//  Created by 武淅 段 on 16/8/30.
//  Copyright © 2016年 xxkuaipao. All rights reserved.
//

#import "BaseObject.h"

@interface GymList : BaseObject

@property (nonatomic, assign) BOOL hasMore;
@property (nonatomic) NSArray *gyms;
@property (nonatomic, assign) NSInteger offset;

@end

@interface Gym : BaseObject

@property (nonatomic, assign) BOOL followed;
@property (nonatomic, assign) NSInteger fansCount;
@property (nonatomic) NSString *name;
@property (nonatomic) NSString *location;

@end
