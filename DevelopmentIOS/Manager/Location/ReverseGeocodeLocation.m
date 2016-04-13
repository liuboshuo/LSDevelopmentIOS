
//
//  ReverseGeocodeLocation.m
//  LSDevelopmentIOS
//
//  Created by 刘硕 on 16/4/5.
//  Copyright © 2016年 liushuo. All rights reserved.
//

#import "ReverseGeocodeLocation.h"

@implementation ReverseGeocodeLocation

singletonImplementation(ReverseGeocodeLocation);

-(void)getLocation:(locationCurrentCity)locationCurrentCity
{
    
    locationHandle locationBlock =  ^(CLLocation *location) {
#if DEBUG
        NSLog(@"%@",location);
#else
        
#endif
    };
    self.locationCurrentCityBlock = locationCurrentCity;
    //定位
    self.locationMgr = [LocationManager sharedLocationManager];
    [self.locationMgr getLocation:locationBlock];
    [self.locationMgr addObserver:self forKeyPath:@"location" options:(NSKeyValueObservingOptionOld | NSKeyValueObservingOptionNew) context:nil];
}


-(void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary<NSString *,id> *)change context:(void *)context
{
    id old = change[@"old"];
    if (old == [NSNull null] || old == nil) {
        CLLocation *location = change[@"new"];
        CLGeocoder *geocoder = [[CLGeocoder alloc] init];
        [geocoder reverseGeocodeLocation:location completionHandler:^(NSArray<CLPlacemark *> * _Nullable placemarks, NSError * _Nullable error) {
            if (error){
                self.locationCurrentCityBlock(nil,nil,location);
                return;
            }
            CLPlacemark *place = [placemarks lastObject];
            if (place != nil) {
                NSString *cityName;
                NSString *stateName;
                if (place.locality != nil) {
                    cityName = [place.locality stringByTrimmingCharactersInSet:[NSCharacterSet characterSetWithCharactersInString:@"市辖区"]];
                }else if(place.administrativeArea != nil){
                    stateName = [place.administrativeArea stringByTrimmingCharactersInSet:[NSCharacterSet characterSetWithCharactersInString:@"市辖区"]];
                }
                self.locationCurrentCityBlock(place.addressDictionary, cityName==nil? stateName : cityName,  location);
            }else{
                self.locationCurrentCityBlock(nil,nil,location);
            }
        }];
    }
}


@end
