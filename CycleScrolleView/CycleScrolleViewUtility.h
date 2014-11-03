//
//  CycleScrolleViewUtility.h
//  CycleScrolleView
//
//  Created by je_ffy on 14/11/3.
//  Copyright (c) 2014年 je_ffy. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "NSTimer+Control.h"

typedef enum {
    CycleDirectionHorizontal,   //横向滚动
    CycleDirectionVertical      //纵向滚动
}CycleDirection;
@interface CycleScrolleViewUtility : UIView <UIScrollViewDelegate> {
    UIScrollView *_scrollerView;
    UIImageView *_currentView;
    NSUInteger _totalPage;
    NSUInteger _currentPage;
    CGRect _scrollFrame;
    CycleDirection _scrollDirection;
    NSArray *_imageArray;
    NSMutableArray *_scrollArray;
    NSTimer *_timer;
    
}

@property (nonatomic, retain) UIScrollView *scrollerView;
@property (nonatomic, retain) UIImageView *currentView;
@property (nonatomic, assign) NSUInteger totalPage;
@property (nonatomic, assign) NSUInteger currentPage;
@property (nonatomic, assign) CGRect scrollFrame;
@property (nonatomic, assign) CycleDirection scrollDirection;
@property (nonatomic, retain) NSArray *imageArray;
@property (nonatomic, retain) NSMutableArray *scrollArray;
@property (nonatomic, retain) NSTimer *timer;


- (id)initScrolleViewWithFrame:(CGRect)frame direction:(CycleDirection)direction pictures:(NSArray *)pictureArray;



@end
