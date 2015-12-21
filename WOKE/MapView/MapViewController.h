//
//  MapViewController.h
//  WOKE
//
//  Created by mac on 12/16/15.
//  Copyright © 2015 Themesoft. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MapKit/MapKit.h>

@interface MapViewController : UIViewController
@property (weak, nonatomic) IBOutlet MKMapView *mapKit;
@property (strong, nonatomic)NSMutableArray *categList;

@end
