//
//  SLExpenseCategoryTableViewController.m
//  Simplee Expenses
//
//  Created by David Clemendor on 5/4/14.
//  Copyright (c) 2014 Endless Possibilities Finite Solutions Inc. All rights reserved.
//

#import "SLExpenseCategoryTableViewController.h"

@interface SLExpenseCategoryTableViewController ()
{
    NSMutableArray *categoryNames;
    NSMutableArray *results;
    
}

@property (nonatomic, strong) NSMutableArray *categoryNames;
@property (nonatomic, strong) NSMutableArray *resultSet;

@end

@implementation SLExpenseCategoryTableViewController

@synthesize delegate, pickCategoryStringValue;

@synthesize categoryNames;
//@synthesize resultSet;

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
    NSString *categoryPath = [[NSBundle mainBundle] pathForResource:@"Category"
                                                         ofType:@"json"];
    
    NSData *categoryData = [NSData dataWithContentsOfFile:categoryPath];
    NSError *categoryError = nil;
 
    
    NSDictionary *categoryDict = [NSJSONSerialization
                              JSONObjectWithData:categoryData
                              options:0
                              error:&categoryError];
    
    categoryNames = [[NSMutableArray alloc]init];
    NSMutableArray *drugNames2 = [NSMutableArray array];
    for (id identifier in [categoryDict objectForKey:@"Category"])
    {
        
        NSString *categoryName = [identifier objectForKey:@"Name"];
        
        [self.categoryNames addObject:categoryName];
        [drugNames2 addObject:categoryName];

    }
    [self.categoryNames sortUsingSelector:@selector(localizedCaseInsensitiveCompare:)];
    
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
    
    self.resultSet = [[self.categoryNames filteredArrayUsingPredicate:resultsPredicate]mutableCopy];
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
    //return [self.categoryNames count];
    
    if (tableView == self.tableView) {
        return [self.categoryNames count];
    } else {
        [self searchThroughData];
        return [self.resultSet count];
    }

    // Return the number of rows in the section.

}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";
    //UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier forIndexPath:indexPath];
   UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    
    if (cell == nil)
    {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
    }
    
    if (tableView == self.tableView){
        cell.textLabel.text = [self.categoryNames objectAtIndex:indexPath.row];
    } else {
        cell.textLabel.text = [self.resultSet objectAtIndex:indexPath.row];
    }
    
     // Configure the cell...
    
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *selectedCell=[tableView cellForRowAtIndexPath:indexPath];
    
    pickCategoryStringValue = selectedCell.textLabel.text;
    
    [[self delegate]setCategory:pickCategoryStringValue];
    
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (IBAction)cancel:(id)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (IBAction)save:(id)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
}
@end
