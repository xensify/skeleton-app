//
//  XFYMasterViewController.h
//  xensifySkeleton
//
//  Created by Mauro Mezzenzana on 18/06/14.
//  Copyright (c) 2014 xensify. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "xensifySDK/XFYManager.h"

@class XFYDetailViewController;

@interface XFYMasterViewController : UITableViewController <XFYManagerDelegate>

@property (strong, nonatomic) XFYDetailViewController *detailViewController;
@property (nonatomic, strong) XFYManager  *xensifyManager;
@property (nonatomic, strong) XFYAPIManager  *xensifyAPIManager;

@end
