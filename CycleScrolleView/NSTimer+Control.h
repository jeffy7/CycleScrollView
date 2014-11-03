//
//  NSTimer+Control.h
//  CycleScrolleView
//
//  Created by je_ffy on 14/11/4.
//  Copyright (c) 2014年 je_ffy. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSTimer (Control)


- (void)pauseTimer;
- (void)resumeTimeAfterTimerInterval:(NSTimeInterval)interval;
@end
