//
//  MenuViewController.h
//  SRPT Express
//
//  Created by 段昊宇 on 16/3/5.
//  Copyright © 2016年 Desgard_Duan. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ICSDrawerController.h"

@interface MenuViewController : UIViewController<ICSDrawerControllerChild, ICSDrawerControllerPresenting>
@property (nonatomic, weak) ICSDrawerController *drawer;
@end
