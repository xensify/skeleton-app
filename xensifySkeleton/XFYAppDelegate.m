//
//  XFYAppDelegate.m
//  xensifySkeleton
//
//  Created by Mauro Mezzenzana on 18/06/14.
//  Copyright (c) 2014 xensify. All rights reserved.
//

#import "XFYAppDelegate.h"
#import <AFNetworking.h>


@implementation XFYAppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    // Override point for customization after application launch.
    if ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPad) {
        UISplitViewController *splitViewController = (UISplitViewController *)self.window.rootViewController;
        UINavigationController *navigationController = [splitViewController.viewControllers lastObject];
        splitViewController.delegate = (id)navigationController.topViewController;
    }
    
    //CustomURLCache *URLCache = [[CustomURLCache alloc] initWithMemoryCapacity:2 * 1024 * 1024
    //                                              diskCapacity:100 * 1024 * 1024
    //                                                  diskPath:nil];
    //[NSURLCache setSharedURLCache:URLCache];
    
    //#ifdef DEBUG
    //    [[AFHTTPRequestOperationLogger sharedLogger] startLogging];
    //    [[AFHTTPRequestOperationLogger sharedLogger] setLevel:AFLoggerLevelDebug];
    ///#endif
    
//    _xensifyManager = [[XFYManager alloc] initWithUserName:@"mauro" userKey:@"bc265576c9358080ea00e434f5fa7950" userUUID:@"B9407F30-F5F8-466E-AFF9-25556B57FE6D" customerUUID:@"devel" withMonitoring:YES];
    
//    _xensifyAPIManager = [[XFYAPIManager alloc] initWithUserName:@"mauro" userKey: @"bc265576c9358080ea00e434f5fa7950" userUUID:@"B9407F30-F5F8-466E-AFF9-25556B57FE6D"];
    
    //    [_xensifyManager objectConfigurationsWithCompletion:^(NSError *error, NSDictionary *result){
    //        NSLog(@"error: %@", error);
    //        NSLog(@"data: %@", result);
    //    }];
    
//    [_xensifyAPIManager placeFromId:@"1" withCompletion:^(NSError *error, XFYPlace *result) {
//        if (error){
//            NSLog(@"1 placeFromId error: %@", error);
//        }
//        else{
//            NSLog(@"1 placeFromId data: %@", result);
//        }
//    }];
    
//    [_xensifyAPIManager objectFromMajorValue:@"63722" minorValue:@"49223" withCompletion:^(NSError *error, XFYObject *result) {
//        if(error){
//            NSLog(@"2 objectFromMajorValue error: %@", error);
//        }
//        else{
//            NSLog(@"2 objectFromMajorValue data: %@", result);
//            
//            result.objectName = @"testVirtual";
//            result.minor = @"3";
//            
//            [_xensifyManager startAdvertisingXFYObject:result];
//        }
//    }];
    
//    [_xensifyAPIManager objectDataFromMajorValue:@"63722" minorValue:@"49223" withCompletion:^(NSError *error, XFYObject *result) {
//        if (error){
//            NSLog(@"3 objectDataFromMajorValue error: %@", error);
//        }
//        else {
//            NSLog(@"3 objectDataFromMajorValue data: %@", result);
//        }
//    }];
//    
//    [_xensifyAPIManager objectImageFromMajorValue:@"63722" minorValue:@"49223" withCompletion:^(NSError *error, UIImage *result) {
//        if (error){
//            NSLog(@"4 objectImageFromMajorValue error: %@", error);
//        }
//        else {
//            NSLog(@"4 objectImageFromMajorValue data: %@", result);
//        }
//    }];
    
    
    
    //    [_xensifyManager objectImageFromMajorValue:@"63722" minorValue:@"49223" withCompletion:^(NSError *error, UIImage
    //                                                                                             *result){
    //        NSLog(@"error: %@", error);
    //        NSLog(@"data: %@", result);
    //    }];
    //
    //    [_xensifyManager placeFromId:@"1" withCompletion:^(NSError *error, XFYPlace *place){
    //        NSLog(@"error: %@", error);
    //        NSLog(@"data: %@", place);
    //    }];
    
    //[_xensifyManager objectConfigurationsWithCompletion:^(NSError *error, NSDictionary *result){
    //    if (!error){
    //        //NSLog(@"Result: %@", result);
    //    }
    
    //}];
    
    
    
    
    return YES;
}


//- (void) didFindLocation:(XFYLocation *)location{

//    NSLog(@"Delegation -> Location found: %@", location.locationName);

//    XFYLocation *aaa = [[XFYLocation alloc] init];

//    aaa = location;

//}

- (void)applicationWillResignActive:(UIApplication *)application
{
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application
{
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application
{
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application
{
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application
{
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

- (NSCachedURLResponse *)connection:(NSURLConnection *)connection
                  willCacheResponse:(NSCachedURLResponse *)cachedResponse {
    NSMutableDictionary *mutableUserInfo = [[cachedResponse userInfo] mutableCopy];
    NSMutableData *mutableData = [[cachedResponse data] mutableCopy];
    NSURLCacheStoragePolicy storagePolicy = NSURLCacheStorageAllowedInMemoryOnly;
    
    // ...
    
    return [[NSCachedURLResponse alloc] initWithResponse:[cachedResponse response]
                                                    data:mutableData
                                                userInfo:mutableUserInfo
                                           storagePolicy:storagePolicy];
}

// If you do not wish to cache the NSURLCachedResponse, just return nil from the delegate function:

//- (NSCachedURLResponse *)connection:(NSURLConnection *)connection
//                  willCacheResponse:(NSCachedURLResponse *)cachedResponse {
//    return nil;
//}

@end
