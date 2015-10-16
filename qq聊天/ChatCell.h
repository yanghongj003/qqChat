//
//  ChatCell.h
//  qq聊天
//
//  Created by zpon on 15-4-11.
//  Copyright (c) 2015年 zpon. All rights reserved.
//

#import                                            <UIKit/UIKit.h>
#import                                            "ChatContent.h"
#define KFont [UIFont                              systemFontOfSize:15]
#define Kmargin                                    10
#define KiconW                                     40
#define kiconH                                     40
#define KSceenW [UIScreen                          mainScreen].bounds.size.width
#define KtimeH                                     30
#define KcontentW                                  (KSceenW-KiconW-6*Kmargin)

@interface ChatCell :                              UITableViewCell
@property (nonatomic,strong)ChatContent            *contentModel;

+ (instancetype)chatCellWithTableView:(UITableView *)tableView;

@end
