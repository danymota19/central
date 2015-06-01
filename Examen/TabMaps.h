//
//  TabMaps.h
//  Examen
//
//  Created by Agustin Castaneda on 21/05/15.
//  Copyright (c) 2015 Agustin Castaneda. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreLocation/CoreLocation.h>
#import <MobileCoreServices/MobileCoreServices.h>
#import "PopinMaps.h"
#import "UIViewController+MaryPopin.h"
#import <GoogleMaps/GoogleMaps.h>


@interface TabMaps : UIViewController <CLLocationManagerDelegate, GMSMapViewDelegate>


//Variables
@property (strong, nonatomic) CLLocationManager     *locationManager;
@property (strong, nonatomic) CLLocation            *location;


//Views
@property (strong, nonatomic) IBOutlet UIView *mapView;

//Actions
- (IBAction)btnRefresh:(id)sender;
- (IBAction)btnAdd:(id)sender;



@end
