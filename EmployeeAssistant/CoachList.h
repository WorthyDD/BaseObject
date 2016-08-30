//
//  CoachList.h
//  EmployeeAssistant
//
//  Created by 武淅 段 on 16/8/30.
//  Copyright © 2016年 xxkuaipao. All rights reserved.
//

#import "BaseObject.h"

@interface CoachList : BaseObject

@property (nonatomic) NSArray *coachList;

@end

@interface Coach : BaseObject

@property (nonatomic, assign) NSInteger identifier;
@property (nonatomic) NSString *name;
@property (nonatomic) NSString *imgUrl;
@end