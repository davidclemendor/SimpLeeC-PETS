//
//  SLExpenseVendorTableViewController.m
//  Simplee Expenses
//
//  Created by David Clemendor on 5/4/14.
//  Copyright (c) 2014 Endless Possibilities Finite Solutions Inc. All rights reserved.
//

#import "SLExpenseVendorTableViewController.h"

@interface SLExpenseVendorTableViewController ()

{
    NSMutableArray *vendorsNames;
    NSMutableArray *results;    
}

@property (nonatomic, strong) NSMutableArray *vendorsNames;
@property (nonatomic, strong) NSMutableArray *resultSet;

@end

@implementation SLExpenseVendorTableViewController

@synthesize delegate, pickVendorStringValue;

@synthesize vendorsNames;
@synthesize resultSet;

- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
}

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    NSString *vendorsPath = [[NSBundle mainBundle] pathForResource:@"Vendors"
                                                             ofType:@"json"];
    
    NSData *vendorsData = [NSData dataWithContentsOfFile:vendorsPath];
    NSError *vendorsError = nil;
    
    NSDictionary *categoryDict = [NSJSONSerialization
                                  JSONObjectWithData:vendorsData
                                  options:0
                                  error:&vendorsError];
    
    vendorsNames = [[NSMutableArray alloc]init];
    NSMutableArray *vendorsNames2 = [NSMutableArray array];
    for (id identifier in [categoryDict objectForKey:@"Vendors"])
    {

        NSString *vendorsName = [identifier objectForKey:@"Name"];

        [self.vendorsNames addObject:vendorsName];
        [vendorsNames2 addObject:vendorsName];
    }
    [self.vendorsNames sortUsingSelector:@selector(localizedCaseInsensitiveCompare:)];
    
    //NSLog(@"View Will Appear");
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)searchThroughData {
    
    self.resultSet = nil;
    
    NSPredicate *resultsPredicate = [NSPredicate predicateWithFormat:@"SELF beginswith [search] %@", self.searchBar.text];
    
    self.resultSet = [[self.vendorsNames filteredArrayUsingPredicate:resultsPredicate]mutableCopy];
}

-(void)searchBar:(UISearchBar *)searchBar textDidChange:(NSString *)searchText
{
    [self searchThroughData];
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{

    if (tableView == self.tableView) {
        return [self.vendorsNames count];
    } else {
        [self searchThroughData];
        return [self.resultSet count];
    }

}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    
    if (cell == nil)
    {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
    }
    
    if (tableView == self.tableView){
        cell.textLabel.text = [self.vendorsNames objectAtIndex:indexPath.row];
    } else {
        cell.textLabel.text = [self.resultSet objectAtIndex:indexPath.row];
    }
  
    // Configure the cell...
    
    return cell;
}


-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *selectedCell=[tableView cellForRowAtIndexPath:indexPath];
    
    pickVendorStringValue = selectedCell.textLabel.text;
    
    [[self delegate]setVendor:pickVendorStringValue];
    
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (IBAction)cancel:(id)sender {
    //NSString *test = cell.textLabel.text;
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (IBAction)save:(id)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
}
@end
