//
//  UIImage+extension.h
//  应用管理
//
//  Created by zpon on 15-4-3.
//  Copyright (c) 2015年 zpon. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIImage (Extension)

/**
 *  返回一张可以随意拉伸不变形的图片
 *
 *  @param name 图片名字
 */
+ (UIImage *)strengthImageWithName:(NSString *)name;
@end
