//
//  ViewController.m
//  KL_TextView
//
//  Created by 赵凯乐 on 2018/3/22.
//  Copyright © 2018年 赵凯乐. All rights reserved.
//

#import "ViewController.h"
#import "KLTextView.h"
@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    KLTextView *textview = [[KLTextView alloc]initWithFrame:CGRectMake(20, 120, 300, 40)];
    textview.placeholder = @"占位符阿斯顿";
    textview.textColor = [UIColor redColor];
    textview.textAlignment = NSTextAlignmentLeft;
    textview.font = [UIFont systemFontOfSize:15];
    
    [self.view addSubview:textview];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
