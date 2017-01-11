//
//  NSKeyedUnarchiver+SafeUnarchive.m
//  XtuanMoive
//
//  Created by ppl on 14-12-22.
//  Copyright (c) 2014年 X团. All rights reserved.
//

#import "NSKeyedUnarchiver+SafeUnarchive.h"

@implementation NSKeyedUnarchiver (SafeUnarchive)

+ (id)safeUnarchiveObjectWithData:(NSData *)data {
    id result = nil;
    
    @try {
        result = [NSKeyedUnarchiver unarchiveObjectWithData:data];
    }
    @catch (NSException *exception) {
    }
    @finally {
        
    }
    
    return result;
}

@end
