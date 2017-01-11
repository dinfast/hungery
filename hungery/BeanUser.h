//
//  BeanUser.h
//  松霖家居
//
//  Created by  ldh on 16/7/11.
//  Copyright © 2016年 luhuicy. All rights reserved.
//

#import "BeanBase.h"

@interface BeanUser : BeanBase
@property(strong,nonatomic)NSString*targetId;//聊天对象ID
@property(strong,nonatomic)NSString*password;//密码
@property(strong,nonatomic)NSString*memberlvcode;//身份判断会员
@property(strong,nonatomic)NSString*showimgurl; //图片地址
@property(strong,nonatomic)NSString*color;//字体颜色
@property(strong,nonatomic)NSString*name;
@property(strong,nonatomic)NSString*headurl;
@property(strong,nonatomic)NSString*iscenter;//是中心
@property(strong,nonatomic)NSString*userid;//geren ID
@property(strong,nonatomic)NSString*needtype;
@property(strong,nonatomic)NSString*jumpurl;
@property(strong,nonatomic)NSString*tel;
@property(strong,nonatomic)NSString*des;
@property(strong,nonatomic)NSString*token;
@property(strong,nonatomic)NSString*rongCloudToken;
@property(strong,nonatomic)NSString*iscanselct;//地址是否可以选择
@property(strong,nonatomic)NSString*address;
@property(strong,nonatomic)NSString*  isems; //是否大件物流
@property(strong,nonatomic)NSString* isnormal;//默认
@property(strong,nonatomic)NSString*addressid;//地址id
@property(strong,nonatomic)NSString*regiontyp;//地址类型
@property(strong,nonatomic)NSString* islogistics;//是否大件物流
@property(strong,nonatomic)NSString*bigarea; //大地区
@property(strong,nonatomic)NSString*detailarea;//详细地区
@property(strong,nonatomic)NSString*adressandcode;//带
@property(strong,nonatomic)NSString*question;//问题
@property(strong,nonatomic)NSString*answer;//回答
@property(strong,nonatomic)NSString*imgid;//图片id
@property(strong,nonatomic)NSString*sex;
@property(strong,nonatomic)NSString*maimgurl;//二维码图片地址

@end
