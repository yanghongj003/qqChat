//
//  EmotionView.m
//  qq聊天
//
//  Created by TomPro on 15/10/15.
//  Copyright © 2015年 zpon. All rights reserved.
//

#import "EmotionView.h"
#import "EmotionButton.h"
#import "Emotion.h"

#define KColumncount 7
#define KRowCount 3
#define KEmotionWidth 36
#define KEmotionHeigth 36

@interface EmotionView ()  <UIScrollViewDelegate>
@property (nonatomic,weak)   UIScrollView *scrollView;
@property (nonatomic,strong) NSMutableArray *emotionBtnS;
@property (nonatomic,weak)   UIPageControl *pageControl;
@end

@implementation EmotionView

- (instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        // 1:设置滚动View
        [self setUpScrollView];
        // 2:设置页面指示器
        [self setUpPageCtrol];
    }
    return self;
}
- (void)setFrame:(CGRect)frame{
    frame.size.width = [UIScreen mainScreen].bounds.size.width;
    frame.size.height = 200;
    [super setFrame:frame];
}
- (void)layoutSubviews{
    [super layoutSubviews];
    
    // 1:设置scrollView 的frame
    self.scrollView.frame = self.bounds;
    unsigned long pageCount = self.emotionBtnS.count/(KColumncount*KRowCount)+(self.emotionBtnS.count%(KColumncount*KRowCount)?1:0);
    self.scrollView.contentSize = CGSizeMake(self.width*pageCount, 0);
    
    // 1.1设置scrollView里面按钮的frame
    CGFloat marginX = (self.width - (CGFloat)KColumncount*KEmotionWidth)/(KColumncount+1);
    CGFloat marginY = (self.height - (CGFloat)KRowCount*KEmotionHeigth)/(KRowCount+1);
    for (int j= 0; j<self.emotionBtnS.count; j++) {
        unsigned long page = j/(KColumncount*KRowCount);
        unsigned long row = (j-page*KColumncount*KRowCount)/KColumncount;
        unsigned long column = (j-page*KColumncount*KRowCount)%KColumncount;
        EmotionButton *btn = [self.emotionBtnS objectAtIndex:j];
        CGFloat btnX = marginX*(column+1)+column*KEmotionWidth+page*self.width;
        CGFloat btnY = marginY*(row+1)+row*KEmotionHeigth;
        CGFloat btnW = KEmotionWidth;
        CGFloat btnH = KEmotionHeigth;
        btn.frame = CGRectMake(btnX, btnY, btnW, btnH);
    }
    // 2:设置页面指示器的frame
    self.pageControl.numberOfPages = pageCount;
    self.pageControl.bounds = CGRectMake(0, 0, 100, 30);
    self.pageControl.center = CGPointMake(self.center.x, self.height-15);
}
#pragma  mark -初始化方法
/**
 *  设置scrollView
 */
- (void)setUpScrollView{
    UIScrollView *scrollView = [[UIScrollView alloc] init];
    scrollView.pagingEnabled = YES;
    scrollView.showsHorizontalScrollIndicator = NO;
    scrollView.showsVerticalScrollIndicator = NO;
    scrollView.delegate = self;
    for (int j=1; j<100; j++) {
        EmotionButton *emotionBtn = [EmotionButton buttonWithType:UIButtonTypeCustom];
        emotionBtn.tag = j;
        NSString *imageName = [NSString stringWithFormat:@"Expression_%d",j];
        [emotionBtn setBackgroundImage:[UIImage imageNamed:imageName] forState:UIControlStateNormal];
        [emotionBtn addTarget:self action:@selector(emotionBtnAtion:) forControlEvents:UIControlEventTouchUpInside];
        [scrollView addSubview:emotionBtn];
        [self.emotionBtnS addObject:emotionBtn];
    }
    [self addSubview:scrollView];
    self.scrollView = scrollView;
}
/**
 *  设置页面指示器
 */
- (void)setUpPageCtrol{
    UIPageControl *pageControl = [[UIPageControl alloc] init];
    pageControl.currentPage = 0;
    pageControl.pageIndicatorTintColor = [UIColor blackColor];
      pageControl.currentPageIndicatorTintColor = [UIColor redColor];
    [self addSubview:pageControl];
    self.pageControl = pageControl;
}
/**
 *  表情按钮数组懒加载
 */
- (NSMutableArray *)emotionBtnS {
    if (_emotionBtnS==nil) {
        _emotionBtnS = [NSMutableArray array];
    }
    return _emotionBtnS;
}
#pragma mark －监听按钮点击
- (void)emotionBtnAtion:(EmotionButton*)btn{
    if ([self.delegate respondsToSelector:@selector(emotionViewDelegateClickEmotion:)])
    {
        Emotion *emotion = [[Emotion alloc] init];
        emotion.text = [NSString stringWithFormat:@"[%ld]",(long)btn.tag];
        emotion.emotionImageName = [NSString stringWithFormat:@"Expression_%ld",(long)btn.tag];
        [self.delegate emotionViewDelegateClickEmotion:emotion];
    }
}

#pragma mark - scrollViewDelegate
- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView{
    self.pageControl.currentPage = scrollView.contentOffset.x/self.width+0.5;
}
@end
