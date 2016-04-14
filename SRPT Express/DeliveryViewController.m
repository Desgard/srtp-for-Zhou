//
//  DeliveryViewController.m
//  SRPT Express
//
//  Created by 段昊宇 on 16/3/6.
//  Copyright © 2016年 Desgard_Duan. All rights reserved.
//

#import "DeliveryViewController.h"
#import "CarTableViewCell.h"
#import "Car2TableViewCell.h"
#import "Car3TableViewCell.h"
#import "SendViewController.h"
#import "ReceiveViewController.h"
#import "ShowLineViewController.h"

@interface DeliveryViewController () <UITableViewDataSource, UITableViewDelegate>

@property (weak, nonatomic) IBOutlet UITableView *first;
@property (weak, nonatomic) IBOutlet UIButton *post;

@end

@implementation DeliveryViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationController.navigationBarHidden = NO;
    self.title = @"发货";
    self.view.backgroundColor = [UIColor colorWithRed: 240 / 255.f green: 241 / 255.f blue: 242 / 255.f alpha: 1];
    _first.delegate = self;
    _first.dataSource = self;
}

- (NSInteger) numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger) tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if (tableView == self.first) {
        return 9;
    }
    return 0;
}

- (NSInteger) tableView:(UITableView *)tableView :(NSIndexPath *)indexPath {
    return 3;
}

- (void) tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.row == 0) {
        SendViewController *svc = [[SendViewController alloc] init];
        [self.navigationController pushViewController:svc  animated: YES];
    } else if (indexPath.row == 1) {
        ReceiveViewController *rvc = [[ReceiveViewController alloc] init];
        [self.navigationController pushViewController:rvc animated: YES];
    } else if (indexPath.row == 2) {
        [self test];
    }
}

- (CGFloat) tableView:(UITableView *) tableView heightForRowAtIndexPath:(nonnull NSIndexPath *)indexPath {
    if (tableView == self.first) {
        if (indexPath.row == 2) {
            return 80;
        } else {
            return 60;
        }
    }
    return 60;
}

- (UITableViewCell *) tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [[UITableViewCell alloc] initWithStyle: UITableViewCellStyleValue1 reuseIdentifier: @""];
    if (tableView == self.first) {
        if (indexPath.row == 0) {
            cell.textLabel.text = @"出发地";
            cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
            [cell.imageView setImage: [UIImage imageNamed: @"start_ico.png"]];
        }
        if (indexPath.row == 1) {
            cell.textLabel.text = @"终点地";
            cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
            cell.detailTextLabel.text = @"卸货地";
            [cell.imageView setImage: [UIImage imageNamed: @"end_ico.png"]];
        }
        if (indexPath.row == 2) {
            CarTableViewCell *cell1 = (CarTableViewCell *)[tableView dequeueReusableCellWithIdentifier: @"CarTableViewCell"];
            if (cell1 == nil) {
                NSArray *nib = [[NSBundle mainBundle] loadNibNamed: @"CarTableViewCell" owner: self options: nil];
                cell1 = [nib objectAtIndex: 0];
            }
            return cell1;
        }
        if (indexPath.row == 3) {
            cell.textLabel.text = @"用车时间";
            cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
            cell.detailTextLabel.text = @"立即用车";
        }
        if (indexPath.row == 4) {
            cell.textLabel.text = @"货物信息";
            cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
            cell.detailTextLabel.text = @"具体详情";
        }
        if (indexPath.row == 5) {
            cell.textLabel.text = @"增值服务";
            cell.accessoryType = UITableViewCellAccessoryNone;
        }
        if (indexPath.row == 6) {
            cell.textLabel.text = @"备注信息";
            cell.accessoryType = UITableViewCellAccessoryNone;
        }
        if (indexPath.row == 7) {
            Car2TableViewCell *cell2 = (Car2TableViewCell *)[tableView dequeueReusableCellWithIdentifier: @"Car2TableViewCell"];
            if (cell2 == nil) {
                NSArray *nib = [[NSBundle mainBundle] loadNibNamed: @"Car2TableViewCell" owner: self options: nil];
                cell2 = [nib objectAtIndex: 0];
            }
            return cell2;
        }
        if (indexPath.row == 8) {
            Car3TableViewCell *cell3 = (Car3TableViewCell *)[tableView dequeueReusableCellWithIdentifier: @"Car3TableViewCell"];
            if (cell3 == nil) {
                NSArray *nib = [[NSBundle mainBundle] loadNibNamed: @"Car3TableViewCell" owner: self options: nil];
                cell3 = [nib objectAtIndex: 0];
            }
            return cell3;
        }
        
    }
    return cell;
}

- (IBAction)toShowLine:(id)sender {
    ShowLineViewController *slvc = [[ShowLineViewController alloc] init];
    slvc.start = self.start;
    slvc.end = self.end;
    
    [self.navigationController pushViewController: slvc animated: YES];
}

- (void) test {
    NSLog(@"%f %f", self.start.latitude, self.start.longitude);
    NSLog(@"%f %f", self.end.latitude, self.end.longitude);
}

@end
