//
//  SendViewController.m
//  SRPT Express
//
//  Created by 段昊宇 on 16/4/13.
//  Copyright © 2016年 Desgard_Duan. All rights reserved.
//

#import "SendViewController.h"
#import <MAMapKit/MAMapKit.h>
#import <AMapLocationKit/AMapLocationKit.h>
#import "DeliveryViewController.h"


@interface SendViewController()<MAMapViewDelegate, AMapLocationManagerDelegate, UIGestureRecognizerDelegate> {
    MAMapView *_mapView;
}

@property (nonatomic, strong) AMapLocationManager *locationManager;
@property (nonatomic, strong) MAPointAnnotation *pointAnnotation;
@property (nonatomic) CLLocationCoordinate2D touchMapCoordinate;
@end

@implementation SendViewController

- (void) viewDidLoad {
    [super viewDidLoad];
    [self setNav];
    [self setMap];
    
}

- (void) setNav {
    UIBarButtonItem *actionButton=[[UIBarButtonItem alloc]initWithTitle:@"确定" style: UIBarButtonItemStylePlain target:self action:@selector(sure)];
    self.navigationItem.rightBarButtonItem = actionButton;
}

- (void) sure {
    // [self.navigationController popToViewController: [self.navigationController.viewControllers objectAtIndex: 1] animated: YES];
    for (UIViewController *temp in self.navigationController.viewControllers) {
        if ([temp isKindOfClass: [DeliveryViewController class]]) {
            DeliveryViewController *dvc = temp;
            [dvc setStart: self.touchMapCoordinate];
            [self.navigationController popToViewController: dvc animated: YES];
        }
    }
}

- (void) setMap {
    [AMapLocationServices sharedServices].apiKey = @"c8964a684ca8b41fa1d9218d698a0056";
    _mapView = [[MAMapView alloc] initWithFrame:CGRectMake(0, 0, CGRectGetWidth(self.view.bounds), CGRectGetHeight(self.view.bounds))];
    _mapView.delegate = self;
    _mapView.showsUserLocation = YES;
    _mapView.userTrackingMode = MAUserTrackingModeFollow;
    
    
    self.locationManager = [[AMapLocationManager alloc] init];
    self.locationManager.delegate = self;
    
    [self.view addSubview:_mapView];
    [self.locationManager startUpdatingLocation];
    
    //长按屏幕，添加大头针
    UILongPressGestureRecognizer *Lpress = [[UILongPressGestureRecognizer alloc]initWithTarget:self action:@selector(LongPressClick:)];
    Lpress.delegate = self;
    Lpress.minimumPressDuration = 1.0;//1.0秒响应方法
    Lpress.allowableMovement = 50.0;
    [_mapView addGestureRecognizer:Lpress];
}

- (void)amapLocationManager:(AMapLocationManager *)manager didUpdateLocation:(CLLocation *)location {
    NSLog(@"location:{lat:%f; lon:%f; accuracy:%f}", location.coordinate.latitude, location.coordinate.longitude, location.horizontalAccuracy);
}

- (MAAnnotationView *)mapView:(MAMapView *)mapView viewForAnnotation:(id <MAAnnotation>)annotation {
    if ([annotation isKindOfClass:[MAPointAnnotation class]]) {
        static NSString *pointReuseIndentifier = @"pointReuseIndentifier";
        MAPinAnnotationView*annotationView = (MAPinAnnotationView*)[mapView dequeueReusableAnnotationViewWithIdentifier:pointReuseIndentifier];
        if (annotationView == nil) {
            annotationView = [[MAPinAnnotationView alloc] initWithAnnotation:annotation reuseIdentifier:pointReuseIndentifier];
        }
        annotationView.canShowCallout= YES;       //设置气泡可以弹出，默认为NO
        annotationView.animatesDrop = YES;        //设置标注动画显示，默认为NO
        annotationView.draggable = YES;        //设置标注可以拖动，默认为NO
        annotationView.pinColor = MAPinAnnotationColorPurple;
        return annotationView;
    }
    return nil;
}

- (void)LongPressClick:(UILongPressGestureRecognizer *)gestureRecognizer {
    if (_pointAnnotation != nil) {
        [_mapView removeAnnotation: _pointAnnotation];
    }
    CGPoint touchPoint = [gestureRecognizer locationInView: _mapView];
    _touchMapCoordinate = [_mapView convertPoint: touchPoint toCoordinateFromView: _mapView];
    
    _pointAnnotation = [[MAPointAnnotation alloc] init];
    _pointAnnotation.coordinate = _touchMapCoordinate;
    [_mapView addAnnotation: _pointAnnotation];
    
}

- (BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldRecognizeSimultaneouslyWithGestureRecognizer:(UIGestureRecognizer *)otherGestureRecognizer {
    return YES;
}


@end
