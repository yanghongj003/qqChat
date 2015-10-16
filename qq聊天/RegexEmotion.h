//
//  RegexEmotion.h
//  testRegexKitLite
//
//  Created by TomPro on 15/10/14.
//  Copyright © 2015年 TomPro. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface RegexEmotion : NSObject
/**
 *  标记是否表情
 */
@property (nonatomic,assign,getter = isEmotion) BOOL emotion;
/**
 *  字符串
 */
@property (nonatomic,copy) NSString *str;
/**
 *  截取的range
 */
@property (nonatomic,assign) NSRange range;

@end
