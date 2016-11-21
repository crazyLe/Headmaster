//
//  HomeBannerView.m
//  wills
//
//  Created by ai_ios on 16/4/18.
//  Copyright © 2016年 ai_ios. All rights reserved.
//

#import "HomeBannerView.h"
#import <UIImageView+WebCache.h>
#import "BannerModel.h"

@interface HomeBannerView ()<UIScrollViewDelegate>{
    /// 当前页码
    NSInteger _currentPage;
    NSInteger _pageAmount;
    dispatch_source_t _timer;
    dispatch_queue_t _queue;
    BannerModel *model;
}
@property (nonatomic, retain) NSMutableArray *imgViewArray;
@property (nonatomic, retain) NSArray *dataArray;
@property (nonatomic, retain) UIImage *placeImg;
@property (nonatomic, retain) UIPageControl *pageControl;
@property (nonatomic, assign) BOOL isHome;

@end

@implementation HomeBannerView

- (instancetype)initWithFrame:(CGRect)frame placeImgName:(NSString *)imgName isHomePage:(BOOL)isHomePage
{
    self = [super initWithFrame:frame];
    if (self) {
        _isHome = isHomePage;
       // _scrollview = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, frame.size.height)];
        if ([_scrollerFrom isEqualToString:@"ADContractHeardView"]) {
            _scrollview = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 7*HHeader,204*WHeader, 103*HHeader)];
        }else{
         _scrollview = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, kWidth, frame.size.height)];
        }
        _scrollview.delegate = self;
        _scrollview.pagingEnabled = YES;
        _scrollview.showsHorizontalScrollIndicator = NO;
        _scrollview.showsVerticalScrollIndicator = NO;
        _scrollview.bounces = NO;
        _scrollview.scrollEnabled = NO;
        _scrollview.contentSize = CGSizeMake(_scrollview.frame.size.width * 3, 0);
        [_scrollview setContentOffset:CGPointMake(_scrollview.frame.size.width, 0)];
        [self addSubview:_scrollview];
        _placeImg = [UIImage imageNamed:imgName];
        _pageAmount = 1;
        [self makeScrollView];
        [self configPageControl:frame.size.height];
    }
    return self;
}
- (instancetype)initWithFrame:(CGRect)frame placeImgName:(NSString *)imgName scrollerFrom:(NSString*)scrollerFrom{
    self = [super initWithFrame:frame];
    if (self) {
 
        _scrollview = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0,204*WHeader, 103*HHeader)];
        _scrollview.delegate = self;
        _scrollview.pagingEnabled = YES;
        _scrollview.showsHorizontalScrollIndicator = NO;
        _scrollview.showsVerticalScrollIndicator = NO;
        _scrollview.bounces = NO;
        _scrollview.scrollEnabled = NO;
        _scrollview.contentSize = CGSizeMake(_scrollview.frame.size.width * 3, 0);
        [_scrollview setContentOffset:CGPointMake(_scrollview.frame.size.width, 0)];
        [self addSubview:_scrollview];
        _placeImg = [UIImage imageNamed:imgName];
        _pageAmount = 1;
        [self makeScrollView];
        [self configPageControl:frame.size.height];
    }
    return self;
}
- (instancetype)initWithFrame:(CGRect)frame placeImgName:(NSString *)imgName;
{
    self = [super initWithFrame:frame];
    if (self) {
        _scrollview = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, kWidth, frame.size.height)];
        if ([_scrollerFrom isEqualToString:@"ADContractHeardView"]) {
          _scrollview = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 7*HHeader,204+WHeader, 103*HHeader)];
        }
        [self addSubview:_scrollview];
        _scrollview.delegate = self;
        _scrollview.pagingEnabled = YES;
        _scrollview.showsHorizontalScrollIndicator = NO;
        _scrollview.showsVerticalScrollIndicator = NO;
        _scrollview.bounces = NO;
        _scrollview.scrollEnabled = NO;
        _scrollview.contentSize = CGSizeMake(_scrollview.frame.size.width * 3, 0);
        [_scrollview setContentOffset:CGPointMake(_scrollview.frame.size.width, 0)];
        _placeImg = [UIImage imageNamed:imgName];
        _pageAmount = 1;
        [self makeScrollView];
        
        [self configPageControl:frame.size.height];
        _pageControl.hidden = YES;
    }
    return self;
}

- (void)configPageControl:(CGFloat)height
{
    _pageControl = [[UIPageControl alloc] initWithFrame:CGRectMake((_scrollview.frame.size.width ) / 2-50, height - 15, 100, 10)];
    _pageControl.numberOfPages = 1;
    [self addSubview:_pageControl];
    _pageControl.hidden = YES;
}

- (void)makeScrollView
{
    if (!_imgViewArray) {
        _imgViewArray = [@[] mutableCopy];
    }
    for (int i = 0; i < 3; i++) {
        UIImageView *imgView = [[UIImageView alloc] initWithFrame:CGRectMake(_scrollview.frame.size.width * i, 0, _scrollview.frame.size.width, self.frame.size.height)];
        imgView.image = _placeImg;
        imgView.contentMode = UIViewContentModeScaleToFill;
        imgView.userInteractionEnabled = YES;
        [_scrollview addSubview:imgView];
        [_imgViewArray addObject:imgView];
        
        UITapGestureRecognizer *gesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(touchGesture:)];
        [imgView addGestureRecognizer:gesture];

    }
    _currentPage = 0;
}

