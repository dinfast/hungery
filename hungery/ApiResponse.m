//
//  ApiResponse.m
//  luhui
//

#import "ApiResponse.h"
#import "BeanBase.h"

@implementation ApiResponse

- (id)init
{
    self = [super init];
    
    if (self) {
        
        self.status=@"0";
//        self.message = @"网络请求失败";
        
    }
    
    return self;
}

- (NSString *)description {
    NSMutableString *result = [NSMutableString string];
    
    [result appendString:@"{\n"];
    [result appendFormat:@"data=%@\n", self.data];
    [result appendFormat:@"status=%@\n", self.status];
    [result appendFormat:@"message=%@\n", self.message];
    [result appendString:@"}\n"];
    
    return [result description];
}


- (void)parse:(NSData *)data withReturnClassName:(NSString *)className
{
    NSError *error = nil;
    
    NSDictionary *dict = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:&error];
    if (!dict) {
        //        NSLog(@"response json error:%@", [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding]);
        self.status = API_STATUS_JSON;
        self.message = @"数据解析失败";
        return;
    }
    //    NSLog(@"dicis    %@,%lu",dict,(unsigned long)dict.count);
    id statusObject = [dict objectForKey:@"status"];
    id messageObject = [dict objectForKey:@"msg"];
    id dataObject = [dict objectForKey:@"data"];
    id errcode=[dict objectForKey:@"errCode"];
    self.errorcode=[NSString stringWithFormat:@"%@",errcode];
    
    
    if (statusObject && [statusObject isKindOfClass:[NSString class]]) {
        self.status = statusObject ;
    }
    if(statusObject && [statusObject isKindOfClass:[NSNumber class]]) {
        self.status = [NSString stringWithFormat:@"%@",statusObject];
    }
    if([self.status isEqualToString:@"400"])
    {
        return;
    }
    
    if (messageObject) {
        self.message = [messageObject description];
    }
    
    if ([self.status isEqualToString:@"1"]) {
        if ([dataObject isKindOfClass:[NSDictionary class]]) {
            NSDictionary *dataDict = dataObject;
            
            if (dataDict.count > 0) {
                if (className && className.length > 0) {
                    Class cls = NSClassFromString(className);
                    
                    if (cls) {
                        id obj = [[cls alloc] init];
                        
                        if ([obj isKindOfClass:[BeanBase class]]) {
                            BeanBase *bean = obj;
                            [bean parse:dataDict];
                            self.data = obj;
                        }
                    }
                }else{
                    
                    
                    self.data=dict;
                    
                }
            }
        } else if ([dataObject isKindOfClass:[NSArray class]]) {
            NSMutableArray *newArray = [NSMutableArray array];
            NSArray *array = dataObject;
            
            //            for (id value in array) {
            //                if ([value isKindOfClass:[NSDictionary class]]) {
            //                    if (className && className.length > 0) {
            //                        Class cls = NSClassFromString(className);
            //
            //                        if (cls) {
            //                            id obj = [[cls alloc] init];
            //
            //                            if ([obj isKindOfClass:[BeanBase class]]) {
            //                                BeanBase *bean = obj;
            //                                [bean parse:value];
            //                                [newArray addObject:bean];
            //                            }
            //                        }
            //                    }else{
            //                        self.data=dict;
            //                    }
            //                } else if ([value isKindOfClass:[NSArray class]]) {
            //
            //                } else if ([value isKindOfClass:[NSNull class]]) {
            //
            //                } else {
            //                    [newArray addObject:value];
            //                }
            //            }
            self.data = dataObject;
        } else if ([dataObject isKindOfClass:[NSNull class]]) {
            self.data = nil;
        } else {
            self.data = dataObject;
        }
    }
}

@end
