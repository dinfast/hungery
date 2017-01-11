//
//  NSKeyedUnarchiver+SafeUnarchive.h
//  XtuanMoive
//
//  Created by ppl on 14-12-22.
//  Copyright (c) 2014年 X团. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSKeyedUnarchiver (SafeUnarchive)

+ (id)safeUnarchiveObjectWithData:(NSData *)data;

@end
