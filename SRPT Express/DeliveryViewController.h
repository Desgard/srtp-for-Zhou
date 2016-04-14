//
//  DeliveryViewController.h
//  SRPT Express
//
//  Created by 段昊宇 on 16/3/9.
//  Copyright © 2016年 Desgard_Duan. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <AMapLocationKit/AMapLocationKit.h>

@interface DeliveryViewController : UIViewController

@property (nonatomic) CLLocationCoordinate2D start;
@property (nonatomic) CLLocationCoordinate2D end;

@end
