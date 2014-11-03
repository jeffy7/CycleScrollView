//
//  ViewController.m
//  CycleScrolleView
//
//  Created by je_ffy on 14/11/3.
//  Copyright (c) 2014年 je_ffy. All rights reserved.
//

#import "ViewController.h"
#import "CycleScrolleViewUtility.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    NSMutableArray *array = [[NSMutableArray alloc] init];
    [array addObject:[UIImage imageNamed:@"0.jpg"]];
    [array addObject:[UIImage imageNamed:@"1.jpg"]];
    [array addObject:[UIImage imageNamed:@"2.jpg"]];
    [array addObject:[UIImage imageNamed:@"3.jpg"]];
    [array addObject:[UIImage imageNamed:@"4.jpg"]];
    [array addObject:[UIImage imageNamed:@"5.jpg"]];
    [array addObject:[UIImage imageNamed:@"6.jpg"]];
    [array addObject:[UIImage imageNamed:@"7.jpg"]];
    [array addObject:[UIImage imageNamed:@"8.jpg"]];

    CycleScrolleViewUtility *cycleScrollView = [[CycleScrolleViewUtility alloc] initScrolleViewWithFrame:self.view.bounds direction:CycleDirectionHorizontal pictures:array];
    [self.view addSubview:cycleScrollView];
    [cycleScrollView release];
    [array release];
    

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
