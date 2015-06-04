//
//  TabMaps.m
//  Examen
//
//  Created by Daniela Mota / Ruben Ramos on 21/05/15.
//  Copyright (c) 2015 Daniela Mota / Ruben Ramos. All rights reserved.
//

#import "TabMaps.h"
#import <GoogleMaps/GoogleMaps.h>
#import "TabBarController.h"
#import "Declarations.h"


NSString    *strUserLocation;
float       mlatitude;
float       mlongitude;

int         indextab  = 0;


@interface TabMaps ()

@end

@implementation TabMaps
{
    GMSMapView *mapView_;
    
    
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self initController];
    //-------------------------------------------------------------------------------
    //Location
    
    
    
    
    self.locationManager                    = [[CLLocationManager alloc] init];
    self.locationManager.delegate           = self;
    self.location                           = [[CLLocation alloc] init];
    self.locationManager.desiredAccuracy    = kCLLocationAccuracyKilometer;
    //[self.locationManager  requestWhenInUseAuthorization];
    //[self.locationManager  requestAlwaysAuthorization];
    [self.locationManager startUpdatingLocation];
}

- (void)initController
{
    maLatitude = [NSMutableArray arrayWithObjects: ninitialLatitud];
    //maLatitude   =  [NSNumber numberWithFloat: ninitialLatitud];
    maLongitude   = [NSMutableArray arrayWithObjects: ninitialLongitud];
    maLocation   = [NSMutableArray arrayWithObjects: ninitialLocation];
    
    mlatitude = [maLatitude [indextab] floatValue];
    mlongitude = [maLongitude [indextab] floatValue];
    NSLog(@"mlongitude1 = %f", mlongitude);
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
/**********************************************************************************************
 Localization
 **********************************************************************************************/
- (void)locationManager:(CLLocationManager *)manager didUpdateLocations:(NSArray *)locations
{
    self.location = locations.lastObject;
    NSLog( @"didUpdateLocation!");
    CLGeocoder * geoCoder = [[CLGeocoder alloc] init];
    [geoCoder reverseGeocodeLocation:self.locationManager.location completionHandler:^(NSArray *placemarks, NSError *error)
     {
         for (CLPlacemark *placemark in placemarks)
         {
             NSString *addressName = [placemark name];
             NSString *city = [placemark locality];
             NSString *administrativeArea = [placemark administrativeArea];
             NSString *country  = [placemark country];
             NSString *countryCode = [placemark ISOcountryCode];
             NSLog(@"name is %@ and locality is %@ and administrative area is %@ and country is %@ and country code %@", addressName, city, administrativeArea, country, countryCode);
             strUserLocation = [[administrativeArea stringByAppendingString:@","] stringByAppendingString:countryCode];
             NSLog(@"strUserLocation = %@", strUserLocation);
         }
         mlatitude = self.locationManager.location.coordinate.latitude;
         mlongitude = self.locationManager.location.coordinate.longitude;
         NSLog(@"mlatitude = %f", mlatitude);
         NSLog(@"mlongitude = %f", mlongitude);
     }];
}
//-------------------------------------------------------------------------------
- (void) paintMap
{
    NSLog(@"mlatitude = %f", mlatitude);
    NSLog(@"mlongitude = %f", mlongitude);
   
    

    
  
    GMSCameraPosition *camera = [GMSCameraPosition cameraWithLatitude:mlatitude
                                                            longitude:mlongitude
                                                                 zoom:0];
    
   
    
    mapView_                    = [GMSMapView mapWithFrame:CGRectZero camera:camera];
    mapView_.myLocationEnabled  = YES;
    mapView_.frame              = CGRectMake(0, 0, self.mapView.frame.size.width, self.mapView.frame.size.height);
    
    if (mlongitude == 0)
    {
        nil;
    }
  
    
    // Creates a marker in the center of the map.
    else
    {
        NSMutableArray *markersArray = [[NSMutableArray alloc] init];
        for(int i=0;i<[maLocation count];i++)
        {
            
            // ... initialise marker here
            GMSMarker *marker = [[GMSMarker alloc] init];
            mlatitude = [maLatitude [i] floatValue];
            mlongitude = [maLongitude [i] floatValue];
            marker.position = CLLocationCoordinate2DMake(mlatitude, mlongitude);
            marker.title = maLocation[i];
            marker.snippet = maLocation[i];
            marker.map = mapView_;
            
            CLLocationCoordinate2D firstLocation = ((GMSMarker *)markersArray.firstObject).position;
            GMSCoordinateBounds *bounds = [[GMSCoordinateBounds alloc] initWithCoordinate:firstLocation coordinate:firstLocation];
            
           
                bounds = [bounds includingCoordinate:marker.position];
            
            
            [mapView_ animateWithCameraUpdate:[GMSCameraUpdate fitBounds:bounds withPadding:50.0f]];
            
            
            [markersArray addObject:marker];
          //  [marker release];
        }
        
        
  /*  GMSMarker *marker = [[GMSMarker alloc] init];
        marker.position = CLLocationCoordinate2DMake(mlatitude, mlongitude);
    marker.title = maLocation[indextab];
    marker.snippet = maLocation[indextab];
    marker.map = mapView_;*/
        
       
    
    [self.mapView addSubview:mapView_];
    }
}
//-------------------------------------------------------------------------------


/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

- (IBAction)btnRefresh:(id)sender
{
    NSLog(@"conteo %d", (int)maLocation.count);
    NSLog(@"conteo %d", indextab);
    
   
        [self paintMap];
        NSLog(@"Lcocation %@",maLocation[indextab] );
    
    
    
}

- (IBAction)btnAdd:(id)sender
{
   [self createPopin];
}

- (void) createPopin
{//-------------------------------------------------------------------------------
    PopinMaps *popin = [[PopinMaps alloc] init];
    [popin setPopinTransitionStyle:BKTPopinTransitionStyleZoom];
    [popin setPopinTransitionDirection:BKTPopinTransitionDirectionTop];
    [popin setPopinAlignment:0];
    
    BKTBlurParameters *blurParameters       = [BKTBlurParameters new];
    blurParameters.alpha                    = 1.0f;
    blurParameters.radius                   = 8.0f;
    blurParameters.saturationDeltaFactor    = 1.8f;
    blurParameters.tintColor                = [UIColor colorWithRed:0/255.0 green:0/255.0 blue:255/255.0 alpha:0.50];
    [popin setBlurParameters:blurParameters];
    [popin setPopinOptions:[popin popinOptions]|BKTPopinBlurryDimmingView];
    [popin setPreferedPopinContentSize:CGSizeMake(self.view.frame.size.width, self.view.frame.size.height)];
    [popin setPopinTransitionDirection:BKTPopinTransitionDirectionTop];
    [self presentPopinController:popin animated:YES completion:nil];
    
}
@end
