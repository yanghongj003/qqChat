//
//  ChatCell.m
//  qq聊天
//
//  Created by zpon on 15-4-11.
//  Copyright (c) 2015年 zpon. All rights reserved.
//

#import "ChatCell.h"
#import "UIImage+Extension.h"
#import "NSString+Extention.h"

@interface ChatCell ()
@property (nonatomic,strong)UILabel *timeLabel;
@property (nonatomic,strong)UIImageView *leftIcon;
@property (nonatomic,strong)UIImageView *rightIcon;
@property (nonatomic,strong)UIButton *leftContentBtn;
@property (nonatomic,strong)UIButton *rightContentBtn;
@end

@implementation ChatCell

+ (instancetype)chatCellWithTableView:(UITableView *)tableView{
    static NSString *ID = @"chatCell";
    ChatCell *cell      = [tableView dequeueReusableCellWithIdentifier:ID];
    if (cell == nil) {
    cell                = [[ChatCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:ID];
    }
    return cell;
}
- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        self.selectionStyle                      = UITableViewCellSelectionStyleNone;
        self.backgroundColor                     = [UIColor clearColor];
        // 1:添加时间label
        UILabel *timeLabel                       = [[UILabel alloc]init];
        timeLabel.textAlignment                  = NSTextAlignmentCenter;
        timeLabel.backgroundColor                = [UIColor clearColor];
        timeLabel.textColor                      = [UIColor blackColor];
        timeLabel.font                           = [UIFont systemFontOfSize:12];
        [self.contentView addSubview:timeLabel];
        self.timeLabel                           = timeLabel;
       // 2:添加左边聊天人头像
        UIImageView *leftIcon                    = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"other"]];
        [self.contentView addSubview:leftIcon];
        self.leftIcon                            = leftIcon;
       // 3:添加左边的聊天内容
        UIButton *leftContentBtn                 = [[UIButton alloc]init];
        UIImage *leftimageNor                    = [UIImage strengthImageWithName:@"chat_recive_nor"] ;
        UIImage *leftimagePress                  = [UIImage strengthImageWithName:@"chat_recive_press_pic"];
        [leftContentBtn setBackgroundImage:leftimagePress forState:UIControlStateNormal];
        [leftContentBtn setBackgroundImage:leftimageNor forState:UIControlStateHighlighted];
        [leftContentBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [leftContentBtn setTitleColor:[UIColor blackColor] forState:UIControlStateHighlighted];

        leftContentBtn.titleEdgeInsets           = UIEdgeInsetsMake(2.0*Kmargin, 2.0*Kmargin, 2.0*Kmargin, 2.0*Kmargin);
        leftContentBtn.titleLabel.font           = KFont;
        leftContentBtn.titleLabel.numberOfLines  = 0;

        [self.contentView addSubview:leftContentBtn];
        self.leftContentBtn                      = leftContentBtn;
        // 4:添加右边的icon

        UIImageView *rightIcon                   = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"me"]];
        [self.contentView addSubview:rightIcon];
        self.rightIcon                           = rightIcon;

        // 5:添加右边的聊天内容

        UIButton *rightContentBtn                = [[UIButton alloc]init];
        UIImage *rightimageNor                   = [UIImage strengthImageWithName:@"chat_send_nor"] ;
        UIImage *rightimagePress                 = [UIImage strengthImageWithName:@"chat_send_press_pic"];
        [rightContentBtn setBackgroundImage:rightimageNor forState:UIControlStateNormal];
        [rightContentBtn setBackgroundImage:rightimagePress forState:UIControlStateHighlighted];
        [rightContentBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [rightContentBtn setTitleColor:[UIColor blackColor] forState:UIControlStateHighlighted];
        rightContentBtn.titleEdgeInsets          = UIEdgeInsetsMake(2.0*Kmargin, 2.0*Kmargin, 2.0*Kmargin, 2.0*Kmargin );

        rightContentBtn.titleLabel.font          = KFont;
        rightContentBtn.titleLabel.numberOfLines = 0;

        [self.contentView addSubview:rightContentBtn];
        self.rightContentBtn                     = rightContentBtn;

    }
    return self;
}

