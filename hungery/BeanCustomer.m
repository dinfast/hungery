//
//  BeanCustomer.m
//  naocutong
//
//  Created by apple on 16/12/27.
//  Copyright © 2016年 apple. All rights reserved.
//

#import "BeanCustomer.h"

@implementation BeanCustomer
- (NSString *)description {
    NSMutableString *result = [NSMutableString string];
    
    [result appendString:@"{\n"];
    [result appendFormat:@"name=%@\n", self.name];
    [result appendFormat:@"headurl=%@\n", self.headurl];
    [result appendFormat:@"userid=%@\n", self.userid];
    [result appendFormat:@"iscenter=%@\n", self.iscenter];
    [result appendFormat:@"arrusers=%@\n", self.arrusers];
    
    
    [result appendString:@"}\n"];
    
    return [result description];
}


- (void)encodeWithCoder:(NSCoder *)aCoder {
    [super encodeWithCoder:aCoder];
    
    [aCoder encodeObject:self.name forKey:@"name"];
    [aCoder encodeObject:self.headurl forKey:@"headurl"];
    [aCoder encodeObject:self.userid forKey:@"userid"];
    [aCoder encodeObject:self.iscenter forKey:@"iscenter"];
     [aCoder encodeObject:self.arrusers forKey:@"arrusers"];
    
    
    
}

- (id)initWithCoder:(NSCoder *)aDecoder {
    if (self = [super initWithCoder:aDecoder]) {
        
        if ([aDecoder containsValueForKey:@"name"]) self.name = [aDecoder decodeObjectForKey:@"name"];
        if ([aDecoder containsValueForKey:@"headurl"]) self.headurl = [aDecoder decodeObjectForKey:@"headurl"];
        if ([aDecoder containsValueForKey:@"userid"]) self.userid = [aDecoder decodeObjectForKey:@"userid"];
        if ([aDecoder containsValueForKey:@"iscenter"]) self.iscenter = [aDecoder decodeObjectForKey:@"iscenter"];
       if ([aDecoder containsValueForKey:@"arrusers"]) self.arrusers = [aDecoder decodeObjectForKey:@"arrusers"];
        
        
        
    }
    
    
    return self;
}

@end
