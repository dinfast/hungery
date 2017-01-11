//
//  BeanBase.m
//  医院熟人服务端
//
//  Created by  ldh on 15/8/14.
//  Copyright (c) 2015年 luhuicy. All rights reserved.
//

#import "BeanBase.h"

@implementation BeanBase
- (void)parse:(NSDictionary *)dict {
    
}

- (id)parseObject:(NSDictionary *)dict withClassName:(NSString *)className {
    if (dict && [dict isKindOfClass:[NSDictionary class]] && dict.count > 0 && className && className.length > 0) {
        Class cls = NSClassFromString(className);
        
        if (cls) {
            id obj = [[cls alloc] init];
            
            if ([obj isKindOfClass:[BeanBase class]]) {
                BeanBase *bean = obj;
                [bean parse:dict];
                return bean;
            }
        }
    }
    
    return nil;
}

- (NSArray *)parseArray:(NSArray *)arr withClassName:(NSString *)className {
    NSMutableArray *result = [NSMutableArray array];
    
    if (arr && [arr isKindOfClass:[NSArray class]]) {
        for (id value in arr) {
            if ([value isKindOfClass:[NSDictionary class]]) {
                if (className && className.length > 0) {
                    Class cls = NSClassFromString(className);
                    
                    if (cls) {
                        id obj = [[cls alloc] init];
                        
                        if ([obj isKindOfClass:[BeanBase class]]) {
                            BeanBase *bean = obj;
                            [bean parse:value];
                            [result addObject:bean];
                        }
                    }
                }
            } else if ([value isKindOfClass:[NSArray class]]) {
                
            } else if ([value isKindOfClass:[NSNull class]]) {
                
            } else {
                [result addObject:value];
            }
        }
    }
    
    return result;
}

- (void)encodeWithCoder:(NSCoder *)aCoder {
    
}

- (id)initWithCoder:(NSCoder *)aDecoder {
    if (self = [super init]) {
        
    }
    
    return self;
}

@end
