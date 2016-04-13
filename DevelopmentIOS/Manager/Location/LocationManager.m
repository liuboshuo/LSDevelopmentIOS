//
//  LocationManager.m
//  SCFinanceAppiOS
//
//  Created by 刘硕 on 16/1/15.
//  Copyright © 2016年 scfinance. All rights reserved.
//

#import "LocationManager.h"
#import "UIPropertyConstant.h"
#import "JZLocationConverter.h"
@interface LocationManager ()<CLLocationManagerDelegate>

@property(nonatomic , strong)CLLocationManager *locationManager;

@end

@implementation LocationManager

singletonImplementation(LocationManager);

-(CLLocationManager *)locationManager
{
    if (_locationManager == nil) {
        _locationManager = [[CLLocationManager alloc] init];
        _locationManager.delegate = self;
        _locationManager.desiredAccuracy = kCLLocationAccuracyBest;
        //没间隔100米位置更新一次
        _locationManager.distanceFilter = 100;
    }
    return _locationManager;
}


-(void)getLocation:(locationHandle)completion
{
    //如果当前位置存在
    if (self.location != nil) {
        completion(self.location);
        return;
    }
    // 如果当前位置不存在
    _handle = completion;
    
    //授权处理
    if (iOS8) {
        [self.locationManager requestWhenInUseAuthorization];
        //开始定位状态
        [self.locationManager startUpdatingLocation];
    }else{
        //开始定位
        [self.locationManager startUpdatingLocation];
    }
}
#pragma mark locationManagerDelegate
-(void)locationManager:(CLLocationManager *)manager didChangeAuthorizationStatus:(CLAuthorizationStatus)status
{
    if (status == kCLAuthorizationStatusNotDetermined) {
#if DEBUG
        NSLog(@"授权失败");
#else
        
#endif
    }else if(status == kCLAuthorizationStatusAuthorizedAlways || status == kCLAuthorizationStatusAuthorizedWhenInUse){
        [self.locationManager startUpdatingLocation];
    }else{
#if DEBUG
        NSLog(@"定位不可用");
#else
        
#endif
    }
}

-(void)locationManager:(CLLocationManager *)manager didUpdateLocations:(NSArray<CLLocation *> *)locations
{
    CLLocation *location = [locations lastObject];
    CLLocationCoordinate2D coordinateNew = [JZLocationConverter wgs84ToGcj02:location.coordinate];
    CLLocation *newLocation = [[CLLocation alloc] initWithLatitude:coordinateNew.latitude longitude:coordinateNew.longitude];
    self.location = newLocation;
    self.handle(newLocation);
}

@end
