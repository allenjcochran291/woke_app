//
//  LocationManager.m
//  SalesMapperUI
//
//  Created by Kyle Gerstner on 6/5/12.
//  Copyright (c) 2012 Sonoma Partners, LLC. All rights reserved.
//

#import "LocationManager.h"

@implementation LocationManager

@synthesize currLocationCoord, customLocationCoord;

+ (LocationManager*)locationManager
{
    static LocationManager *locationManager = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        locationManager = [[LocationManager alloc] init];
    });
    
    return locationManager;
}

-(id)init
{
    self = [super init];
    
    clLocationManager = [[CLLocationManager alloc] init];
    clLocationManager.delegate = self;
    [clLocationManager requestWhenInUseAuthorization];
    [clLocationManager startUpdatingLocation];
    clLocationManager.desiredAccuracy = kCLLocationAccuracyKilometer;
    currLocationCoord = kCLLocationCoordinate2DInvalid;
    
    forwardGeocoder = [[CLGeocoder alloc] init];
    customLocationCoord = kCLLocationCoordinate2DInvalid;
    
    return self;
}

- (void)getCurrentLocation
{
    currLocationCoord = kCLLocationCoordinate2DInvalid;
    [clLocationManager startUpdatingLocation];
}

- (BOOL)locationServicesAvailable
{
    BOOL servicesEnabled = [CLLocationManager locationServicesEnabled];
    authStatus = [CLLocationManager authorizationStatus];
    
    if (servicesEnabled && authStatus == kCLAuthorizationStatusAuthorizedWhenInUse) {
        return YES;
    }
    return NO;
}

- (CLLocation *)currLocation
{
    CLLocation *retVal = nil;
    if (CLLocationCoordinate2DIsValid(currLocationCoord))
    {
        retVal = [[CLLocation alloc] initWithLatitude:currLocationCoord.latitude longitude:currLocationCoord.longitude];
    }
    
    return retVal;
}

#pragma mark - CLLocationManager Delegate
-(void)locationManager:(CLLocationManager *)manager didUpdateToLocation:(CLLocation *)newLocation fromLocation:(CLLocation *)oldLocation
{
    if (!CLLocationCoordinate2DIsValid(currLocationCoord) || (fabs([newLocation.timestamp timeIntervalSinceNow]) < 600 && [newLocation distanceFromLocation:oldLocation] > 1000.0) )
    {
        // Within last 10 minutes, should be good enough if the accuracy is in the desired range
        if (newLocation.horizontalAccuracy <= 1000)
        {
            currLocationCoord = newLocation.coordinate;
            [[NSNotificationCenter defaultCenter] postNotificationName:@"LocationManagerFoundCurrLoc" object:nil];
        }
    }
}

- (void)locationManager:(CLLocationManager *)manager didChangeAuthorizationStatus:(CLAuthorizationStatus)status
{
    authStatus = status;

    if (status != kCLAuthorizationStatusAuthorizedWhenInUse && status != kCLAuthorizationStatusNotDetermined)
    {
        [[NSNotificationCenter defaultCenter] postNotificationName:@"LocationManagerAuthDenied" object:nil];
    }
    else
    {
        [[NSNotificationCenter defaultCenter] postNotificationName:@"LocationManagerAuthorized" object:nil];
    }
}

- (void)locationManager:(CLLocationManager *)manager didFailWithError:(NSError *)error
{
    [[NSNotificationCenter defaultCenter] postNotificationName:@"LocationManagerCurrLocError" object:nil];
}

#pragma mark - Forward Geocoding
- (void)getCoordinatesForAddress:(NSString*)address
{
    customLocationCoord = kCLLocationCoordinate2DInvalid;
    if (forwardGeocoder.isGeocoding)
    {
        [forwardGeocoder cancelGeocode];
    }
    
    [forwardGeocoder geocodeAddressString:address completionHandler:^(NSArray *placemarks, NSError *error) {
                    if ([placemarks count] != 0)
                    {
                        CLPlacemark *first = [placemarks objectAtIndex:0];
                        customLocationCoord = first.location.coordinate;
                        [[NSNotificationCenter defaultCenter] postNotificationName:@"LocationManagerFoundCustomLoc" object:nil];
                    }
                    else
                    {
                        [[NSNotificationCenter defaultCenter] postNotificationName:@"LocationManagerCustomLocError" object:nil];
                    }
                }
     ];
}
@end