- (void)touchGesture:(UITapGestureRecognizer *)gesture
{
   // NSLog(@"第%ld张图%@",(long)_currentPage,_dataArray[_currentPage]);
    if (self.delegate&&[self.delegate respondsToSelector:@selector(homeBannerView:withindex:)]) {
        [self.delegate homeBannerView:self withindex:[NSString stringWithFormat:@"%ld", (long)_currentPage]];
    }
    if ([self.delegate respondsToSelector:@selector(homeBannerViewCilekedBanner:)]) {
        [self.delegate homeBannerViewCilekedBanner:model];
    }
}

- (void)refreshData:(NSArray *)array
{
    if (array) {
        _dataArray = [array copy];
        _pageAmount = _dataArray.count;
        _currentPage = 0;
        _pageControl.numberOfPages = _pageAmount;
        if (_pageAmount <= 1) {
            _scrollview.bounces = NO;
            _scrollview.scrollEnabled = NO;
        } else {
            _scrollview.bounces = YES;
            _scrollview.scrollEnabled = YES;
        }
        [self resetImg];
        if (array.count > 1) {
            _pageControl.hidden = NO;
        }
    }
    if (_pageAmount > 1) {
        [self runImg];
    }
}

- (void)runImg
{
    __weak typeof(self) weakself = self;
    _queue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
    _timer = dispatch_source_create(DISPATCH_SOURCE_TYPE_TIMER, 0, 0,_queue);
    dispatch_source_set_timer(_timer,dispatch_walltime(NULL, 5.0*NSEC_PER_SEC),5.0*NSEC_PER_SEC, 0); //每5秒执行
    dispatch_source_set_event_handler(_timer, ^{
        dispatch_async(dispatch_get_main_queue(), ^{
            [weakself.scrollview setContentOffset:CGPointMake(_scrollview.frame.size.width * 2, 0) animated:YES];
        });
    });
    dispatch_resume(_timer);
}

- (void)contentOffsetChange
{
    if (_pageAmount > 1) {
        [_scrollview setContentOffset:CGPointMake(_scrollview.frame.size.width * 2, 0) animated:YES];
    }
    
}

- (NSInteger)currentPageCaculate:(NSInteger)curPage
{
    if (curPage < 0) {
        return _pageAmount - 1;
    }
    if (curPage >= _pageAmount) {
        return 0;
    }
    return curPage;
}

- (void)resetImg
{
    [_imgViewArray enumerateObjectsUsingBlock:^(UIImageView *imgView, NSUInteger idx, BOOL *stop) {
        NSString *urlStr = nil;
        
        if (idx == 0) {
            model = _dataArray[[self currentPageCaculate:_currentPage - 1]];
//            urlStr = _dataArray[[self currentPageCaculate:_currentPage - 1]];
        }
        if (idx == 1) {
            model = _dataArray[[self currentPageCaculate:_currentPage]];
//            urlStr = _dataArray[[self currentPageCaculate:_currentPage]];
        }
        if (idx == 2) {
            model = _dataArray[[self currentPageCaculate:_currentPage + 1]];
//            urlStr = _dataArray[[self currentPageCaculate:_currentPage + 1]];
        }
        urlStr = model.imgUrl;
        imgView.userInteractionEnabled = YES;
//        if (1 == [model.pageType intValue]) {
//            imgView.userInteractionEnabled = NO;
//        }
        [imgView sd_setImageWithURL:[NSURL URLWithString:urlStr] placeholderImage:_placeImg];
    }];
}



#pragma mark delegate
- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    if (scrollView.contentOffset.x > (_scrollview.frame.size.width * 2 - 10)) {
        scrollView.contentOffset = CGPointMake(scrollView.contentOffset.x - _scrollview.frame.size.width, 0);
        _currentPage = [self currentPageCaculate:_currentPage + 1];
        [self resetImg];
    }
    if (scrollView.contentOffset.x < 10) {
        scrollView.contentOffset = CGPointMake(scrollView.contentOffset.x + _scrollview.frame.size.width, 0);
        _currentPage = [self currentPageCaculate:_currentPage - 1];
        [self resetImg];
    }
    
    _pageControl.currentPage = _currentPage;
}

- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView
{
    dispatch_suspend(_timer);
}

- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate
{
    dispatch_source_set_timer(_timer,dispatch_walltime(NULL, 5.0*NSEC_PER_SEC),5.0*NSEC_PER_SEC, 0);
    dispatch_resume(_timer);
}

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
    if (_pageAmount > 1) {
        if (((NSInteger)scrollView.contentOffset.x) % ((NSInteger)_scrollview.frame.size.width) != 0) {
            [scrollView setContentOffset:CGPointMake(_scrollview.frame.size.width, 0) animated:YES];
        }
    }
}


/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
