//
//  ListSallesController.m
//  ociney
//
//  Created by Kevin De Jesus Ferreira on 29/11/2014.
//  Copyright (c) 2014 bdc. All rights reserved.
//

#import "ListSallesController.h"
#import "OCAppDelegate.h"
#import "SalleCell.h"
#import "RechercheTaskTheater.h"
#import "Color+Hex.h"
#import "Constantes.h"
#import "OCTheaterDetailController.h"
#import "AnalyticsKit.h"

#define IDENTIFIER_SALLE @"salles"

#import <QuartzCore/QuartzCore.h>


@interface ListSallesController ()<CLLocationManagerDelegate,CancelSearchDelegate,RechercheTaskTheaterDelegate>

@end

@implementation ListSallesController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [AnalyticsKit logScreen:@"ListSalles"];
    
    self.titleView = @"Salles";
    self.appDelegate.placeholderSearch = @"Rechercher une salle";
    self.appDelegate.task = [[RechercheTaskTheater alloc]initWithDelegate:self];
    self.appDelegate.task.cancelDelegate = self;

    self.empty_gps = [[OCEmptyViewGPS alloc]initWithFrame:CGRectZero];
    self.empty_gps.hidden = YES;
    
    [self.view addSubview:self.empty_gps];
    
    if ([CLLocationManager locationServicesEnabled]) {
        self.locationManager = [[CLLocationManager alloc] init];
        self.locationManager.distanceFilter = kCLDistanceFilterNone;
        self.locationManager.desiredAccuracy = kCLLocationAccuracyHundredMeters;
        self.locationManager.delegate = self;
        
        if ([self.locationManager respondsToSelector:@selector(requestWhenInUseAuthorization)]) {
            //[self.locationManager requestWhenInUseAuthorization];
            [self.locationManager requestAlwaysAuthorization];
        }
        
        [self.locationManager startUpdatingLocation];
        
    }else{
        NSLog(@"GPS PAS ACTIVE");
    }
    
    
    
}

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    
    
    [[self navigationController] setNavigationBarHidden:NO animated:YES];
    
    self.navigationController.navigationBar.opaque = YES;
    self.navigationController.navigationBar.translucent = NO;
    self.navigationItem.hidesBackButton = YES;
    
    self.navigationController.navigationBar.barTintColor = [UIColor blackColor];
    self.navigationController.navigationBar.tintColor = [UIColor whiteColor];
    [self.navigationController.navigationBar
     setTitleTextAttributes:@{NSForegroundColorAttributeName : [UIColor whiteColor]}];
 
    self.empty_gps.frame = self.view.bounds;
    [self.empty_gps positionner];
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:IDENTIFIER_SALLE];
    
    if(cell == nil){
        [tableView registerNib:[UINib nibWithNibName:@"SalleCell" bundle:nil] forCellReuseIdentifier:IDENTIFIER_SALLE];
        cell = [tableView dequeueReusableCellWithIdentifier:IDENTIFIER_SALLE];
        [cell awakeFromNib];
    }
    
    cell.contentView.frame = CGRectMake(cell.contentView.frame.origin.x,
                                        cell.contentView.frame.origin.y,
                                        self.tableView.frame.size.width,
                                        cell.contentView.frame.size.height);
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    return cell;
}


- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return SALLE_CELL_HEIGHT;
}

