//
//  ChatViewController.m
//  qq聊天
//
//  Created by zpon on 15-4-10.
//  Copyright (c) 2015年 zpon. All rights reserved.
//

#import "ChatViewController.h"
#import "ChatView.h"
#import "ChatContent.h"
#import "ChatCell.h"
#import "EmotionView.h"
#import "Emotion.h"

#define Kconstant 11

@interface ChatViewController ()<UITableViewDataSource,UITableViewDelegate,UITextViewDelegate,ChatViewDelegate,EmotionViewDelegate>

@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (weak, nonatomic) IBOutlet ChatView *chatView;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *chatViewBottom;
@property (weak, nonatomic) IBOutlet UITextView *chatTextView;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *chatViewHeight;
@property (weak, nonatomic) IBOutlet UIImageView *chatImageView;
@property (strong,nonatomic) EmotionView *emotionView;
@property (strong,nonatomic) NSArray *dataArr;
@end

@implementation ChatViewController

#pragma mark -view生命周期方法
- (void)viewDidLoad {
    [super viewDidLoad];
    [self setUpView];
}
- (void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
    [self scrollToBottomAnimation:NO];
}
- (void)dealloc{
    [[NSNotificationCenter defaultCenter]removeObserver:self];
}

#pragma mark -初始化方法
/**
 *  设置View
 */
- (void)setUpView{
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.tableView.contentInset = UIEdgeInsetsMake(64, 0, 10, 0);

    self.chatView.delegate = self;
    self.chatTextView.delegate = self;
    // 1:监听键盘展示和隐藏
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(keyBoardShow:) name:UIKeyboardWillShowNotification object:nil];
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(keyBoardHidden:) name:UIKeyboardWillHideNotification object:nil];
    // 2:监听屏幕改变
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(reloadView) name:UIApplicationDidChangeStatusBarFrameNotification object:nil];
}
/**
 *  监听键盘弹起
 */
- (void)keyBoardShow:(NSNotification *)obj{
    
    // 1:动画时间
    CGFloat durationTime         = [[obj.userInfo objectForKey:UIKeyboardAnimationDurationUserInfoKey]floatValue];
    // 2:动画曲线
    NSInteger anitonCurve        = [[obj.userInfo objectForKey:UIKeyboardAnimationCurveUserInfoKey]integerValue];
    // 3:键盘结束的frame
    CGRect kbEndF                = [[obj.userInfo objectForKey:UIKeyboardFrameEndUserInfoKey]CGRectValue];
    [UIView animateWithDuration:durationTime animations:^{
        [UIView setAnimationBeginsFromCurrentState:YES];
        [UIView setAnimationCurve: anitonCurve];
    self.chatViewBottom.constant = kbEndF.size.height;
        [self.view layoutIfNeeded];
    } completion:^(BOOL finished) {
    self.emotionView.y           = self.view.height;
        [self scrollToBottomAnimation:YES];
    }];
}
/**
 *  监听键盘隐藏
 */
- (void)keyBoardHidden:(NSNotification *)obj{
    
    // 1:动画时间
    CGFloat durationTime         = [[obj.userInfo objectForKey:UIKeyboardAnimationDurationUserInfoKey]floatValue];
    // 2:动画曲线
    NSInteger anitonCurve        = [[obj.userInfo objectForKey:UIKeyboardAnimationCurveUserInfoKey]integerValue];
    [UIView animateWithDuration:durationTime animations:^{
        [UIView setAnimationBeginsFromCurrentState:YES];
        [UIView setAnimationCurve: anitonCurve];
    self.chatViewBottom.constant = 0;
        [self.view layoutIfNeeded];
    } completion:^(BOOL finished) {
        [self scrollToBottomAnimation:YES];
    }];
}

/**
 *  表情view
 */
- (EmotionView *)emotionView{
    
    if (!_emotionView) {
         _emotionView = [[EmotionView alloc] init];
        CGSize size = [UIScreen mainScreen].bounds.size;
        _emotionView.frame = CGRectMake(0, size.height, 0, 0);
        _emotionView.delegate = self;
        [self.view addSubview:_emotionView];
    }
    return _emotionView;
}
/**
 *  数据懒加载
 */
- (NSArray *)dataArr{
    if (!_dataArr) {
        NSString *path = [[NSBundle mainBundle]pathForResource:@"messages.plist" ofType:nil];
        NSArray *arr = [NSArray arrayWithContentsOfFile:path];
        NSMutableArray *temp = [NSMutableArray array];
        for (NSDictionary *dic in arr) {
            ChatContent *content = [ChatContent chatContentWithDic:dic];
            ChatContent *last = [temp lastObject];
            if ([last.time isEqualToString:content.time]) {
                content.hiddenTime = YES;
            }
            [temp addObject:content];
        }
        _dataArr = [temp copy];
    }
    return _dataArr;
}
#pragma mark -私有方法
/**
 *  刷新View
 */
