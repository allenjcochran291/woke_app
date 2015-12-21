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


@interface MapViewController ()
@property (weak, nonatomic) IBOutlet UITableView *tableView;

@end

@implementation MapViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [_tableView reloadData];
    [self.tableView registerNib:[UINib nibWithNibName:@"CustomCell" bundle:nil] forCellReuseIdentifier:@"Cell"];
    self.mapKit.delegate = (id)self;
    
    //Set Default location to zoom
    CLLocationCoordinate2D noLocation = CLLocationCoordinate2DMake(51.900708, -2.083160); //Create the CLLocation from user cordinates
    MKCoordinateRegion viewRegion = MKCoordinateRegionMakeWithDistance(noLocation, 50000, 50000); //Set zooming level
    MKCoordinateRegion adjustedRegion = [self.mapKit regionThatFits:viewRegion]; //add location to map
    [self.mapKit setRegion:adjustedRegion animated:YES]; // create animation zooming
    
    // Place Annotation Point
    MKPointAnnotation *annotation1 = [[MKPointAnnotation alloc] init]; //Setting Sample location Annotation
    [annotation1 setCoordinate:CLLocationCoordinate2DMake(51.900708, -2.083160)]; //Add cordinates
    [self.mapKit addAnnotation:annotation1];

}

-(MKAnnotationView *)mapView:(MKMapView *)mV viewForAnnotation:(id <MKAnnotation>)annotation
{
    AnnotationView *pinView = nil; //create MKAnnotationView Property
    
    static NSString *defaultPinID = @"com.invasivecode.pin"; //Get the ID to change the pin
    pinView = (AnnotationView *)[self.mapKit dequeueReusableAnnotationViewWithIdentifier:defaultPinID]; //Setting custom MKAnnotationView to the ID
    if ( pinView == nil )
        pinView = [[AnnotationView alloc]
                   initWithAnnotation:annotation reuseIdentifier:defaultPinID]; // init pinView with ID
    
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
    return 10;
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
        cell.switchbuttonPro.tag =indexPath.row;

    }

    // Configure the cell before it is displayed...
    [cell.switchbuttonPro addTarget:self
                             action:@selector(clickToggle:)
                   forControlEvents:UIControlEventTouchUpInside];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;
}
-(void) clickToggle:(id) sender {
    
    BOOL isSelected = [(UIButton *)sender isSelected];
    [(UIButton *) sender setSelected:!isSelected];
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
