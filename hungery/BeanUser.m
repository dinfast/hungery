//
//  BeanUser.m
//  松霖家居
//
//  Created by  ldh on 16/7/11.
//  Copyright © 2016年 luhuicy. All rights reserved.
//

#import "BeanUser.h"

@implementation BeanUser
- (NSString *)description {
    NSMutableString *result = [NSMutableString string];
    
    [result appendString:@"{\n"];
    [result appendFormat:@"name=%@\n", self.name];
    [result appendFormat:@"adress=%@\n", self.address];
    [result appendFormat:@"tel=%@\n", self.tel];
     [result appendFormat:@"headurl=%@\n", self.headurl];
    [result appendFormat:@"userid=%@\n", self.userid];
    [result appendFormat:@"islogistics=%@\n", self.islogistics];
    [result appendFormat:@"isems=%@\n", self.isems];
    [result appendFormat:@"isnormal=%@\n", self.isnormal];
      [result appendFormat:@"memberlvcode=%@\n", self.memberlvcode];
       [result appendFormat:@"sex=%@\n", self.sex];
      [result appendFormat:@"sex=%@\n", self.maimgurl];
     [result appendFormat:@"password=%@\n", self.password];
     [result appendFormat:@"token=%@\n", self.token];
    [result appendFormat:@"rongCloudToken=%@\n", self.rongCloudToken];
    [result appendFormat:@"iscenter=%@\n", self.iscenter];
    [result appendFormat:@"targetId=%@\n", self.targetId];
    
    
    [result appendString:@"}\n"];
    
    return [result description];
}


- (void)encodeWithCoder:(NSCoder *)aCoder {
    [super encodeWithCoder:aCoder];
    
    [aCoder encodeObject:self.name forKey:@"name"];
     [aCoder encodeObject:self.headurl forKey:@"headurl"];
    [aCoder encodeObject:self.address forKey:@"address"];
    [aCoder encodeObject:self.tel forKey:@"tel"];
    [aCoder encodeObject:self.userid forKey:@"userid"];
    [aCoder encodeObject:self.memberlvcode forKey:@"memberlvcode"];
     [aCoder encodeObject:self.sex forKey:@"sex"];
    [aCoder encodeObject:self.maimgurl forKey:@"maimgurl"];
     [aCoder encodeObject:self.password forKey:@"password"];
    [aCoder encodeObject:self.token forKey:@"token"];
     [aCoder encodeObject:self.rongCloudToken forKey:@"rongCloudToken"];
    [aCoder encodeObject:self.iscenter forKey:@"iscenter"];
    [aCoder encodeObject:self.targetId forKey:@"targetId"];
    
    
}

- (id)initWithCoder:(NSCoder *)aDecoder {
    if (self = [super initWithCoder:aDecoder]) {
        
        if ([aDecoder containsValueForKey:@"name"]) self.name = [aDecoder decodeObjectForKey:@"name"];
        if ([aDecoder containsValueForKey:@"headurl"]) self.headurl = [aDecoder decodeObjectForKey:@"headurl"];
        if ([aDecoder containsValueForKey:@"address"]) self.address = [aDecoder decodeObjectForKey:@"address"];
         if ([aDecoder containsValueForKey:@"tel"]) self.tel = [aDecoder decodeObjectForKey:@"tel"];
         if ([aDecoder containsValueForKey:@"userid"]) self.userid = [aDecoder decodeObjectForKey:@"userid"];
        if ([aDecoder containsValueForKey:@"memberlvcode"]) self.memberlvcode = [aDecoder decodeObjectForKey:@"memberlvcode"];
         if ([aDecoder containsValueForKey:@"sex"]) self.sex = [aDecoder decodeObjectForKey:@"sex"];
        if ([aDecoder containsValueForKey:@"maimgurl"]) self.maimgurl = [aDecoder decodeObjectForKey:@"maimgurl"];
        if ([aDecoder containsValueForKey:@"password"]) self.password = [aDecoder decodeObjectForKey:@"password"];
        if ([aDecoder containsValueForKey:@"token"]) self.token = [aDecoder decodeObjectForKey:@"token"];
         if ([aDecoder containsValueForKey:@"rongCloudToken"]) self.rongCloudToken = [aDecoder decodeObjectForKey:@"rongCloudToken"];
        if ([aDecoder containsValueForKey:@"iscenter"]) self.iscenter = [aDecoder decodeObjectForKey:@"iscenter"];
        if ([aDecoder containsValueForKey:@"targetId"]) self.targetId = [aDecoder decodeObjectForKey:@"targetId"];
        
        
        
    }
    
    
    return self;
}


@end
