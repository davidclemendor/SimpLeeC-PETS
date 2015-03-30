//
//  SLExpenseWhyTableViewController.m
//  Simplee Expenses
//
//  Created by David Clemendor on 5/15/14.
//  Copyright (c) 2014 Endless Possibilities Finite Solutions Inc. All rights reserved.
//

#import "SLExpenseWhyTableViewController.h"

@interface SLExpenseWhyTableViewController ()

{
    NSMutableArray *reasonNames;
    NSMutableArray *results;
    
}

@property (nonatomic, strong) NSMutableArray *reasonNames;
@property (nonatomic, strong) NSMutableArray *resultSet;

@end

@implementation SLExpenseWhyTableViewController

@synthesize delegate, pickWhyStringValue,reasonNames;

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
    
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
}

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    NSString *reasonPath = [[NSBundle mainBundle] pathForResource:@"Reasons"
                                                             ofType:@"json"];
    
    NSData *reasonData = [NSData dataWithContentsOfFile:reasonPath];
    NSError *reasonError = nil;
    /* id json = [NSJSONSerialization JSONObjectWithData:data
     options:kNilOptions
     error:&error]; */
    
    NSDictionary *reasonDict = [NSJSONSerialization
                                  JSONObjectWithData:reasonData
                                  options:0
                                  error:&reasonError];
    
    reasonNames = [[NSMutableArray alloc]init];
    NSMutableArray *drugNames2 = [NSMutableArray array];
    for (id identifier in [reasonDict objectForKey:@"Why"])
    {

        NSString *categoryName = [identifier objectForKey:@"Name"];

        [self.reasonNames addObject:categoryName];
        [drugNames2 addObject:categoryName];

    }
    [self.reasonNames sortUsingSelector:@selector(localizedCaseInsensitiveCompare:)];
    
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
    
    self.resultSet = [[self.reasonNames filteredArrayUsingPredicate:resultsPredicate]mutableCopy];
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
    // Return the number of rows in the section.
    
    if (tableView == self.tableView) {
        return [self.reasonNames count];
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
        cell.textLabel.text = [self.reasonNames objectAtIndex:indexPath.row];
    } else {
        cell.textLabel.text = [self.resultSet objectAtIndex:indexPath.row];
    }
    
    // Configure the cell...
    
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *selectedCell=[tableView cellForRowAtIndexPath:indexPath];
    
    pickWhyStringValue = selectedCell.textLabel.text;
    
    [[self delegate]setWhy:pickWhyStringValue];
    
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (IBAction)cancel:(id)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (IBAction)save:(id)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
}
@end
