//
//  ViewController.m
//  SRPT Express
//
//  Created by 段昊宇 on 16/3/4.
//  Copyright © 2016年 Desgard_Duan. All rights reserved.
//

#import "ViewController.h"
#import "AutoScrollView.h"
#import "ICSDrawerController.h"
#import "ManageViewController.h"
#import "DeliveryViewController.h"

@interface ViewController ()
@property (nonatomic, strong) UIButton *menu;
@property (nonatomic, strong) UIButton *admin;
@property (nonatomic, strong) UIButton *icon1;
@property (nonatomic, strong) UIButton *icon2;
@property (nonatomic, strong) UIButton *icon3;
@property (nonatomic, strong) UIButton *icon4;
@property (nonatomic, strong) UIButton *other1;
@property (nonatomic, strong) UIButton *other2;
@property (nonatomic, strong) UILabel *phone;
@property (nonatomic,weak) ICSDrawerController *drawer;
@end

@implementation ViewController

- (void) viewDidLoad {
    [super viewDidLoad];
    [self startUp];
     
}

- (void) viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    self.navigationController.navigationBarHidden = YES;
}

- (void) startUp {
    // 设置导航栏
    self.title = @"";
    self.navigationController.navigationBar.barTintColor = [UIColor whiteColor];
    self.view.backgroundColor = [UIColor colorWithRed: 240 / 255.f green: 241 / 255.f blue: 242 / 255.f alpha: 1];
    [self setNavBar];
    [self setAutoScrollView];
    [self setAdmin];
    [self setIcon];
    [self setOtherButton];
    [self setPhone];
}

- (void) setNavBar {
    
    CGRect CGNavBar = CGRectMake(0, 0, self.view.frame.size.width, 70);
    UIView *NavBar = [[UIView alloc] initWithFrame: CGNavBar];
    NavBar.backgroundColor = [UIColor whiteColor];
    [self.view addSubview: NavBar];
    
    UILabel *title = [[UILabel alloc] initWithFrame: CGRectMake(0, 35, self.view.frame.size.width, 30)];
    title.text = @"易货嘀";
    title.textAlignment = NSTextAlignmentCenter;
    [self.view addSubview: title];
    
    self.menu = [UIButton buttonWithType: UIButtonTypeCustom];
    self.menu.frame = CGRectMake(20, 35, 20, 20);
    
    [self.menu setImage: [UIImage imageNamed: @"menu_black.png"] forState: UIControlStateNormal];
    [self.menu addTarget: self action: @selector(openDrawer: ) forControlEvents: UIControlEventTouchUpInside];
    [self.view addSubview: self.menu];
}

- (void) setAutoScrollView {
    //创建自动滚动广告视图
    AutoScrollView *scrollView = [[AutoScrollView alloc]initWithFrame:CGRectMake(0, 70, self.view.frame.size.width, self.view.frame.size.height / 4)];
    
    // 一定要先加入视图再传递图片,不然pagecontrol显示不出来
    [self.view addSubview:scrollView];
    
    // 传递图片名称数组给scrollView
    scrollView.images = @[@"cm2_daily_banner1",@"cm2_daily_banner2",@"cm2_daily_banner3",@"cm2_daily_banner4",@"cm2_daily_banner5",@"cm2_daily_banner6",@"cm2_daily_banner7"];
}

- (void) setAdmin {
    CGRect CGAdmin = CGRectMake(0, self.navigationController.navigationBar.frame.size.height + self.view.frame.size.height / 4 + 30, self.view.frame.size.width, 56.250000);
    self.admin = [UIButton buttonWithType: UIButtonTypeRoundedRect];
    self.admin.frame = CGAdmin;
    self.admin.backgroundColor = [UIColor whiteColor];
    [self.admin setTitle: @"货单管理                                                                      >" forState: UIControlStateNormal];
    [self.admin setTitleColor: [UIColor blackColor] forState: UIControlStateNormal];
    self.admin.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
    self.admin.contentEdgeInsets = UIEdgeInsetsMake(0, 10, 0, 0);
    [self.admin addTarget: self action: @selector(toManageViewController) forControlEvents: UIControlEventTouchUpInside];
    [self.view addSubview: self.admin];
}

