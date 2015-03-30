//
//  SLExpenseTableViewController.m
//  Simplee Expenses
//
//  Created by David Clemendor on 5/1/14.
//  Copyright (c) 2014 Endless Possibilities Finite Solutions Inc. All rights reserved.
//

#import "SLExpenseTableViewController.h"
#import "SLAppDelegate.h"
#import "SLAddExpenseViewController.h"
#import "SLReadExpenseViewController.h"
#import "SLCustomTableViewCell.h"


@interface SLExpenseTableViewController ()

@property (nonatomic, strong) NSManagedObjectContext *managedObjectContext;
@property (nonatomic, strong) NSFetchedResultsController *fetchedResultsController;

@end

@implementation SLExpenseTableViewController

- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
        // Custom initialization
    }
    return self;
}

-(NSManagedObjectContext*)managedObjectContext {
    
    return [(SLAppDelegate*)[[UIApplication sharedApplication]delegate]managedObjectContext];
    
}


-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(UITableViewCell*)sender{
    
    if ([[segue identifier]isEqualToString:@"addExpense"]){
        
        UINavigationController *navigationController = segue.destinationViewController;
        
        SLAddExpenseViewController *addExpenseViewController = (SLAddExpenseViewController*)navigationController.topViewController;
        
        Expenses *addExpense = [NSEntityDescription insertNewObjectForEntityForName:@"Expenses" inManagedObjectContext:[self managedObjectContext]];
        
        addExpenseViewController.addExpense = addExpense;
    }
    
    if ([[segue identifier]isEqualToString:@"viewExpense"]) {
        UINavigationController *navigationController = segue.destinationViewController;
        SLReadExpenseViewController *readExpenseViewController = (SLReadExpenseViewController*)
        navigationController.topViewController;
        
        NSIndexPath *indexPath = [self.tableView indexPathForCell:sender];
        Expenses *addExpense = (Expenses*)[self.fetchedResultsController objectAtIndexPath:indexPath];
        readExpenseViewController.addExpense = addExpense;
        
    } 
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    NSError *error = nil;
    
    if (![[self fetchedResultsController]performFetch:&error]){
        //NSLog(@"Error! %@", error);
        abort();
    }

    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
}

-(void)viewWillAppear:(BOOL)animated{
    
    [self.tableView reloadData];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return [[self.fetchedResultsController sections]count];

}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    id<NSFetchedResultsSectionInfo> sectionInfo = [[self.fetchedResultsController sections] objectAtIndex:section];
    
    return [sectionInfo numberOfObjects];
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";

    NSDate *today;

    today = [NSDate date];

    SLCustomTableViewCell *customCell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier forIndexPath:indexPath];
    
    Expenses *expenses = [self.fetchedResultsController objectAtIndexPath:indexPath];
    
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"MM/dd/yyyy"];
    NSString *strDate = [dateFormatter stringFromDate:expenses.expenseDate];
    
    NSNumberFormatter *numberFormatter = [[NSNumberFormatter alloc]init];
    
    [numberFormatter setNumberStyle:NSNumberFormatterDecimalStyle];
    [numberFormatter setPositiveFormat:@"¤ #,##0.00"];
    [numberFormatter setNegativeFormat:@"¤ -#,##0.00"];
    
    NSString *strCurrency = [numberFormatter stringFromNumber:expenses.expenseAmount];

    customCell.customCategory.text = expenses.expenseType;
    customCell.customDate.text = strDate;
    customCell.customAmount.text = strCurrency;
    
    // Configure the cell...
    
    return customCell;
}


-(NSFetchedResultsController*)fetchedResultsController {
    
    if (_fetchedResultsController != nil){
        return _fetchedResultsController;
    }
    
    NSFetchRequest *fetchRequest = [[NSFetchRequest alloc]init];
    
    NSManagedObjectContext *context = [self managedObjectContext];
    
    NSEntityDescription *entity = [NSEntityDescription entityForName:@"Expenses"
                                              inManagedObjectContext:context];
    
    [fetchRequest setEntity:entity];
    
    NSSortDescriptor *sortDescriptor = [[NSSortDescriptor alloc]initWithKey:@"expenseDate" ascending:NO];
    
    NSArray *sortDescriptors = [[NSArray alloc]initWithObjects:sortDescriptor, nil];
    
    fetchRequest.sortDescriptors = sortDescriptors;
    
    _fetchedResultsController = [[NSFetchedResultsController alloc] initWithFetchRequest:fetchRequest managedObjectContext:context sectionNameKeyPath:nil cacheName:nil];
    
    _fetchedResultsController.delegate = self;
    
    return _fetchedResultsController;
    
}

// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        
        NSManagedObjectContext *context = self.managedObjectContext;
        
        Expenses *expenseToDelete = [self.fetchedResultsController objectAtIndexPath:indexPath];
        
        [context deleteObject:expenseToDelete];
        
        NSError *error = nil;
        
        if (![context save:&error]) {
            //NSLog(@"Error! %@", error);
        }        
    }
}


#pragma mark - Fetched Results Controller Delegates


-(void)controllerWillChangeContent:(NSFetchedResultsController *)controller{
    
    [self.tableView beginUpdates];
    
}

-(void)controllerDidChangeContent:(NSFetchedResultsController *)controller{
    
    [self.tableView endUpdates];
    
}


-(void)controller:(NSFetchedResultsController *)controller didChangeObject:(id)anObject atIndexPath:(NSIndexPath *)indexPath forChangeType:(NSFetchedResultsChangeType)type newIndexPath:(NSIndexPath *)newIndexPath
{
    UITableView *tableView = self.tableView;
    
    
    switch (type) {
            
            
        case NSFetchedResultsChangeInsert:
            [tableView insertRowsAtIndexPaths:[NSArray arrayWithObjects:newIndexPath, nil] withRowAnimation:UITableViewRowAnimationFade];
            break;
        case NSFetchedResultsChangeDelete:
            [tableView deleteRowsAtIndexPaths:[NSArray arrayWithObjects:indexPath, nil] withRowAnimation:UITableViewRowAnimationFade];
            break;
        case NSFetchedResultsChangeUpdate:
        {
            break;
        }
        case NSFetchedResultsChangeMove:
            [tableView deleteRowsAtIndexPaths:[NSArray arrayWithObjects:indexPath, nil] withRowAnimation:UITableViewRowAnimationFade];
            [tableView insertRowsAtIndexPaths:[NSArray arrayWithObjects:newIndexPath, nil] withRowAnimation:UITableViewRowAnimationFade];
            break;
        default:
            break;
    }
}

-(void)controller:(NSFetchedResultsController *)controller didChangeSection:(id<NSFetchedResultsSectionInfo>)sectionInfo atIndex:(NSUInteger)sectionIndex forChangeType:
(NSFetchedResultsChangeType)type
{
    switch (type) {
        case NSFetchedResultsChangeInsert:
            [self.tableView insertSections:[NSIndexSet indexSetWithIndex:sectionIndex]withRowAnimation:UITableViewRowAnimationFade];
            break;
        case NSFetchedResultsChangeDelete:
            [self.tableView deleteSections:[NSIndexSet indexSetWithIndex:sectionIndex]withRowAnimation:UITableViewRowAnimationFade];
            break;
        default:
            break;
    }
    
}

@end
