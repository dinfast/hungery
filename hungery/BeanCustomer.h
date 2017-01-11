//
//  BeanCustomer.h
//  naocutong
//
//  Created by apple on 16/12/27.
//  Copyright © 2016年 apple. All rights reserved.
//

#import "BeanBase.h"

@interface BeanCustomer : BeanBase
@property(strong,nonatomic)NSString*name;
@property(strong,nonatomic)NSString*headurl;
@property(strong,nonatomic)NSString*iscenter;//是中心
@property(strong,nonatomic)NSString*userid;//geren ID
@property(strong,nonatomic)NSMutableArray*arrusers;
@end
