//
//  ShowLineViewController.m
//  SRPT Express
//
//  Created by 段昊宇 on 16/4/13.
//  Copyright © 2016年 Desgard_Duan. All rights reserved.
//

#import "ShowLineViewController.h"
#import <MAMapKit/MAMapKit.h>
#import <AMapLocationKit/AMapLocationKit.h>
#import <AMapNaviKit/AMapNaviKit.h>
#import <AMapSearchKit/AMapSearchKit.h>
#import "DeliveryViewController.h"


@interface ShowLineViewController()<MAMapViewDelegate, AMapLocationManagerDelegate, AMapNaviManagerDelegate, AMapSearchDelegate> {
    
    
}

@property (nonatomic, strong) AMapLocationManager *locationManager;
@property (nonatomic, strong) MAPointAnnotation *pointAnnotation;
@property (nonatomic, strong) MAPointAnnotation *endAnnotation;
@property (nonatomic, strong) MAPointAnnotation *beginAnnotation;
@property (nonatomic) CLLocationCoordinate2D touchMapCoordinate;
@property (nonatomic, strong) MAMapView *mapView;
@property (nonatomic, strong) MAPolyline *polyline;

@property (nonatomic, strong) AMapNaviManager *naviManager;
@property (nonatomic, strong) AMapSearchAPI *search;
@end

@implementation ShowLineViewController

- (void) viewDidLoad {
    [super viewDidLoad];
    [AMapNaviServices sharedServices].apiKey = @"c8964a684ca8b41fa1d9218d698a0056";
    [AMapSearchServices sharedServices].apiKey = @"c8964a684ca8b41fa1d9218d698a0056";
    [self setMap];
    [self addBeginAndEndAnnotation];
    
    
}

/**
 *  创建起点和终点的annitation（起点是定位点的话不创建传入的时候传入坐标就行了）
 */
- (void)addBeginAndEndAnnotation {
    _endAnnotation = [[MAPointAnnotation alloc] init];
    CLLocationCoordinate2D coordinate = {30.655593,104.073803};
    [_endAnnotation setCoordinate:coordinate];
    _endAnnotation.title		= @"终点";
    [_mapView addAnnotation:_endAnnotation];
    _beginAnnotation = [[MAPointAnnotation alloc] init];
    CLLocationCoordinate2D coordinatebegin = {30.612339,104.071503};
    [_beginAnnotation setCoordinate:coordinatebegin];
    _beginAnnotation.title		= @"起点";
    [_mapView addAnnotation:_beginAnnotation];
    
    
    /*
    AMapNaviPoint *startPoint = [AMapNaviPoint locationWithLatitude:30.655593 longitude:104.073803];
    AMapNaviPoint *endPoint = [AMapNaviPoint locationWithLatitude:30.612339 longitude:104.071503];
    
    NSArray *startPoints = [[NSArray alloc] initWithObjects: startPoint, nil];
    NSArray *endPoints   = [[NSArray alloc] initWithObjects: endPoint, nil];
    //NSArray *mid = [[NSArray alloc] initWithObjects: endPoint, nil];
    
    //驾车路径规划（未设置途经点、导航策略为速度优先）
    // [_naviManager calculateDriveRouteWithStartPoints:startPoints endPoints:endPoints wayPoints: nil drivingStrategy: 2];
    
    
    //步行路径规划
    // [self.naviManager calculateWalkRouteWithStartPoints:startPoints endPoints:endPoints];
     */
    //初始化检索对象
    
    _search = [[AMapSearchAPI alloc] init];
    _search.delegate = self;
    //构造AMapNavigationSearchRequest对象，配置查询参数
    AMapDrivingRouteSearchRequest *naviRequest= [[AMapDrivingRouteSearchRequest alloc] init];
    
    naviRequest.requireExtension = YES;
    
    //起点经纬度
    naviRequest.origin = [AMapGeoPoint locationWithLatitude:30.655593 longitude:104.073803 ];
    //目的地经纬度
    naviRequest.destination = [AMapGeoPoint locationWithLatitude:30.612339 longitude:104.071503];
    
    
    //发起路径搜索
    [_search AMapDrivingRouteSearch: naviRequest];
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
    
    self.polyline = [[MAPolyline alloc] init];
    
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


- (BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldRecognizeSimultaneouslyWithGestureRecognizer:(UIGestureRecognizer *)otherGestureRecognizer {
    return YES;
}

- (void)naviManagerOnCalculateRouteSuccess:(AMapNaviManager *)naviManager {
    [self showRouteWithNaviRoute: naviManager.naviRoute];
}

- (void)showRouteWithNaviRoute:(AMapNaviRoute *)naviRoute
{
    if (naviRoute == nil)
    {
        return;
    }
    // 清除旧的overlays
    if (_polyline)
    {
        [_mapView removeOverlay:_polyline];
        self.polyline = nil;
    }
    NSUInteger coordianteCount = [naviRoute.routeCoordinates count];
    CLLocationCoordinate2D coordinates[coordianteCount];
    for (int i = 0; i < coordianteCount; i++)
    {
        AMapNaviPoint *aCoordinate = [naviRoute.routeCoordinates objectAtIndex:i];
        coordinates[i] = CLLocationCoordinate2DMake(aCoordinate.latitude, aCoordinate.longitude);
    }
    _polyline = [MAPolyline polylineWithCoordinates:coordinates count:coordianteCount];
    [_mapView addOverlay:_polyline];
}

- (void)onRouteSearchDone:(AMapRouteSearchBaseRequest *)request response:(AMapRouteSearchResponse *)response
{
    if(response.route == nil)
    {
        return;
    }
    
    AMapRoute *route=response.route;
    //第一个方案的路线
    AMapPath *path=route.paths[0];
    NSMutableArray *coordinateArray=[[NSMutableArray alloc] initWithCapacity:path.steps.count];
    //遍历这个方案中的路段
    for(AMapStep *step in path.steps)
    {
        NSArray *pointArray=[step.polyline componentsSeparatedByString:@";"];
        for (NSString *str in pointArray) {
            [coordinateArray addObject:str];
        }
    }
    CLLocationCoordinate2D coordinate[coordinateArray.count];
    //遍历坐标字符串
    for (int i = 0; i < coordinateArray.count; i++) {
        //经纬度字符串 116,14
        NSString* pointStr = coordinateArray[i];
        NSArray* pointArray = [pointStr componentsSeparatedByString:@","];
        //取得经纬度
        coordinate[i].longitude = [pointArray[0] floatValue];
        coordinate[i].latitude = [pointArray[1] floatValue];
    }
    
    MAPolyline* polyline = [MAPolyline polylineWithCoordinates:coordinate count:coordinateArray.count];
    [_mapView addOverlay:polyline];
}

- (void)initNaviManager
{
    if (_naviManager == nil)
    {
        _naviManager = [[AMapNaviManager alloc] init];
        [_naviManager setDelegate:self];
    }
}

- (MAOverlayView *)mapView:(MAMapView *)mapView viewForOverlay:(id<MAOverlay>)overlay
{
    if ([overlay isKindOfClass:[MAPolyline class]])
    {
        MAPolylineView *polylineView = [[MAPolylineView alloc] initWithPolyline:overlay];
        polylineView.lineWidth = 5.0f;
        polylineView.strokeColor = [UIColor redColor];
        
        return polylineView;
    }
    return nil;
}

@end