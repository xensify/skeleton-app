//
//  XFYMasterViewController.m
//  xensifySkeleton
//
//  Created by Mauro Mezzenzana on 18/06/14.
//  Copyright (c) 2014 xensify. All rights reserved.
//

#import "XFYMasterViewController.h"

#import "XFYDetailViewController.h"

@interface XFYMasterViewController () {
    NSMutableArray *_objects;
}
- (IBAction)advertiseButton:(id)sender;
@property (weak, nonatomic) IBOutlet UINavigationItem *navBar;

@property BOOL isAdvertising;

@end


@implementation XFYMasterViewController

- (void)awakeFromNib
{
    if ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPad) {
        self.clearsSelectionOnViewWillAppear = NO;
        self.preferredContentSize = CGSizeMake(320.0, 600.0);
    }
    [super awakeFromNib];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    self.navigationItem.leftBarButtonItem = self.editButtonItem;
    
    //UIBarButtonItem *addButton = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemAdd target:self action:@selector(insertNewObject:)];
    //self.navigationItem.rightBarButtonItem = addButton;
    self.detailViewController = (XFYDetailViewController *)[[self.splitViewController.viewControllers lastObject] topViewController];
    
    _xensifyManager = [[XFYManager alloc] initWithUserName:@"mauro" userKey: @"bc265576c9358080ea00e434f5fa7950" userUUID: @"B9407F30-F5F8-466E-AFF9-25556B57FE6D" customerUUID: @"devel" withMonitoring:YES];
    [_xensifyManager setNotificationWithMessage: @"Welcome to Xensify Platform" notificationAction: @"open app"];
    _xensifyManager.delegate = self;
    _xensifyAPIManager = [[XFYAPIManager alloc] initWithUserName:@"mauro" userKey: @"bc265576c9358080ea00e434f5fa7950" userUUID: @"B9407F30-F5F8-466E-AFF9-25556B57FE6D" customerUUID: @"devel"];
    _isAdvertising = NO;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)insertNewObject:(id)sender
{
    if (!_objects) {
        _objects = [[NSMutableArray alloc] init];
    }
    [_objects insertObject:sender atIndex:0];
    NSIndexPath *indexPath = [NSIndexPath indexPathForRow:0 inSection:0];
    [self.tableView insertRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationAutomatic];
}

#pragma mark - Table View

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return _objects.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"Cell" forIndexPath:indexPath];
    
    XFYObject *object = _objects[indexPath.row];
    cell.textLabel.text = object.objectName;
    return cell;
}

- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the specified item to be editable.
    return YES;
}

- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        [_objects removeObjectAtIndex:indexPath.row];
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    } else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view.
    }
}

/*
 // Override to support rearranging the table view.
 - (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath
 {
 }
 */

/*
 // Override to support conditional rearranging of the table view.
 - (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath
 {
 // Return NO if you do not want the item to be re-orderable.
 return YES;
 }
 */

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPad) {
        NSDate *object = _objects[indexPath.row];
        self.detailViewController.detailItem = object;
    }
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if ([[segue identifier] isEqualToString:@"showDetail"]) {
        NSIndexPath *indexPath = [self.tableView indexPathForSelectedRow];
        NSDate *object = _objects[indexPath.row];
        [[segue destinationViewController] setDetailItem:object];
    }
}

//Delegate Methods
- (void) XFYManager: (XFYManager *) manager didFindObjects: (NSArray *) objects {
    
    //NSLog(@"Delegation -> Objects found: %@", objects);
    NSArray *cells = [self.tableView visibleCells];
    
    NSMutableArray *mutant = [NSMutableArray array];
    
    for (id cell in cells){
        UITableViewCell *thisCell = cell;
        [mutant addObject:thisCell.textLabel.text];
    }
    
    for (id object in objects){
        XFYObject *foundObject = (XFYObject *) object;
        if (![mutant containsObject:foundObject.objectName]){
            
            [self insertNewObject: foundObject];
        }
    }
    
    
    
}

- (void) XFYManager: (XFYManager *) manager didFindPlaces:(NSArray *) places {
    
    //NSLog(@"Delegation -> Places found: %@", places);
    
    //XFYPlace *place = places[0];
    
    //_navBar.title = place.placeName;
    
}

- (IBAction)advertiseButton:(id)sender {
    
    _navBar.title = @"...";
    
    if (!_isAdvertising){
        
        [_xensifyAPIManager objectFromMajorValue:@"63722" minorValue:@"49223" withCompletion:^(NSError *error, XFYObject *result) {
            if(error){
                NSLog(@"2 objectFromMajorValue error: %@", error);
            }
            else{
                NSLog(@"2 objectFromMajorValue data: %@", result);
                
                result.objectName = @"virtualObject";
                
                [_xensifyManager startAdvertisingNewXFYObject:result];
                
                _isAdvertising = YES;
            }
        }];
    }
    else {
        
        [_xensifyManager stopAdvertisingXFYObject];
        _isAdvertising = NO;
        _navBar.title = @"Objects";
        
    }
    
}

- (void) XFYManager: (XFYManager *) manager didStartAdvertisingXFYObject:(XFYObject *)object{
    
    NSLog(@"advertising started for region %@", object.objectName);
    
    _navBar.title = object.objectName;
    
    _isAdvertising = YES;
    
}

@end
