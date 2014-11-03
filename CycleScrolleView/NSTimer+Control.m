//
//  NSTimer+Control.m
//  CycleScrolleView
//
//  Created by je_ffy on 14/11/4.
//  Copyright (c) 2014年 je_ffy. All rights reserved.
//

#import "NSTimer+Control.h"

@implementation NSTimer (Control)

- (void)pauseTimer {
    if (![self isValid]) {
        return;
    }
    [self setFireDate:[NSDate distantFuture]];
}


- (void)resumeTimeAfterTimerInterval:(NSTimeInterval)interval {
    if (![self isValid]) {
        return;
    }
    [self setFireDate:[NSDate dateWithTimeIntervalSinceNow:interval]];
}


@end
