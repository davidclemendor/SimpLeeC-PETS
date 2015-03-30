//
//  SLUtilityViewController.m
//  Simplee Expenses
//
//  Created by David Clemendor on 5/6/14.
//  Copyright (c) 2014 Endless Possibilities Finite Solutions Inc. All rights reserved.
//

#import "SLUtilityViewController.h"
#import "SLAppDelegate.h"

@interface SLUtilityViewController ()<MFMailComposeViewControllerDelegate,UINavigationControllerDelegate>

@property (nonatomic, strong) NSManagedObjectContext *managedObjectContext;
@property (nonatomic, strong) NSFetchedResultsController *fetchedResultsController;

@end

@implementation SLUtilityViewController

-(NSManagedObjectContext*)managedObjectContext {
    
    return [(SLAppDelegate*)[[UIApplication sharedApplication]delegate]managedObjectContext];
}


- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    NSError *error = nil;
 
    NSManagedObjectContext *context = [self managedObjectContext];
    
    NSEntityDescription *entity = [NSEntityDescription entityForName:@"Expenses" inManagedObjectContext:context];
 
    NSFetchRequest *fetchRequest = [[NSFetchRequest alloc]init];
    
    [fetchRequest setEntity:entity];

    NSInteger count = [context countForFetchRequest:fetchRequest error:&error];
    
    NSString *totalString = [NSString stringWithFormat:@"%ld", (long)count];

    self.numberOfRecords.text = totalString;
    
    // Do any additional setup after loading the view.
}


-(void)viewWillAppear:(BOOL)animated{

    NSError *error = nil;
    
    NSManagedObjectContext *context = [self managedObjectContext];
    
    NSEntityDescription *entity = [NSEntityDescription entityForName:@"Expenses" inManagedObjectContext:context];
    
    NSFetchRequest *fetchRequest = [[NSFetchRequest alloc]init];
    
    [fetchRequest setEntity:entity];
    
    NSInteger count = [context countForFetchRequest:fetchRequest error:&error];
    
    NSString *totalString = [NSString stringWithFormat:@"%ld", (long)count];

    self.numberOfRecords.text = totalString;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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
    
    NSSortDescriptor *sortDescriptor = [[NSSortDescriptor alloc]initWithKey:@"expenseDate" ascending:YES];
    
    NSArray *sortDescriptors = [[NSArray alloc]initWithObjects:sortDescriptor, nil];
    
    fetchRequest.sortDescriptors = sortDescriptors;
    
    _fetchedResultsController = [[NSFetchedResultsController alloc] initWithFetchRequest:fetchRequest managedObjectContext:context sectionNameKeyPath:nil cacheName:nil];
    
    _fetchedResultsController.delegate = self;
    
    return _fetchedResultsController;
}

- (void)mailComposeController:(MFMailComposeViewController*)controller
          didFinishWithResult:(MFMailComposeResult)result error:(NSError*)error
{
	//self.feedbackMsg.hidden = NO;
	// Notifies users about errors associated with the interface
	switch (result)
	{
		case MFMailComposeResultCancelled:
            //NSLog(@"File Created");
			//self.feedbackMsg.text = @"Result: Mail sending canceled";
			break;
		case MFMailComposeResultSaved:
			//self.feedbackMsg.text = @"Result: Mail saved";
            //NSLog(@"File Created");
			break;
		case MFMailComposeResultSent:
			//self.feedbackMsg.text = @"Result: Mail sent";
            //NSLog(@"File Created");
			break;
		case MFMailComposeResultFailed:
			//self.feedbackMsg.text = @"Result: Mail sending failed";
            //NSLog(@"File Created");
			break;
		default:
			//self.feedbackMsg.text = @"Result: Mail not sent";
            //NSLog(@"Result: Mail not sent");
			break;
	}
    
	[self dismissViewControllerAnimated:YES completion:NULL];
}


