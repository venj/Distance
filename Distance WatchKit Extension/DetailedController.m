//
//  DetailedController.m
//  Distance
//
//  Created by 朱 文杰 on 15/4/15.
//  Copyright (c) 2015年 Home. All rights reserved.
//

#import "DetailedController.h"

@interface DetailedController()
@property (nonatomic, copy, readonly) NSString *placeDescription;
@property (nonatomic, copy, readonly) NSString *placeCoordination;
@property (weak, nonatomic) IBOutlet WKInterfaceLabel *descriptionLabel;
@property (weak, nonatomic) IBOutlet WKInterfaceLabel *coordinationLabel;
@property (nonatomic, strong) CLPlacemark *placeMark;
@end

@implementation DetailedController

- (void)awakeWithContext:(id)context {
    [super awakeWithContext:context];
    // Configure interface objects here.
    self.placeMark = context;
    
}

- (void)willActivate {
    // This method is called when watch view controller is about to be visible to user
    [super willActivate];
    [self updateUI];
}

- (void)didDeactivate {
    // This method is called when watch view controller is no longer visible
    [super didDeactivate];
}

- (NSString *)placeDescription {
    if (self.placeMark) {
        return [NSString stringWithFormat:@"%@%@%@%@", self.placeMark.country, self.placeMark.administrativeArea, self.placeMark.locality, self.placeMark.thoroughfare];
    }
    else {
        return @"N.A.";
    }
}

- (NSString *)placeCoordination {
    if (self.placeMark) {
        CLLocationCoordinate2D coord = self.placeMark.location.coordinate;
        return [NSString stringWithFormat:@"%.6f, %.6f", coord.latitude, coord.longitude];
    }
    else {
        return @"N.A.";
    }
}

- (void)updateUI {
    self.descriptionLabel.text = [self placeDescription];
    self.coordinationLabel.text = [self placeCoordination];
}

@end
