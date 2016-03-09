//
//  ManageViewController.m
//  SRPT Express
//
//  Created by 段昊宇 on 16/3/5.
//  Copyright © 2016年 Desgard_Duan. All rights reserved.
//

#import "ManageViewController.h"

@interface ManageViewController ()

@end

@implementation ManageViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationController.navigationBarHidden = NO;
    self.title = @"货单管理";
    self.view.backgroundColor = [UIColor colorWithRed: 240 / 255.f green: 241 / 255.f blue: 242 / 255.f alpha: 1];
    [self StartUp];
}

- (void) StartUp {
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

@end