- (void) setIcon {
    UIView *icon = [[UIView alloc] initWithFrame: CGRectMake(0, 20 + self.navigationController.navigationBar.frame.size.height + self.view.frame.size.height / 4 + 10 + 57.25, self.view.frame.size.width, 100)];
    icon.backgroundColor = [UIColor whiteColor];
    [self.view addSubview: icon];
    
    double x = self.view.frame.size.width;
    double y = 20 + self.navigationController.navigationBar.frame.size.height + self.view.frame.size.height / 4 + 10 + 57.25 + 50 - 30;
    
    CGRect CGIcon_1 = CGRectMake(x / 8.f - 20, y, 40, 40);
    self.icon1 = [UIButton buttonWithType: UIButtonTypeCustom];
    self.icon1.frame = CGIcon_1;
    [self.icon1 setImage: [UIImage imageNamed: @"icon_1.png"] forState: UIControlStateNormal];
    [self.view addSubview: self.icon1];
    
    CGRect CGIcon_2 = CGRectMake(x / 8.f * 3 - 20, y, 40, 40);
    self.icon2 = [UIButton buttonWithType: UIButtonTypeCustom];
    self.icon2.frame = CGIcon_2;
    [self.icon2 setImage: [UIImage imageNamed: @"icon_2.png"] forState: UIControlStateNormal];
    [self.view addSubview: self.icon2];
    
    CGRect CGIcon_3 = CGRectMake(x / 8.f * 5 - 20, y, 40, 40);
    self.icon3 = [UIButton buttonWithType: UIButtonTypeCustom];
    self.icon3.frame = CGIcon_3;
    [self.icon3 setImage: [UIImage imageNamed: @"icon_3.png"] forState: UIControlStateNormal];
    [self.view addSubview: self.icon3];
    
    CGRect CGIcon_4 = CGRectMake(x / 8.f * 7 - 20, y, 40, 40);
    self.icon4 = [UIButton buttonWithType: UIButtonTypeCustom];
    self.icon4.frame = CGIcon_4;
    [self.icon4 setImage: [UIImage imageNamed: @"icon_4.png"] forState: UIControlStateNormal];
    [self.view addSubview: self.icon4];
    
    CGRect CGIconText1 = CGRectMake(0, y + 45, self.view.frame.size.width / 4, 20);
    UILabel *iconText1 = [[UILabel alloc] initWithFrame: CGIconText1];
    iconText1.text = @"待派车";
    iconText1.textAlignment = NSTextAlignmentCenter;
    [self.view addSubview: iconText1];
    
    CGRect CGIconText2 = CGRectMake(self.view.frame.size.width / 4, y + 45, self.view.frame.size.width / 4, 20);
    UILabel *iconText2 = [[UILabel alloc] initWithFrame: CGIconText2];
    iconText2.text = @"待确认";
    iconText2.textAlignment = NSTextAlignmentCenter;
    [self.view addSubview: iconText2];
    
    CGRect CGIconText3 = CGRectMake(self.view.frame.size.width / 2, y + 45, self.view.frame.size.width / 4, 20);
    UILabel *iconText3 = [[UILabel alloc] initWithFrame: CGIconText3];
    iconText3.text = @"运输中";
    iconText3.textAlignment = NSTextAlignmentCenter;
    [self.view addSubview: iconText3];
    
    CGRect CGIconText4 = CGRectMake(self.view.frame.size.width / 4 * 3, y + 45, self.view.frame.size.width / 4, 20);
    UILabel *iconText4 = [[UILabel alloc] initWithFrame: CGIconText4];
    iconText4.text = @"待收货";
    iconText4.textAlignment = NSTextAlignmentCenter;
    [self.view addSubview: iconText4];
    
}

- (void) setOtherButton {
    CGRect CGOther1 = CGRectMake(10, 278 + 100 + 40, 200, 170);
    self.other1 = [UIButton buttonWithType: UIButtonTypeCustom];
    self.other1.frame = CGOther1;
    self.other1.backgroundColor = [UIColor colorWithRed: 60 / 255.f green: 154/ 255.f blue: 229 / 255.f alpha:1];
    self.other1.layer.cornerRadius = 8;
    [self.other1 addTarget: self action: @selector(toDeliveryViewController) forControlEvents: UIControlEventTouchUpInside];
    [self.view addSubview: self.other1];
    
    UILabel *f11 = [[UILabel alloc] initWithFrame: CGRectMake(20, 438, 180, 20)];
    f11.text = @"整车发货";
    f11.textColor = [UIColor whiteColor];
    [self.view addSubview: f11];
    
    CGRect CGOther2 = CGRectMake(220, 418, 147, 170);
    self.other2 = [UIButton buttonWithType: UIButtonTypeCustom];
    self.other2.frame = CGOther2;
    self.other2.backgroundColor = [UIColor colorWithRed:253 / 255.f  green: 154 / 255.f  blue: 74 / 255.f alpha: 1];
    self.other2.layer.cornerRadius = 8;
    [self.view addSubview: self.other2];
}

- (void) setPhone {
    CGRect CGPhone = CGRectMake(0, self.view.frame.size.height - 30, self.view.frame.size.width, 30);
    self.phone = [[UILabel alloc] initWithFrame: CGPhone];
    self.phone.text = @"✆ 客服电话 400-000-0000";
    self.phone.textAlignment = NSTextAlignmentCenter;
    self.phone.textColor = [UIColor grayColor];
    [self.view addSubview: self.phone];
}

- (void) openDrawer: (UIButton *) button {
    [self.drawer open];
}

#pragma mark --------view's layout behavior-----------
- (bool) prefersStatusBarHidden {
    return NO;
}

- (void) toManageViewController {
    ManageViewController *mvc = [[ManageViewController alloc] init];
    [self.navigationController pushViewController: mvc animated: YES];
}

- (void) toDeliveryViewController {
    DeliveryViewController *cvc = [[DeliveryViewController alloc] init];
    [self.navigationController pushViewController: cvc animated:YES];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

@end
