//
//  XFYDetailViewController.m
//  xensifySkeleton
//
//  Created by Mauro Mezzenzana on 18/06/14.
//  Copyright (c) 2014 xensify. All rights reserved.
//

#import "XFYDetailViewController.h"

@interface XFYDetailViewController ()
@property (strong, nonatomic) UIPopoverController *masterPopoverController;
@property (weak, nonatomic) IBOutlet UIImageView *image;
@property (weak, nonatomic) IBOutlet UITextView *description;
@property (weak, nonatomic) IBOutlet UINavigationItem *navBar;
- (void)configureView;
@end

@implementation XFYDetailViewController

#pragma mark - Managing the detail item

- (void)setDetailItem:(id)newDetailItem
{
    if (_detailItem != newDetailItem) {
        _detailItem = newDetailItem;
        
        // Update the view.
        [self configureView];
    }

    if (self.masterPopoverController != nil) {
        [self.masterPopoverController dismissPopoverAnimated:YES];
    }        
}

- (void)configureView
{
    // Update the user interface for the detail item.

    if (self.detailItem) {
        XFYObject *thisObject = (XFYObject *) _detailItem;
                _navBar.title = thisObject.objectName;
        self.detailDescriptionLabel.text = thisObject.title;
        
        NSString *URLstring = [@"http://myibeacon-dev.elasticbeanstalk.com/api/" stringByAppendingString:@"objectImage/"];
        URLstring = [URLstring stringByAppendingString:@"USERUUID"];
        URLstring = [URLstring stringByAppendingString:@"&"];
        URLstring = [URLstring stringByAppendingString:[NSString stringWithFormat:@"%@",thisObject.major]];
        URLstring = [URLstring stringByAppendingString:@"&"];
        URLstring = [URLstring stringByAppendingString:[NSString stringWithFormat:@"%@",thisObject.minor]];
        
        NSURLCredential *newCredential;
        newCredential = [NSURLCredential credentialWithUser: @"USERNAME"
                                                   password: @"USERKEY"
                                                persistence: NSURLCredentialPersistenceNone];
        
        AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
        
        manager.credential = newCredential;
        
        manager.responseSerializer = [AFImageResponseSerializer serializer];
        
        manager.requestSerializer = [AFJSONRequestSerializer serializer];
        
        //[manager.requestSerializer setValue:deviceUUID forHTTPHeaderField:@"X-Xensify-User-Device"];
        
        //if (customerUUID){
        //    [manager.requestSerializer setValue:customerUUID forHTTPHeaderField:@"X-Xensify-User-Id"];
        //}
        
        [manager GET:URLstring parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
            UIImage *response = responseObject;
            self.image.image = response;
        } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
            NSLog(@"fail");
        }];

        
        NSAttributedString *attributedString = [[NSAttributedString alloc] initWithData:[thisObject.objectDescription dataUsingEncoding:NSUnicodeStringEncoding] options:@{ NSDocumentTypeDocumentAttribute: NSHTMLTextDocumentType } documentAttributes:nil error:nil];
        self.description.attributedText = attributedString;
        
    }
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    [self configureView];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Split view

- (void)splitViewController:(UISplitViewController *)splitController willHideViewController:(UIViewController *)viewController withBarButtonItem:(UIBarButtonItem *)barButtonItem forPopoverController:(UIPopoverController *)popoverController
{
    barButtonItem.title = NSLocalizedString(@"Menu", @"Menu");
    [self.navigationItem setLeftBarButtonItem:barButtonItem animated:YES];
    self.masterPopoverController = popoverController;
}

- (void)splitViewController:(UISplitViewController *)splitController willShowViewController:(UIViewController *)viewController invalidatingBarButtonItem:(UIBarButtonItem *)barButtonItem
{
    // Called when the view is shown again in the split view, invalidating the button and popover controller.
    [self.navigationItem setLeftBarButtonItem:nil animated:YES];
    self.masterPopoverController = nil;
}

@end
