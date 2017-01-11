//
//  BeanBase.h
//  医院熟人服务端
//
//  Created by  ldh on 15/8/14.
//  Copyright (c) 2015年 luhuicy. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface BeanBase : NSObject<NSCoding>

- (void)parse:(NSDictionary *)dict;
- (id)parseObject:(NSDictionary *)dict withClassName:(NSString *)className;
- (NSArray *)parseArray:(NSArray *)arr withClassName:(NSString *)className;


@end
