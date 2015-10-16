//
//  Emotion.h
//  qq聊天
//
//  Created by TomPro on 15/10/15.
//  Copyright © 2015年 zpon. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Emotion : NSObject
/**
 *  文本
 */
@property (nonatomic,copy) NSString *text;
/**
 *  所对应的图片名称
 */
@property (nonatomic,copy) NSString *emotionImageName;

@end
