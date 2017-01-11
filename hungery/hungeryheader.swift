//
//  hungeryheader.swift
//  hungery
//
//  Created by apple on 17/1/11.
//  Copyright © 2017年 apple. All rights reserved.
//

import Foundation
let SCREENWIDTH = UIScreen.mainScreen().bounds.size.width
let SCREENHEIGHT = UIScreen.mainScreen().bounds.size.height
let IOS_VERSION:Float = (UIDevice.currentDevice().systemVersion as NSString) .floatValue;
//版本大于7
func IOS_VERSION7() -> Bool{
    return  ((Double)(UIDevice.currentDevice().systemVersion)>=7.0 && (Double)(UIDevice.currentDevice().systemVersion)<8.0)
}

//Double扩展
extension Double
{
    func format(f: String) -> NSString {
        
        return NSString(format: "%\(f)f", self)
    }
    
}



//版本>8<9
func IOS_VERSION8() -> Bool{
    return  ((Double)(UIDevice.currentDevice().systemVersion)>=8.0 && (Double)(UIDevice.currentDevice().systemVersion)<9.0 )
}


//版本>9<10
func IOS_VERSION9() -> Bool{
    return  ((Double)(UIDevice.currentDevice().systemVersion)>=9.0 && (Double)(UIDevice.currentDevice().systemVersion)<10.0 )
}

//rgb三颜色
func COLOR(R:Float,G:Float,B:Float,A:Float) -> UIColor {
    
    return UIColor(colorLiteralRed:R/255.0, green:G/255.0, blue:B/255.0, alpha: 1)
    
}

let KEYWIN = UIApplication.sharedApplication().keyWindow
let REDBACKCOLOR = COLOR(251, G: 49, B: 55, A: 1)
let TEXTCOLOR = COLOR(204,G: 205,B: 206,A: 1)
let UserDefault = NSUserDefaults.standardUserDefaults()
//请求地址
let BASEURL = "http://firstaid.dddaozhen.com";
