//
//  MapViewController.m
//  WOKE
//
//  Created by mac on 12/16/15.
//  Copyright © 2015 Themesoft. All rights reserved.
//

#import "MapViewController.h"
#import "WOProfileNameTableViewCell.h"
#import "MapTableViewCell.h"
#import "CustomCell.h"
#import "AnnotationView.h"
#import "LocationManager.h"

@interface MapViewController ()
@property (weak, nonatomic) IBOutlet UITableView *tableView;

@end

@implementation MapViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title =@"Location";
    // Do any additional setup after loading the view.
    [self.tableView registerNib:[UINib nibWithNibName:@"CustomCell" bundle:nil] forCellReuseIdentifier:@"Cell"];
    self.mapKit.delegate = (id)self;
    [LocationManager locationManager];
    //Set Default location to zoom
    CLLocationCoordinate2D noLocation = CLLocationCoordinate2DMake(51.900708, -2.083160); //Create the CLLocation from user cordinates
    MKCoordinateRegion viewRegion = MKCoordinateRegionMakeWithDistance(noLocation, 50000, 50000); //Set zooming level
    MKCoordinateRegion adjustedRegion = [self.mapKit regionThatFits:viewRegion]; //add location to map
  //  [self.mapKit setRegion:adjustedRegion animated:YES]; // create animation zooming
    
    // Place Annotation Point
    MKPointAnnotation *annotation1 = [[MKPointAnnotation alloc] init]; //Setting Sample location Annotation
    [annotation1 setCoordinate:CLLocationCoordinate2DMake(51.900708, -2.083160)]; //Add cordinates
    //[self.mapKit addAnnotation:annotation1];
    
   // [self.mapKit showAnnotations:self.mapKit.annotations animated:YES];
    self.mapKit.showsUserLocation = YES;
    [self getCategoriesList];

}
- (void)centerOnCoordinate:(CLLocationCoordinate2D)coordinate {
    CGFloat fiveMileRadius = (CGFloat)8046.72;
    MKCoordinateRegion newRegion = MKCoordinateRegionMakeWithDistance(coordinate, fiveMileRadius, fiveMileRadius);
    [self.mapKit setRegion:newRegion animated:YES];
    
   
}
-(void)viewDidAppear:(BOOL)animated
{

}
-(void)refreshMap
{
    [self centerOnCoordinate:self.mapKit.userLocation.coordinate];

}
-(void)getCategoriesList
{
    
    
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    hud.mode = MBProgressHUDModeIndeterminate;
    hud.labelText = @"Loading";
    
    [self.view addSubview:hud];
    [self.view setUserInteractionEnabled:NO];
    
    NSURL *url = [NSURL URLWithString:@"http://www.creativelabinteractive.com/woke/api/index.php?route=account/account/categories"];
    AFHTTPClient *httpClient = [[AFHTTPClient alloc] initWithBaseURL:url];
    NSDictionary *params = [NSDictionary dictionaryWithObjectsAndKeys:
                            API_KEY,@"client_key",
                            @"1", @"user_id",
                            @"fffff",@"device_id",
                            nil];
    
    [httpClient postPath:@"" parameters:params success:^(AFHTTPRequestOperation *operation, id responseObject) {
        
        NSError* error;
        NSDictionary  *categDict = [NSJSONSerialization JSONObjectWithData:responseObject
                                                                   options:kNilOptions
                                                                     error:&error];
        
        NSLog(@"LOGIN_SYNC = %@", categDict);
        _categList = [[NSMutableArray alloc]init];
        _categList  = [[categDict objectForKey:@"categories"]mutableCopy];
        NSDictionary *dict =@{
                              @"category_id" : @"12",
            @"category_name" : @"Me"
            };
        [_categList addObject:dict];
        [_tableView reloadData];
        [self centerOnCoordinate:self.mapKit.userLocation.coordinate];
        [NSTimer scheduledTimerWithTimeInterval:2.0
                                         target:self
                                       selector:@selector(refreshMap)
                                       userInfo:nil
                                        repeats:NO];
//        if ([[[categDict objectForKey:@"status"]valueForKey:@"code"]integerValue]==505){
//            
//
//        }
//        else{
//            [self presentAlert:[[categDict objectForKey:@"status"]valueForKey:@"message"]];
//        }
        [hud removeFromSuperview];
        [self.view setUserInteractionEnabled:YES];
        
        
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        [hud removeFromSuperview];
        [self.view setUserInteractionEnabled:YES];
        [self presentAlert:error.localizedDescription];
        
        NSLog(@"[HTTPClient Error]: %@", error.localizedDescription);
        
    }];
    
}
-(void)presentAlert:(NSString *)message
{
    UIAlertController *myAlertController = [UIAlertController alertControllerWithTitle:@"WOKEAPP"
                                                                               message: message
                                                                        preferredStyle:UIAlertControllerStyleAlert                   ];
    
    //Step 2: Create a UIAlertAction that can be added to the alert
    UIAlertAction* ok = [UIAlertAction
                         actionWithTitle:@"OK"
                         style:UIAlertActionStyleDefault
                         handler:^(UIAlertAction * action)
                         {
                             //Do some thing here, eg dismiss the alertwindow
                             [myAlertController dismissViewControllerAnimated:YES completion:nil];
                             
                         }];
    
    //Step 3: Add the UIAlertAction ok that we just created to our AlertController
    [myAlertController addAction: ok];
    
    //Step 4: Present the alert to the user
    [self presentViewController:myAlertController animated:YES completion:nil];
}
-(MKAnnotationView *)mapView:(MKMapView *)mV viewForAnnotation:(id <MKAnnotation>)annotation
{
    AnnotationView *pinView = nil; //create MKAnnotationView Property
    
    static NSString *defaultPinID = @"com.invasivecode.pin"; //Get the ID to change the pin
    pinView = (AnnotationView *)[self.mapKit dequeueReusableAnnotationViewWithIdentifier:defaultPinID]; //Setting custom MKAnnotationView to the ID
    if ( pinView == nil )
        pinView = [[AnnotationView alloc]
                   initWithAnnotation:annotation reuseIdentifier:defaultPinID]; // init pinView with ID
    pinView.canShowCallout=YES;
    //[pinView addSubview:self.customView];
//addSubview:self.customView.center = CGPointMake(self.customView.bounds.size.width*0.1f, -self.customView.bounds.size.height*0.5f);
    
    pinView.image = [UIImage imageNamed:@"00053_WOKE_ONSCRN_LOCKMAR_ME-PROF-PV"]; //Set the image to pinView
    
    return pinView;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    // Return the number of rows in the section.
    return [_categList count];
}
-(void)mapView:(MKMapView *)mapView didDeselectAnnotationView:(MKAnnotationView *)view{

}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    // We are looking for cells with the Cell identifier
    // We should reuse unused cells if there are any
    static NSString *cellIdentifier = @"Cell";
    CustomCell *cell = (CustomCell *)[tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    
    // If there is no cell to reuse, create a new one
    if(cell == nil)
    {
        cell = [[CustomCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier];

    }
    cell.switchbuttonPro.tag =indexPath.row;

    cell.labelField.text =[[_categList objectAtIndex:indexPath.row]valueForKey:@"category_name"];
    // Configure the cell before it is displayed...
    [cell.switchbuttonPro addTarget:self
                             action:@selector(clickToggle:)
                   forControlEvents:UIControlEventTouchUpInside];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;
}
-(void) clickToggle:(UIButton *) sender {
    
    [self centerOnCoordinate:self.mapKit.userLocation.coordinate];
    BOOL isSelected = [(UIButton *)sender isSelected];
    [(UIButton *) sender setSelected:!isSelected];
    
    if (sender.tag==0) {
        [self.mapKit removeAnnotations:self.mapKit.annotations];

        MKPointAnnotation *annotation1 = [[MKPointAnnotation alloc] init]; //Setting Sample location Annotation
        [annotation1 setCoordinate:CLLocationCoordinate2DMake((self.mapKit.userLocation.location.coordinate.latitude+0.1000939), (self.mapKit.userLocation.location.coordinate.longitude+0.84949949))]; //Add cordinates
        [self.mapKit addAnnotation:annotation1];
        
        [self.mapKit showAnnotations:self.mapKit.annotations animated:YES];
    }
    else  if (sender.tag==0)
    {
        [self.mapKit removeAnnotations:self.mapKit.annotations];
        self.mapKit.showsUserLocation= !self.mapKit.showsUserLocation;
        [self.mapKit showAnnotations:self.mapKit.annotations animated:YES];

    }
    else{
        [self.mapKit removeAnnotations:self.mapKit.annotations];

        MKPointAnnotation *annotation1 = [[MKPointAnnotation alloc] init]; //Setting Sample location Annotation
        [annotation1 setCoordinate:CLLocationCoordinate2DMake((self.mapKit.userLocation.location.coordinate.latitude+0.0000939), (self.mapKit.userLocation.location.coordinate.longitude+0.084949949))]; //Add cordinates
        [self.mapKit addAnnotation:annotation1];
        
        MKPointAnnotation *annotation2 = [[MKPointAnnotation alloc] init]; //Setting Sample location Annotation
        [annotation2 setCoordinate:CLLocationCoordinate2DMake((self.mapKit.userLocation.location.coordinate.latitude+0.0400939), (self.mapKit.userLocation.location.coordinate.longitude+0.084949949))]; //Add cordinates
        [self.mapKit addAnnotation:annotation2];
        
        MKPointAnnotation *annotation3 = [[MKPointAnnotation alloc] init]; //Setting Sample location Annotation
        [annotation3 setCoordinate:CLLocationCoordinate2DMake((self.mapKit.userLocation.location.coordinate.latitude+0.0500939), (self.mapKit.userLocation.location.coordinate.longitude+0.084949949))]; //Add cordinates
        [self.mapKit addAnnotation:annotation3];
        
        MKPointAnnotation *annotation4 = [[MKPointAnnotation alloc] init]; //Setting Sample location Annotation
        [annotation4 setCoordinate:CLLocationCoordinate2DMake((self.mapKit.userLocation.location.coordinate.latitude+0.0220939), (self.mapKit.userLocation.location.coordinate.longitude+0.084949949))]; //Add cordinates
        [self.mapKit addAnnotation:annotation4];
        [self.mapKit showAnnotations:self.mapKit.annotations animated:YES];

    
    }
  
}
/*
 // Override to support conditional editing of the table view.
 - (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
 {
 // Return NO if you do not want the specified item to be editable.
 return YES;
 }
 */

/*
 // Override to support editing the table view.
 - (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
 {
 if (editingStyle == UITableViewCellEditingStyleDelete) {
 // Delete the row from the data source
 [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
 }
 else if (editingStyle == UITableViewCellEditingStyleInsert) {
 // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
 }
 }
 */

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

#pragma mark - Table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Navigation logic may go here. Create and push another view controller.
    /*
     <#DetailViewController#> *detailViewController = [[<#DetailViewController#> alloc] initWithNibName:@"<#Nib name#>" bundle:nil];
     // ...
     // Pass the selected object to the new view controller.
     [self.navigationController pushViewController:detailViewController animated:YES];
     */
}

#pragma mark - ITextFieldDelegate protocol

- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [textField resignFirstResponder];
    return YES;
}


@end