- (IBAction)sendEmail:(id)sender {
    
    //NSLog(@"Send Email");
    
    MFMailComposeViewController *mailComposer = [[MFMailComposeViewController alloc]init];
    [mailComposer setMailComposeDelegate:self];
    
    if ([MFMailComposeViewController canSendMail])
    {
        //NSLog(@"Can Send Mail");
        
        [mailComposer setSubject:@"SimpLeeC Mail Data"];
        
        // Set up recipients
        NSArray *toRecipients = [NSArray arrayWithObject:@"davidclemendor@yahoo.com"];

        [mailComposer setToRecipients:toRecipients];

        NSError *error = nil;
        
        NSManagedObjectContext *context = [self managedObjectContext];
        
        NSEntityDescription *entity = [NSEntityDescription entityForName:@"Expenses" inManagedObjectContext:context];
        
        NSFetchRequest *fetchRequest = [[NSFetchRequest alloc]init];
        
        [fetchRequest setEntity:entity];
        
        NSSortDescriptor *sortDescriptor = [[NSSortDescriptor alloc]initWithKey:@"expenseDate" ascending:YES];
        
        NSArray *sortDescriptors = [[NSArray alloc]initWithObjects:sortDescriptor, nil];
        
        fetchRequest.sortDescriptors = sortDescriptors;
        
        [fetchRequest setEntity:entity];
        
        NSMutableArray *results = [[NSMutableArray alloc] init];
        NSArray *fetchedObjects = [context executeFetchRequest:fetchRequest error:&error];
        
        NSString *docPath = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES)objectAtIndex:0];
        
        NSString *surveys=[docPath stringByAppendingPathComponent:@"results.csv"];
        
        NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
        
        [dateFormatter setTimeStyle:NSDateFormatterNoStyle];
        
        [dateFormatter setDateStyle:NSDateFormatterMediumStyle];
        
        NSLocale *usLocale = [[NSLocale alloc] initWithLocaleIdentifier:@"en_US"];
        
        [dateFormatter setLocale:usLocale];
        
        [dateFormatter setDateFormat:@"MM/dd/yyyy"];
        
        NSString *expenseDateString;
        NSString *strCurrency;
        
        NSNumberFormatter *numberFormatter = [[NSNumberFormatter alloc]init];
        
        [numberFormatter setNumberStyle:NSNumberFormatterDecimalStyle];
        //[numberFormatter setPositiveFormat:@" #,##0.00"];
        //[numberFormatter setNegativeFormat:@" -#,##0.00"];
        
        [numberFormatter setPositiveFormat:@" ###0.00"];
        [numberFormatter setNegativeFormat:@" -###0.00"];

        
       
        [results addObject:[NSString stringWithFormat:@"%@ ,%@ ,%@, %@, %@, %@", @"Date", @"Amount",  @"Where", @"What",
                            @"Payment", @"Why"]];
        for (Expenses *expensesCSV in fetchedObjects) {
            
            expenseDateString = [dateFormatter stringFromDate:expensesCSV.expenseDate];
            strCurrency = [numberFormatter stringFromNumber:expensesCSV.expenseAmount];

            [results addObject:[NSString stringWithFormat:@"%@ ,%@ ,%@, %@, %@, %@", expenseDateString, strCurrency,  expensesCSV.expenseOutlet, expensesCSV.expenseType,
                                expensesCSV.paymentType, expensesCSV.expenseWhy]];
            
        }

        NSString *myString = [results componentsJoinedByString:@"\n"];
        
        BOOL write = [myString writeToFile:surveys atomically:YES encoding:NSUTF8StringEncoding error:nil ];
        
        if (write) {
            //NSLog(@"File has written");
        }
        

        NSString *emailBody = @"Your Financial Data from SimpLeeC Personal Expense Tracking System (PETS) http://notal1970.wix.com/epfsinc";

        [mailComposer setMessageBody:emailBody isHTML:NO];
        
        [mailComposer addAttachmentData:[NSData dataWithContentsOfFile:surveys]
        mimeType:@"text/csv"
        fileName:@"results.csv"];
        
        [mailComposer setModalTransitionStyle:UIModalTransitionStyleCrossDissolve];
        
        [self presentViewController:mailComposer animated:YES completion:NULL];
        
    }

}


- (IBAction)resetDatabase:(id)sender {
    
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Really reset?" message:@"Do you really want to reset this Appplication?" delegate:self cancelButtonTitle:@"Cancel" otherButtonTitles:nil];
    // optional - add more buttons:
    [alert addButtonWithTitle:@"Yes"];
    [alert show];
    
}

- (void) alertView: (UIAlertView *)alertView didDismissWithButtonIndex:(NSInteger)buttonIndex
{
    NSLog(@"Alert View didDismissWithButtonIndex");

    if (buttonIndex == 1)
    {
        NSManagedObjectContext *context = [self managedObjectContext];
    
        NSFetchRequest *fetchRequest = [[NSFetchRequest alloc] init];
        NSEntityDescription *entity = [NSEntityDescription entityForName:@"Expenses" inManagedObjectContext:context];
        [fetchRequest setIncludesPropertyValues:NO]; //only fetch the managedObjectID
        [fetchRequest setEntity:entity];
    
        NSError * error = nil;
        NSArray * expenses = [context executeFetchRequest:fetchRequest error:&error];
    
        for (NSManagedObject *expense in expenses)
        {
            [context deleteObject:expense];
        }
    
        if ([self.managedObjectContext hasChanges])
        {
            if (![self.managedObjectContext save:&error]) {
                //NSLog(@"Save Failed: %@", [error localizedDescription]);
            } else {
                //NSLog(@"Save Succeeded");
                self.numberOfRecords.text = @"0";
            }
        
        }
    }
}


@end