- (void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:
(NSIndexPath *)indexPath{
    
    SalleCell *s = (SalleCell*)cell;
    
    [s chargerAvecSalle:self.array[indexPath.row]];
    
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [super onClick];
    
    OCTheaterDetailController *controller = [[OCTheaterDetailController alloc] init];
    UITableViewCell * cell = [tableView cellForRowAtIndexPath:indexPath];
    controller.viewCinema = [[UIImageView alloc]initWithImage:[ListSallesController imageWithView:[cell contentView]]];
    controller.cinema = [self.array objectAtIndex:indexPath.row];
    
    [self.navigationController pushViewController:controller animated:YES];
    
}

+ (UIImage *) imageWithView:(UIView *)view
{
    UIGraphicsBeginImageContextWithOptions(view.bounds.size, view.opaque, 0.0);
    [view.layer renderInContext:UIGraphicsGetCurrentContext()];
    
    UIImage * img = UIGraphicsGetImageFromCurrentImageContext();
    
    UIGraphicsEndImageContext();
    
    return img;
}


-(void) locationManager: (CLLocationManager *)manager didUpdateToLocation: (CLLocation *) newLocation
           fromLocation: (CLLocation *) oldLocation{
}

- (void) locationManager:(CLLocationManager *)manager didFailWithError:(NSError *)error{
    [self afficherEmptyView:YES];
    self.empty_gps.hidden = NO;
    [self.locationManager stopUpdatingLocation];
}

- (void)locationManager:(CLLocationManager *)manager
     didUpdateLocations:(NSArray *)locations{
    
    
    if(locations.count > 0){
        self.locationManager.delegate = nil;
        [self.locationManager stopUpdatingLocation];
        
        self.empty_gps.hidden = YES;
 
        CLLocation* loc = locations[0];
        
        OCAppDelegate* app = (OCAppDelegate*)[UIApplication sharedApplication].delegate;
        app.myLocationGPS =loc;
        
        NSString *lat = [NSString stringWithFormat:@"%f",loc.coordinate.latitude];
        NSString *longitude = [NSString stringWithFormat:@"%f",loc.coordinate.longitude];
        
        if(DEBUG){
            lat = @"48.85568";
            longitude = @"2.339401";
        }
        
        self.task = [[OCLoadTheatersTask alloc]initWithDelegate:self];
        [self.task execute:@[lat,longitude]];
    }
    
}

#pragma mark - OCLoadTheatersTaskDelegate

-(void)onTheatersListRecu:(OCLoadTheatersTask*)task theatherList:(NSArray *)theatherList{
    [self afficherEmptyView:NO];

    [self.array addObjectsFromArray:theatherList];
    
    self.salleDepart = [self.array copy];
    [self.tableView reloadData];
    
}

-(void)onTheatersListResultatVide:(OCLoadTheatersTask*)task{
    if(self.page == 1){
        [self afficherEmptyView:YES];
    }
}


-(void)erreurReseau:(AsyncTask*)task
{
    
}

-(void)afficherChargement:(AsyncTask*)task afficher:(BOOL)afficher
{
    [[UIApplication sharedApplication] setNetworkActivityIndicatorVisible:afficher];

}

#pragma mark - CancelSearchDelegate

-(void)onCancelSearch{
    
    if([self.salleDepart count] != 0){
        [self afficherEmptyView:NO];
    }
    
    self.loadMore = YES;
    self.page = 1;
    self.searchOn = NO;

    [self.array removeAllObjects];
    [self.array addObjectsFromArray:self.salleDepart];
    
    self.task = [[OCLoadTheatersTask alloc]initWithDelegate:self];
    [self.task execute:@[@"47.346699",@"1.294519"]];
    
    
}

#pragma mark - RechercheTaskTheaterDelegate


-(void)onRechercheTheaterRecu:(RechercheTaskTheater*)task theaters:(NSArray *)listCinemas{
    
    [self afficherEmptyView:NO];
    self.empty_gps.hidden = YES;

    if(!self.searchOn){
        self.page = 1;
        self.loadMore = YES;
        [self.array removeAllObjects];
    }
    
    self.searchOn = YES;
    
    [self.array addObjectsFromArray:listCinemas];
    [self.tableView reloadData];
}

-(void)onRechercheTheaterVide:(RechercheTaskTheater*)task{
    if(self.page == 1){
        [self afficherEmptyView:YES];
        self.empty_gps.hidden = NO;

    }
}

@end
