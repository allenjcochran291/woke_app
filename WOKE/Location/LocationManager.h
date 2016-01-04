//
//  LocationManager.h
//  SalesMapperUI
//
//  Created by Kyle Gerstner on 6/5/12.
//  Copyright (c) 2012 Sonoma Partners, LLC. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <MapKit/MapKit.h>

@interface LocationManager : NSObject <CLLocationManagerDelegate>
{
    CLLocationManager *clLocationManager;
    CLLocationCoordinate2D currLocationCoord;
    CLGeocoder *forwardGeocoder;
    CLLocationCoordinate2D customLocationCoord;
    
    CLAuthorizationStatus authStatus;
}

@property (readonly) CLLocationCoordinate2D currLocationCoord;
@property (readonly) CLLocation* currLocation;
@property (readwrite) CLLocationCoordinate2D customLocationCoord;

+(LocationManager*)locationManager;

- (void)getCurrentLocation;
- (void)getCoordinatesForAddress:(NSString*)address;
- (BOOL)locationServicesAvailable;

@end
