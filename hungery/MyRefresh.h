//
//  MyRefresh.h
//  XtuanMoive2.0
//
//  Created by X团 on 14-8-21.
//  Copyright (c) 2014年 X团. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface MyRefresh : UIView
{
    int angle;
    BOOL isStopAnimation;
}

@property (nonatomic,strong) UIImageView * loadingImage;

-(void) show;            //展示加载效果界面
-(void) stopAcivity;     //停止加载页
-(void) start;           //展示（不是至于最顶层的）
-(void) remove;

@end