- (void)reloadView{
    [self.tableView reloadData];
}
/**
 *  发送消息
 */
- (void)sendMessage:(NSString *)content
{
    // 过滤空格和换行字符
    content = [content stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
    if (content.length>0) {
        NSDictionary *contentDic = @{@"text":content,@"time":@"刚刚",@"type":@(1)};
        ChatContent  *model = [ChatContent chatContentWithDic:contentDic];
        NSMutableArray *temp = [NSMutableArray arrayWithArray:self.dataArr];
        ChatContent *last = [temp lastObject];
        if ([last.time isEqualToString:model.time]) {
            model.hiddenTime = YES;
        }
        [temp addObject:model];
        self.dataArr = temp;
        [self.tableView reloadData];
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.2 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            [self scrollToBottomAnimation:YES];
        });
        
    }
}
/**
 *  滚动tableView到最下方
 */
- (void)scrollToBottomAnimation:(BOOL)animation{
    NSIndexPath *bottomIndex = [NSIndexPath indexPathForRow:self.dataArr.count -1 inSection:0];
    [self.tableView scrollToRowAtIndexPath:bottomIndex atScrollPosition:UITableViewScrollPositionBottom animated:animation];
}

#pragma mark - tableView delegate

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.dataArr.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    ChatCell *cell = [ChatCell chatCellWithTableView:tableView];
    cell.contentModel = self.dataArr[indexPath.row];
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
     ChatContent *content = self.dataArr[indexPath.row];
    // CGSize  size = [content.attributedStr.string calculateSizeWithMaxWidth:KcontentW WithFont:KFont];
     CGSize size =    [content.attributedStr boundingRectWithSize:CGSizeMake(KcontentW, CGFLOAT_MAX) options:NSStringDrawingUsesLineFragmentOrigin context:nil].size;
     return size.height+10*Kmargin;
}

#pragma mark - UIScrollViewDelegate
- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView{
    [self.view endEditing:YES];
    if (self.emotionView.y<self.view.height) {
        [UIView animateWithDuration:0.25 animations:^{
            self.chatViewBottom.constant = 0;
            self.emotionView.y = self.view.height;
            [self.view layoutIfNeeded];
        }completion:nil];
    }
}

#pragma mark -textView delegate
- (BOOL)textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text{
    if ([text isEqualToString:@"\n"]) {
        [self sendMessage:textView.attributedText.string];
        textView.attributedText = nil;
        textView.text = nil;
        self.chatViewHeight.constant = 44;
        return NO;
    }
    return YES;
}
- (void)textViewDidChange:(UITextView *)textView{
    // 1:改变textView的高度
    if(textView.contentSize.height>=81){
        self.chatViewHeight.constant=81+Kconstant;
        [self.chatTextView scrollRangeToVisible:NSMakeRange(textView.attributedText.length-5, textView.attributedText.length)];
    }
    else{
       self.chatViewHeight.constant = textView.contentSize.height+Kconstant;
    }
}
#pragma mark - ChatViewDelegate
- (void)chatViewDelegateEmotionAction{
    if (self.emotionView.y>=self.view.height) {
        [self.view endEditing:YES];
        [UIView animateWithDuration:0.25 animations:^{
            self.chatViewBottom.constant = self.emotionView.height;
            self.emotionView.y           = self.view.height-self.emotionView.height;
            [self.view layoutIfNeeded];
        } completion:nil];
    }else {
        [UIView animateWithDuration:0.25 animations:^{
            self.chatViewBottom.constant = 0;
            self.emotionView.y           = self.view.height;
            [self.view layoutIfNeeded];
        }completion:nil];
    }
}
- (void)chatViewDelegateSoundAction{

}
- (void)chatViewDelegateAddAction{


}
#pragma mark - EmotionViewDelegate

- (void)emotionViewDelegateClickEmotion:(Emotion *)emotion{

    NSMutableAttributedString *origalAttribute = [[NSMutableAttributedString alloc] init];
    [origalAttribute appendAttributedString:self.chatTextView.attributedText];
    NSTextAttachment *attachment               = [[NSTextAttachment alloc] initWithData:nil ofType:nil];
    attachment.image                           = [UIImage imageNamed:emotion.emotionImageName];
    attachment.bounds                          = CGRectMake(0, -3, self.chatTextView.font.lineHeight, self.chatTextView.font.lineHeight);
    NSAttributedString *attributeStr           = [[NSAttributedString alloc]initWithString:emotion.text];
    [origalAttribute appendAttributedString:attributeStr];

    [origalAttribute addAttribute:NSFontAttributeName value:self.chatTextView.font range:NSMakeRange(0, origalAttribute.length)];
    self.chatTextView.attributedText           = origalAttribute;

    // 强制调用文本改变代理方法(富文本改变不会调用textView代理方法)
    [self textViewDidChange:self.chatTextView];
}

@end
