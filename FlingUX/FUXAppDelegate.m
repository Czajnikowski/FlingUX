//
//  FAppDelegate.m
//  FlingUX
//
//  Created by Maciek on 22.09.2013.
//  Copyright (c) 2013 Fortunity. All rights reserved.
//

#import "FUXAppDelegate.h"

#import <DCIntrospect-ARC/DCIntrospect.h>

@implementation FUXAppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
#if TARGET_IPHONE_SIMULATOR
    [[DCIntrospect sharedIntrospector] start];
#endif
    
    return YES;
}

@end
