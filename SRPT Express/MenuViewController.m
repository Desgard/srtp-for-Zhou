//
//  MenuViewController.m
//  SRPT Express
//
//  Created by 段昊宇 on 16/3/5.
//  Copyright © 2016年 Desgard_Duan. All rights reserved.
//

#import "MenuViewController.h"
#import "ViewController.h"
#import "IconTableViewCell.h"
#import "OneTableViewCell.h"
#import <UIKit/UIKit.h>

static NSString *const CellReuseId = @"MainMenu";

@interface MenuViewController () <UITableViewDataSource, UITableViewDelegate>
@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) NSArray *tabelArr;
@end

@implementation MenuViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.tabelArr = @[@"header", @"钱包", @"我的收藏", @"优惠活动", @"帮助中心", @"邀请有奖", @"设置"];
    self.tableView.backgroundColor = [UIColor colorWithRed: 74 / 255.f green:74 / 255.f  blue:74 / 255.f  alpha:1];
    [self.view addSubview: self.tableView];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

- (NSInteger) tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.tabelArr.count;
}

- (id) tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    OneTableViewCell *cell = (OneTableViewCell *)[tableView dequeueReusableCellWithIdentifier: @"OneTableViewCell"];
    IconTableViewCell *header = (IconTableViewCell *)[tableView dequeueReusableCellWithIdentifier: @"IconTableViewCell"];
    if (indexPath.row == 0) {
        if (header == nil) {
            NSArray *nib = [[NSBundle mainBundle] loadNibNamed: @"IconTableViewCell" owner: self options: nil];
            header = [nib objectAtIndex: 0];
        }
        header.selectionStyle = UITableViewCellSelectionStyleNone;
        return header;
    } else {
        if (cell == nil) {
            NSArray *nib = [[NSBundle mainBundle] loadNibNamed: @"OneTableViewCell" owner: self options: nil];
            cell = [nib objectAtIndex: 0];
        }
        cell.text.text = _tabelArr[indexPath.row];
        [cell.icon setImage:[UIImage imageNamed: [NSString stringWithFormat: @"menu_%ld", (long)indexPath.row]]];
        return cell;
    }
    return cell;
}

- (UITableView *) tableView {
    if (!_tableView) {
        _tableView = [[UITableView alloc] initWithFrame: CGRectMake(0, 0, 262, self.view.frame.size.height) style: UITableViewStylePlain];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        [_tableView registerClass: [UITableViewCell class] forCellReuseIdentifier: CellReuseId];
    }
    _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    return _tableView;
}

- (CGFloat) tableView:(UITableView *) tableView heightForRowAtIndexPath:(nonnull NSIndexPath *)indexPath {
    if (indexPath.row == 0) {
        return 113;
    }
    return 42;
}

- (void) tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.row == 0) {
        return ;
    }
    
    [self.drawer reloadCenterViewControllerUsingBlock: ^{
        if (indexPath.row == 1) {
            
        } else if (indexPath.row == 2) {
            
        } else if (indexPath.row == 3) {
            
        } else if (indexPath.row == 4) {
            
        } else if (indexPath.row == 5) {
            
        } else if (indexPath.row == 6) {
            
        }
    }];
}

- (UIStatusBarStyle) preferredStatusBarStyle {
    return UIStatusBarStyleLightContent;
}

#pragma mark - ICSDrawerControllerPresenting
- (void)drawerControllerWillOpen:(ICSDrawerController *)drawerController {
    self.view.userInteractionEnabled = NO;
}

- (void)drawerControllerDidOpen:(ICSDrawerController *)drawerController {
    self.view.userInteractionEnabled = YES;
}

- (void)drawerControllerWillClose:(ICSDrawerController *)drawerController {
    self.view.userInteractionEnabled = NO;
}

- (void)drawerControllerDidClose:(ICSDrawerController *)drawerController {
    self.view.userInteractionEnabled = YES;
}

@end
