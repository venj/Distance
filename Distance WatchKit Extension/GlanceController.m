//
//  GlanceController.m
//  Distance WatchKit Extension
//
//  Created by 朱 文杰 on 15/4/13.
//  Copyright (c) 2015年 Home. All rights reserved.
//

#import "GlanceController.h"


@interface GlanceController()

@end


@implementation GlanceController

- (void)awakeWithContext:(id)context {
    [super awakeWithContext:context];

    // Configure interface objects here.
    
    [self updateUserActivity:@"me.venj.Distance.GlanceTap" userInfo:@{@"NextScene" : @"fromGlance"} webpageURL:nil];
}

- (void)willActivate {
    // This method is called when watch view controller is about to be visible to user
    [super willActivate];
    
    NSLog(@"Glance Loaded");
}

- (void)didDeactivate {
    // This method is called when watch view controller is no longer visible
    [super didDeactivate];
}

@end



