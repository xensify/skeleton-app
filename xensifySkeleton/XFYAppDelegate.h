//
//  XFYAppDelegate.h
//  xensifySkeleton
//
//  Created by Mauro Mezzenzana on 18/06/14.
//  Copyright (c) 2014 xensify. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "xensifySDK/XFYAPIManager.h"
//#import "CustomURLCache.h"

@interface XFYAppDelegate : UIResponder <UIApplicationDelegate>

@property (strong, nonatomic) UIWindow *window;

@property (nonatomic, strong) XFYAPIManager  *xensifyManager;

@end
