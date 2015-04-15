//
//  InterfaceController.m
//  Distance WatchKit Extension
//
//  Created by 朱 文杰 on 15/4/13.
//  Copyright (c) 2015年 Home. All rights reserved.
//

#import "InterfaceController.h"
@import CoreLocation;


@interface InterfaceController() <CLLocationManagerDelegate>
@property (nonatomic, strong) CLLocationManager *manager;
@property (weak, nonatomic) IBOutlet WKInterfaceLabel *coordinationLabel;
@property (weak, nonatomic) IBOutlet WKInterfaceMap *mapView;
@property (weak, nonatomic) IBOutlet WKInterfaceLabel *positionLabel;
@property (strong, nonatomic) CLPlacemark *currentPlaceMark;
@end


@implementation InterfaceController

- (void)awakeWithContext:(id)context {
    [super awakeWithContext:context];
    // Configure interface objects here.
    NSLog(@"Wake up.");
    if (!self.manager) {
        self.manager = [[CLLocationManager alloc] init];
        self.manager.delegate = self;
        self.manager.desiredAccuracy = kCLLocationAccuracyBest;
    }
    
    [self.manager startUpdatingLocation];
    
}

- (void)willActivate {
    // This method is called when watch view controller is about to be visible to user
    [super willActivate];
    [self.manager startUpdatingLocation];
}

- (void)didDeactivate {
    // This method is called when watch view controller is no longer visible
    [super didDeactivate];
}

- (void)locationManager:(CLLocationManager *)manager didUpdateToLocation:(CLLocation *)newLocation fromLocation:(CLLocation *)oldLocation {
    self.coordinationLabel.text = [[NSString alloc] initWithFormat:@"%.2f, %.2f", newLocation.coordinate.latitude, newLocation.coordinate.longitude];
    
    CLLocationCoordinate2D coordinate = newLocation.coordinate;
    MKCoordinateRegion region = MKCoordinateRegionMake(coordinate, MKCoordinateSpanMake(0.005, 0.005));
    [self.mapView setRegion:region];
    [self.mapView addAnnotation:coordinate withPinColor:WKInterfaceMapPinColorPurple];
    
    CLGeocoder *coder = [[CLGeocoder alloc] init];
    __weak typeof(self) weakself = self;
    [coder reverseGeocodeLocation:newLocation completionHandler:^(NSArray *placemarks, NSError *error) {
        CLPlacemark *placeMark = placemarks[0];
        self.currentPlaceMark = placeMark;
        weakself.positionLabel.text = placeMark.thoroughfare;
        NSLog(@"%@, %@, %@, %@, %@", placeMark.administrativeArea, placeMark.subAdministrativeArea, placeMark.locality, placeMark.subLocality, placeMark.thoroughfare);
    }];
    if (fabs([newLocation.timestamp timeIntervalSinceDate:oldLocation.timestamp]) < 60) {
        [self.manager stopUpdatingLocation];
    }
}

- (id)contextForSegueWithIdentifier:(NSString *)segueIdentifier {
    return self.currentPlaceMark;
}


- (void)handleUserActivity:(NSDictionary *)userInfo {
    if (userInfo[@"NextScene"]) {
        [self pushControllerWithName:userInfo[@"NextScene"] context:nil];
    }
    else {
        // Do nothing
    }
}

@end



