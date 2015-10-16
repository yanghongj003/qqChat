//
//  ChatContent.h
//  qq聊天
//
//  Created by zpon on 15-4-10.
//  Copyright (c) 2015年 zpon. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ChatContent : NSObject
/**
 *  文本内容
 */
@property (nonatomic,copy)   NSString *text;
/**
 *  发送时间
 */
@property (nonatomic,copy)   NSString *time;
/**
 *  类型（发送/接收）
 */
@property (nonatomic,strong) NSNumber *type;
/**
 *  是否需要隐藏时间
 */
@property (nonatomic,assign) BOOL hiddenTime;
/**
 *  转换后的富文本
 */
@property (nonatomic,copy) NSAttributedString *attributedStr;

+ (instancetype)chatContentWithDic:(NSDictionary *)dic;

- (instancetype)initWithDic:(NSDictionary *)dic;
@end
