//
//  UIImage+extension.m
//  应用管理
//
//  Created by zpon on 15-4-3.
//  Copyright (c) 2015年 zpon. All rights reserved.
//

#import "UIImage+Extension.h"

@implementation UIImage (Extension)
/**
 *  返回一张可以随意拉伸不变形的图片
 *
 *  @param name 图片名字
 */
+ (UIImage *)strengthImageWithName:(NSString *)name
{
    UIImage *image = [UIImage imageNamed:name];
    
    CGFloat imageW = image.size.width;
    CGFloat imageH = image.size.height;
    
   // CGFloat top, left, bottom, right;
   return  [image resizableImageWithCapInsets:UIEdgeInsetsMake(0.5*imageH, 0.5*imageW, 0.5*imageH, 0.5*imageW)];
}
@end
