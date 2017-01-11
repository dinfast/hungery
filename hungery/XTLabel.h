//
//  XTLabel.h
//  XtuanMoive
//
//  Created by X团 on 14-12-3.
//  Copyright (c) 2014年 X团. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface XTLabel : UILabel

@property (nonatomic, strong) UIColor * color;
-(void)withcontent:(NSString*)content andfont:(CGFloat)size andlimitwidt:(CGFloat)limtwidt andx:(CGFloat)x andy:(CGFloat)y andtextcolor:(UIColor*)color;
-(void)withcentercontent:(NSString*)content andfont:(CGFloat)size andlimitwidt:(CGFloat)limtwidt andx:(CGFloat)x andy:(CGFloat)y andtextcolor:(UIColor*)color;
@end
