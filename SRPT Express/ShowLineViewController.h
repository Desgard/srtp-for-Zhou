//
//  ShowLineViewController.h
//  SRPT Express
//
//  Created by 段昊宇 on 16/4/13.
//  Copyright © 2016年 Desgard_Duan. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <AMapLocationKit/AMapLocationKit.h>


@interface ShowLineViewController : UIViewController

@property (nonatomic) CLLocationCoordinate2D start;
@property (nonatomic) CLLocationCoordinate2D end;

@end