- (void)setContentModel:(ChatContent *)contentModel{
        _contentModel               = contentModel;
        // 1:设置消息发送时间
        self.timeLabel.frame        = CGRectMake(0,Kmargin, KSceenW, KtimeH);
        self.timeLabel.text         = contentModel.time;
        self.timeLabel.hidden       = contentModel.hiddenTime;
        // 2:设置消息类型
        NSInteger type              = [contentModel.type integerValue];
        // 接收的消息
        if (!type) {
        self.leftIcon.hidden        = NO;
        self.leftContentBtn.hidden  = NO;
        self.rightIcon.hidden       = YES;
        self.rightContentBtn.hidden = YES;
            // 设置左边的聊天人头像
        CGFloat leftIconX           = Kmargin;
        CGFloat leftIconY           = CGRectGetMaxY(self.timeLabel.frame)+Kmargin;
        CGFloat leftIconW           = KiconW;
        CGFloat leftIconH           = kiconH;
        self.leftIcon.frame         = CGRectMake(leftIconX, leftIconY, leftIconW, leftIconH);
            // 设置接收的聊天内容
            [self.leftContentBtn setAttributedTitle:contentModel.attributedStr forState:UIControlStateNormal];
            [self.leftContentBtn setAttributedTitle:contentModel.attributedStr forState:UIControlStateHighlighted];
            // 设置接收的聊天内容frame

            // 文字的size
        //        CGSize size = [contentModel.text calculateSizeWithMaxWidth:KcontentW WithFont:KFont];

        CGSize size                 = [contentModel.attributedStr boundingRectWithSize:CGSizeMake(KcontentW, CGFLOAT_MAX) options:NSStringDrawingUsesLineFragmentOrigin context:nil].size;

        CGFloat  leftContentBtnX    = 2*Kmargin+KiconW;
        CGFloat  leftContentBtnY    = self.leftIcon.frame.origin.y;

            //按钮的真实size
        CGFloat  leftContentBtnW    = size.width+4*Kmargin;
        CGFloat  leftContentBtnH    = size.height+4*Kmargin;

        self.leftContentBtn.frame   = CGRectMake(leftContentBtnX,leftContentBtnY , leftContentBtnW, leftContentBtnH);
        }
        // 发送的消息
        else
        {
        self.leftIcon.hidden        = YES;
        self.leftContentBtn.hidden  = YES;
        self.rightIcon.hidden       = NO;
        self.rightContentBtn.hidden = NO;
        // 设置右边的聊天人头像
        CGFloat rightIconX   = KSceenW-Kmargin-KiconW;
        CGFloat rightIconY   = CGRectGetMaxY(self.timeLabel.frame)+Kmargin;
        CGFloat rightIconW   = KiconW;
        CGFloat rightIconH   = kiconH;
        self.rightIcon.frame = CGRectMake(rightIconX, rightIconY, rightIconW, rightIconH);
        // 设置发送的聊天内容
        [self.rightContentBtn setAttributedTitle:contentModel.attributedStr forState:UIControlStateNormal];
        [self.rightContentBtn setAttributedTitle:contentModel.attributedStr forState:UIControlStateHighlighted];

        // 设置聊天内容frame

        // 文字的size
        // CGSize size = [contentModel.text calculateSizeWithMaxWidth:KcontentW WithFont:KFont];
        CGSize size                 = [contentModel.attributedStr boundingRectWithSize:CGSizeMake(KcontentW, CGFLOAT_MAX) options:NSStringDrawingUsesLineFragmentOrigin context:nil].size;
           // 按钮真实的size
        CGFloat rightContentBtnW    = size.width+4*Kmargin;
        CGFloat rightContentBtnH    = size.height+4*Kmargin;
        CGFloat rightContentBtnX    = KSceenW-rightContentBtnW-2*Kmargin-KiconW;
        CGFloat rightContentBtnY    = self.rightIcon.frame.origin.y;

        self.rightContentBtn.frame  = CGRectMake(rightContentBtnX, rightContentBtnY, rightContentBtnW, rightContentBtnH);

        }
}

@end
