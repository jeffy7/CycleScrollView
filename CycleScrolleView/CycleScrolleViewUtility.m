//
//  CycleScrolleViewUtility.m
//  CycleScrolleView
//
//  Created by je_ffy on 14/11/3.
//  Copyright (c) 2014年 je_ffy. All rights reserved.
//

#import "CycleScrolleViewUtility.h"



const static NSTimeInterval _interval = 3.0f;
#define RELEASE_SADELY(__POINTER) { if(__POINTER){[__POINTER release];__POINTER = nil;} }

@implementation CycleScrolleViewUtility
@synthesize scrollerView = _scrollerView;
@synthesize currentView = _currentView;
@synthesize totalPage = _totalPage;
@synthesize currentPage = _currentPage;
@synthesize scrollFrame = _scrollFrame;
@synthesize imageArray = _imageArray;
@synthesize scrollArray = _scrollArray;
@synthesize timer = _timer;

- (void)dealloc {
    RELEASE_SADELY(_scrollerView);
    RELEASE_SADELY(_currentView);
    RELEASE_SADELY(_imageArray);
    RELEASE_SADELY(_scrollArray);

    if (_timer) {
        [_timer invalidate];
        _timer = nil;
    }
    [super dealloc];
}


- (id)initScrolleViewWithFrame:(CGRect)frame direction:(CycleDirection)direction pictures:(NSArray *)pictureArray {
    self = [super initWithFrame:frame];
    if (self) {
        _scrollFrame = frame;
        _scrollDirection = direction;
        _totalPage = pictureArray.count;
        _currentPage = 1;
        _scrollArray = [[NSMutableArray alloc] init];
        _imageArray = [[NSArray alloc]initWithArray: pictureArray];
        
        _scrollerView = [[UIScrollView alloc] initWithFrame:frame];
        _scrollerView.backgroundColor = [UIColor whiteColor];
        _scrollerView.showsVerticalScrollIndicator = NO;
        _scrollerView.showsHorizontalScrollIndicator = NO;
        _scrollerView.pagingEnabled = YES;
        _scrollerView.delegate = self;
        
        if (direction == CycleDirectionHorizontal) {
            _scrollerView.contentSize = CGSizeMake(_scrollerView.frame.size.width*3, _scrollerView.frame.size.height);
        }else if(direction == CycleDirectionVertical) {
            _scrollerView.contentSize = CGSizeMake(_scrollerView.frame.size.width, _scrollerView.frame.size.height*3);
        }
        [self addSubview:_scrollerView];
        
        [self refreshScrollView];
        if ([pictureArray count] > 0) {
            [self addTimer];

        }
        
    }
    return self;
}


- (void)addTimer {
    _timer = [NSTimer scheduledTimerWithTimeInterval:_interval
                                              target:self
                                            selector:@selector(startAnimation)
                                            userInfo:nil
                                             repeats:YES];
    [_timer resumeTimeAfterTimerInterval:_interval];
}

- (void)refreshScrollView {
    NSArray *subView = [_scrollerView subviews];
    if ([subView count]!= 0) {
        [subView makeObjectsPerformSelector:@selector(removeFromSuperview)];
    }
    
    [self displayImageArrayWithCurrentPage:_currentPage];
    
    [_scrollArray enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
        UIImageView *imageView = [[UIImageView alloc] initWithFrame:_scrollFrame];
        imageView.userInteractionEnabled = YES;
        imageView.image = [_scrollArray objectAtIndex:idx];
        
        if (_scrollDirection == CycleDirectionHorizontal) {
            //水平滚动
            imageView.frame = CGRectOffset(imageView.frame, _scrollFrame.size.width*idx, 0);
        }else if (_scrollDirection == CycleDirectionVertical){
            //竖直滚动
            imageView.frame = CGRectOffset(imageView.frame, 0,_scrollFrame.size.height*idx);
        }
        
        [_scrollerView addSubview:imageView];
        [imageView release];
    }];
    
    
    if (_scrollDirection == CycleDirectionHorizontal) {
        _scrollerView.contentOffset = CGPointMake(_scrollFrame.size.width, 0);
    }else if(_scrollDirection == CycleDirectionVertical) {
        _scrollerView.contentOffset = CGPointMake(0, _scrollFrame.size.height);
    }
    
    
}


- (void)displayImageArrayWithCurrentPage:(NSInteger)page {
    NSInteger prePage = [self validPagevalue:_currentPage-1];
    NSInteger laterPage = [self validPagevalue:_currentPage+1];
    
    if([_scrollArray count] != 0) [_scrollArray removeAllObjects];

    [_scrollArray addObject:[_imageArray objectAtIndex:prePage-1]];
    [_scrollArray addObject:[_imageArray objectAtIndex:_currentPage-1]];
    [_scrollArray addObject:[_imageArray objectAtIndex:laterPage -1]];
    
}


//转化为有效的 Page
- (NSInteger)validPagevalue:(NSInteger)value {
    if (value == 0) {
        value = _totalPage;
    }
    
    if (value == _totalPage + 1) {
        value = 1;
    }
    return value;
}

#pragma mark
#pragma mark - ScrollView Delegate
- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    int x = scrollView.contentOffset.x;
    int y = scrollView.contentOffset.y;
    
    if (_scrollDirection == CycleDirectionHorizontal) {

        if (x >= _scrollFrame.size.width*2) {
            _currentPage = [self validPagevalue:_currentPage+1];
            [self refreshScrollView];
        }
        if (x <= 0) {
            _currentPage = [self validPagevalue:_currentPage-1];
            [self refreshScrollView];
        }
    }else if(_scrollDirection == CycleDirectionVertical) {

        if (y >= _scrollFrame.size.height*2) {
            _currentPage = [self validPagevalue:_currentPage +1];
            [self refreshScrollView];
        }
        if (y <= 0) {
            _currentPage = [self validPagevalue:_currentPage-1];
            [self refreshScrollView];
        }
        
    }
    
}

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView {
    if (_scrollDirection == CycleDirectionHorizontal) {
        [_scrollerView setContentOffset:CGPointMake(_scrollFrame.size.width, 0) animated:YES];
        
    }else if(_scrollDirection == CycleDirectionVertical) {
        
        [_scrollerView setContentOffset:CGPointMake(0, _scrollerView.frame.size.height) animated:YES];
        
    }
}


- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView {
    [_timer pauseTimer];
}


- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate {
    [_timer resumeTimeAfterTimerInterval:_interval];

}


- (void)startAnimation {
    if (_scrollDirection == CycleDirectionVertical) {
        [_scrollerView setContentOffset:CGPointMake(_scrollerView.contentOffset.x,_scrollerView.contentOffset.y*2) animated:YES];
    }else if (_scrollDirection == CycleDirectionHorizontal) {
        [_scrollerView setContentOffset:CGPointMake(_scrollerView.contentOffset.x*2,_scrollerView.contentOffset.y) animated:YES];
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
