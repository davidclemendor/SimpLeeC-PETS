//
//  SLShowTotalViewController.m
//  Simplee Expenses
//
//  Created by David Clemendor on 5/1/14.
//  Copyright (c) 2014 Endless Possibilities Finite Solutions Inc. All rights reserved.
//

#import "SLShowTotalViewController.h"
#import "SLAppDelegate.h"

@interface SLShowTotalViewController ()

@property (nonatomic, strong)NSManagedObjectContext *managedObjectContext;
@property (nonatomic, strong)NSFetchedResultsController *fetchedResultsController;

@end

@implementation SLShowTotalViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

-(NSManagedObjectContext*)managedObjectContext {
    
    return [(SLAppDelegate*)[[UIApplication sharedApplication]delegate]managedObjectContext];
    
}

-(void)viewWillAppear:(BOOL)animated
{
    
    
    _yearSegmentOutlet.selectedSegmentIndex = -1;
    _quarter1Outlet.selectedSegmentIndex = -1;
    _quarter2Outlet.selectedSegmentIndex = -1;
    _quarter3Outlet.selectedSegmentIndex = -1;
    _quarter4Outlet.selectedSegmentIndex = -1;
    
    NSDate *date = [NSDate date];
    
    NSCalendar *gregorian = [[NSCalendar alloc] initWithCalendarIdentifier:NSGregorianCalendar];
    NSDateComponents *dateComponents = [gregorian components:NSYearCalendarUnit fromDate:date];
    NSInteger year4 = [dateComponents year];
    NSDateComponents *monthComponents = [gregorian components:NSMonthCalendarUnit fromDate:date];
    NSInteger month = [monthComponents month];
    
    NSInteger year3 = year4 - 1;
    NSInteger year2 = year4 - 2;
    NSInteger year1 = year4 - 3;
    
    NSString *stringYear4 = [@(year4) stringValue];
    NSString *stringYear3 = [@(year3) stringValue];
    NSString *stringYear2 = [@(year2) stringValue];
    NSString *stringYear1 = [@(year1) stringValue];

    [_yearSegmentOutlet setTitle:stringYear4 forSegmentAtIndex:3];
    [_yearSegmentOutlet setTitle:stringYear3 forSegmentAtIndex:2];
    [_yearSegmentOutlet setTitle:stringYear2 forSegmentAtIndex:1];
    [_yearSegmentOutlet setTitle:stringYear1 forSegmentAtIndex:0];

    
    
    if (month >=1 && month <= 3)
    {
       
        if (month == 1)
        {
            _quarter1Outlet.selectedSegmentIndex = 0;
            
        }
        else  if (month == 2)
        {
          _quarter1Outlet.selectedSegmentIndex = 1;
        }
        else  if (month == 3 )
        {
               _quarter1Outlet.selectedSegmentIndex = 2;
        }
    }
    else  if (month >=4 && month <= 6)
    {
    
        
        if (month == 4)
        {
            _quarter2Outlet.selectedSegmentIndex = 0;
            
        }
        else  if (month == 5)
        {
             _quarter2Outlet.selectedSegmentIndex = 1;
            
        }
        else  if (month == 6 )
        {
            _quarter2Outlet.selectedSegmentIndex = 2;
        }

        
    }
    else  if (month >=7 && month <= 9)
    {

        
        if (month == 7)
        {
            _quarter3Outlet.selectedSegmentIndex = 0;
            
        }
        else  if (month == 8)
        {
            _quarter3Outlet.selectedSegmentIndex = 1;
        }
        else  if (month == 9 )
        {
           _quarter3Outlet.selectedSegmentIndex = 2;        }

        
        
    }
    else  if (month >=10 || month <= 12)
    {

        
        if (month == 10)
        {
           _quarter4Outlet.selectedSegmentIndex = 0;
        }
        else  if (month == 11)
        {
           _quarter4Outlet.selectedSegmentIndex = 1;
        }
        else  if (month == 12 )
        {
            _quarter4Outlet.selectedSegmentIndex = 2;
        }

        
        
    }
    
     _yearSegmentOutlet.selectedSegmentIndex = 3;
   
    
    NSDateFormatter *monthFormatter = [[NSDateFormatter alloc]init];
    [monthFormatter setDateFormat:@"MMMM"];
    NSString *stringFromDate = [monthFormatter stringFromDate:date];
    
    self.monthOutlet.text = stringFromDate;
    
    NSDateFormatter *yearFormatter = [[NSDateFormatter alloc]init];
    [yearFormatter setDateFormat:@"YYYY"];
    NSString *stringFromDateYear = [yearFormatter stringFromDate:date];

    self.yearOutlet.text = stringFromDateYear;
    
    [self grandTotals];
    [self ytdTotals];
    
    [self cashTotals];
    [self creditTotals];
    [self debitTotals];
    [self checkTotals];
   
}


- (void) viewDidDisappear:(BOOL)animated
{
    //NSLog(@"view Did Disappear");
    self.fetchedResultsController = nil;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)yearAction:(id)sender {
    UISegmentedControl *segmentedControl = (UISegmentedControl *)sender;
    self.yearOutlet.text = [segmentedControl titleForSegmentAtIndex: [segmentedControl selectedSegmentIndex]];
    [self cashTotals];
    [self creditTotals];
    [self debitTotals];
    [self checkTotals];
    
    [self grandTotals];

    [self ytdTotals];

}

- (IBAction)quarter1Action:(id)sender {
    _quarter2Outlet.selectedSegmentIndex = -1;
    _quarter3Outlet.selectedSegmentIndex = -1;
    _quarter4Outlet.selectedSegmentIndex = -1;
    UISegmentedControl *segmentedControl = (UISegmentedControl *)sender;
    self.monthOutlet.text = [segmentedControl titleForSegmentAtIndex: [segmentedControl selectedSegmentIndex]];
    [self cashTotals];
    [self creditTotals];
    [self debitTotals];
    [self checkTotals];
    
    [self grandTotals];

    
    [self ytdTotals];

    

}

- (IBAction)quarter2Action:(id)sender {
    _quarter1Outlet.selectedSegmentIndex = -1;
    _quarter3Outlet.selectedSegmentIndex = -1;
    _quarter4Outlet.selectedSegmentIndex = -1;
    UISegmentedControl *segmentedControl = (UISegmentedControl *)sender;
    self.monthOutlet.text = [segmentedControl titleForSegmentAtIndex: [segmentedControl selectedSegmentIndex]];
    [self cashTotals];
    [self creditTotals];
    [self debitTotals];
    [self checkTotals];
    
    [self grandTotals];


    [self ytdTotals];

}

- (IBAction)quarter3Action:(id)sender {
    _quarter1Outlet.selectedSegmentIndex = -1;
    _quarter2Outlet.selectedSegmentIndex = -1;
    _quarter4Outlet.selectedSegmentIndex = -1;
    UISegmentedControl *segmentedControl = (UISegmentedControl *)sender;
    self.monthOutlet.text = [segmentedControl titleForSegmentAtIndex: [segmentedControl selectedSegmentIndex]];
    [self cashTotals];
    [self creditTotals];
    [self debitTotals];
    [self checkTotals];
    
    [self grandTotals];

    
    [self ytdTotals];


}

- (IBAction)quarter4Action:(id)sender {
    _quarter1Outlet.selectedSegmentIndex = -1;
    _quarter2Outlet.selectedSegmentIndex = -1;
    _quarter3Outlet.selectedSegmentIndex = -1;
    UISegmentedControl *segmentedControl = (UISegmentedControl *)sender;
    self.monthOutlet.text = [segmentedControl titleForSegmentAtIndex: [segmentedControl selectedSegmentIndex]];
    [self cashTotals];
    [self creditTotals];
    [self debitTotals];
    [self checkTotals];
    
    [self grandTotals];

    
    [self ytdTotals];

}

-(void)cashTotals
{
    
    NSFetchRequest *fetchRequest = [[NSFetchRequest alloc]init];
    
    NSManagedObjectContext *context = [self managedObjectContext];
    
    NSEntityDescription *entity = [NSEntityDescription entityForName:@"Expenses"
                                              inManagedObjectContext:context];
    
    [fetchRequest setEntity:entity];
    
    NSDate *dateFromString = [[NSDate alloc] init];
    dateFromString = [self beginDate:@"MNT"];

    NSDate *dateToString = [[NSDate alloc] init];
    dateToString = [self endDate];
    
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"expenseDate >= %@ AND expenseDate <= %@ AND paymentType = %@",dateFromString, dateToString, @"Cash"];
    
    [fetchRequest setPredicate:predicate];
    
    NSError *error = nil;
    NSArray *cashNumbers = [context executeFetchRequest:fetchRequest   error:&error];
    if (error)
    {
        //NSLog(@"Error! %@", error);
        abort();
    }
    
    float subtotal = 0;
    for (NSManagedObject *object in cashNumbers) {
        NSNumber *objectRowTotalNumber = [object valueForKey:@"expenseAmount"];
        float objectRowTotal = [objectRowTotalNumber floatValue];
        subtotal = subtotal + objectRowTotal;
    }
    //NSLog(@"Subtotal: %f", subtotal);
    
    NSNumberFormatter *numberFormatter = [[NSNumberFormatter alloc]init];
    
    [numberFormatter setNumberStyle:NSNumberFormatterDecimalStyle];
    [numberFormatter setPositiveFormat:@"¤ #,##0.00"];
    [numberFormatter setNegativeFormat:@"¤ -#,##0.00"];
    
    NSString *totalString = [numberFormatter stringFromNumber:[NSNumber numberWithFloat: subtotal]];
    
    self.cashTotal.text = totalString;
}


-(void)creditTotals
{
    
    NSFetchRequest *fetchRequest = [[NSFetchRequest alloc]init];
    
    NSManagedObjectContext *context = [self managedObjectContext];
    
    NSEntityDescription *entity = [NSEntityDescription entityForName:@"Expenses"
                                              inManagedObjectContext:context];
    
    [fetchRequest setEntity:entity];
 
    NSDate *dateFromString = [[NSDate alloc] init];
    dateFromString = [self beginDate:@"MNT"];
    
    
    NSDate *dateToString = [[NSDate alloc] init];
    dateToString = [self endDate];

    
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"expenseDate >= %@ AND expenseDate <= %@ AND paymentType = %@",dateFromString, dateToString, @"Credit"];
    
    [fetchRequest setPredicate:predicate];
    
    NSError *error = nil;
    NSArray *creditNumbers = [context executeFetchRequest:fetchRequest   error:&error];
    if (error)
    {
        //NSLog(@"Error! %@", error);
        abort();
    }
  
    float subtotal = 0;
    for (NSManagedObject *object in creditNumbers) {
        NSNumber *objectRowTotalNumber = [object valueForKey:@"expenseAmount"];
        float objectRowTotal = [objectRowTotalNumber floatValue];
        subtotal = subtotal + objectRowTotal;
    }
    //NSLog(@"Subtotal: %f", subtotal);
    
    NSNumberFormatter *numberFormatter = [[NSNumberFormatter alloc]init];
    
    [numberFormatter setNumberStyle:NSNumberFormatterDecimalStyle];
    [numberFormatter setPositiveFormat:@"¤ #,##0.00"];
    [numberFormatter setNegativeFormat:@"¤ -#,##0.00"];
    
    NSString *totalString = [numberFormatter stringFromNumber:[NSNumber numberWithFloat: subtotal]];
    
    
    self.creditTotalOutlet.text = totalString;
}

-(void)debitTotals
{
    
    NSFetchRequest *fetchRequest = [[NSFetchRequest alloc]init];
    
    NSManagedObjectContext *context = [self managedObjectContext];
    
    NSEntityDescription *entity = [NSEntityDescription entityForName:@"Expenses"
                                              inManagedObjectContext:context];
    
    [fetchRequest setEntity:entity];
    
    
    NSDate *dateFromString = [[NSDate alloc] init];
    dateFromString = [self beginDate:@"MNT"];
    
    
    NSDate *dateToString = [[NSDate alloc] init];
    dateToString = [self endDate];

    
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"expenseDate >= %@ AND expenseDate <= %@ AND paymentType = %@",dateFromString, dateToString, @"Debit"];

    [fetchRequest setPredicate:predicate];
    
    NSError *error = nil;
    NSArray *debitNumbers = [context executeFetchRequest:fetchRequest   error:&error];
    if (error)
    {
        //NSLog(@"Error! %@", error);
        abort();
    }
    
    
    
    float subtotal = 0;
    for (NSManagedObject *object in debitNumbers) {
        NSNumber *objectRowTotalNumber = [object valueForKey:@"expenseAmount"];
        float objectRowTotal = [objectRowTotalNumber floatValue];
        subtotal = subtotal + objectRowTotal;
    }
    //NSLog(@"Subtotal: %f", subtotal);
    
    NSNumberFormatter *numberFormatter = [[NSNumberFormatter alloc]init];
    
    [numberFormatter setNumberStyle:NSNumberFormatterDecimalStyle];
    [numberFormatter setPositiveFormat:@"¤ #,##0.00"];
    [numberFormatter setNegativeFormat:@"¤ -#,##0.00"];
    
    NSString *totalString = [numberFormatter stringFromNumber:[NSNumber numberWithFloat: subtotal]];
    
    self.debitTotalOutlet.text = totalString;
}

-(void)checkTotals
{
    
    NSFetchRequest *fetchRequest = [[NSFetchRequest alloc]init];
    
    NSManagedObjectContext *context = [self managedObjectContext];
    
    NSEntityDescription *entity = [NSEntityDescription entityForName:@"Expenses"
                                              inManagedObjectContext:context];
    
    [fetchRequest setEntity:entity];

    
    NSDate *dateFromString = [[NSDate alloc] init];
    dateFromString = [self beginDate:@"MNT"];
    
    NSDate *dateToString = [[NSDate alloc] init];
    dateToString = [self endDate];

    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"expenseDate >= %@ AND expenseDate <= %@ AND paymentType = %@",dateFromString, dateToString, @"Check"];
    
    [fetchRequest setPredicate:predicate];
    //:completeSettings = none

    NSError *error = nil;
    NSArray *checkNumbers = [context executeFetchRequest:fetchRequest   error:&error];
    if (error)
    {
        //NSLog(@"Error! %@", error);
        abort();
    }
    
    float subtotal = 0;
    for (NSManagedObject *object in checkNumbers) {
        NSNumber *objectRowTotalNumber = [object valueForKey:@"expenseAmount"];
        float objectRowTotal = [objectRowTotalNumber floatValue];
        subtotal = subtotal + objectRowTotal;
    }
    //NSLog(@"Subtotal: %f", subtotal);
    
    NSNumberFormatter *numberFormatter = [[NSNumberFormatter alloc]init];
    
    [numberFormatter setNumberStyle:NSNumberFormatterDecimalStyle];
    [numberFormatter setPositiveFormat:@"¤ #,##0.00"];
    [numberFormatter setNegativeFormat:@"¤ -#,##0.00"];
    
    NSString *totalString = [numberFormatter stringFromNumber:[NSNumber numberWithFloat: subtotal]];
    
    
    self.checkTotalOutlet.text = totalString;
}

-(void)grandTotals
{
    NSFetchRequest *fetchRequest = [[NSFetchRequest alloc]init];
    
    NSManagedObjectContext *context = [self managedObjectContext];
    
    NSEntityDescription *entity = [NSEntityDescription entityForName:@"Expenses"
                                              inManagedObjectContext:context];
    
    [fetchRequest setEntity:entity];
 
    NSDate *dateFromString = [[NSDate alloc] init];
    dateFromString = [self beginDate:@"MNT"];
    
    NSDate *dateToString = [[NSDate alloc] init];
    dateToString = [self endDate];

    
     NSPredicate *predicate = [NSPredicate predicateWithFormat:@"expenseDate >= %@ && expenseDate <= %@" ,dateFromString, dateToString];
    
    [fetchRequest setPredicate:predicate];
    
    NSError *error = nil;
    NSArray *grandNumbers = [context executeFetchRequest:fetchRequest   error:&error];
    if (error)
    {
        NSLog(@"Error! %@", error);
        abort();
    }

    
     float subtotal = 0;
         for (NSManagedObject *object in grandNumbers) {
         NSNumber *objectRowTotalNumber = [object valueForKey:@"expenseAmount"];
         float objectRowTotal = [objectRowTotalNumber floatValue];
         subtotal = subtotal + objectRowTotal;
     }
     //NSLog(@"Subtotal: %f", subtotal);
     
     NSNumberFormatter *numberFormatter = [[NSNumberFormatter alloc]init];
     
     [numberFormatter setNumberStyle:NSNumberFormatterDecimalStyle];
     [numberFormatter setPositiveFormat:@"¤ #,##0.00"];
     [numberFormatter setNegativeFormat:@"¤ -#,##0.00"];
     
     NSString *totalString = [numberFormatter stringFromNumber:[NSNumber numberWithFloat: subtotal]];
    
     self.grandTotalOutlet.text = totalString;
}

-(void)ytdTotals
{
    
    NSFetchRequest *fetchRequest = [[NSFetchRequest alloc]init];
    
    NSManagedObjectContext *context = [self managedObjectContext];
    
    NSEntityDescription *entity = [NSEntityDescription entityForName:@"Expenses"
                                              inManagedObjectContext:context];
    
    [fetchRequest setEntity:entity];

    NSDate *dateFromString = [[NSDate alloc] init];
    dateFromString = [self beginDate:@"YTD"];    
    
    NSDate *dateToString = [[NSDate alloc] init];
    dateToString = [self endDate];
    
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"expenseDate >= %@ && expenseDate <= %@" ,dateFromString, dateToString];
    
    [fetchRequest setPredicate:predicate];

    NSError *error = nil;
    NSArray *ytdNumbers = [context executeFetchRequest:fetchRequest   error:&error];
    if (error)
    {
        //NSLog(@"Error! %@", error);
        abort();
    }
    
    float subtotal = 0;
    for (NSManagedObject *object in ytdNumbers) {
        NSNumber *objectRowTotalNumber = [object valueForKey:@"expenseAmount"];
        float objectRowTotal = [objectRowTotalNumber floatValue];
        subtotal = subtotal + objectRowTotal;
    }
    //NSLog(@"Subtotal: %f", subtotal);
    
    NSNumberFormatter *numberFormatter = [[NSNumberFormatter alloc]init];
    
    [numberFormatter setNumberStyle:NSNumberFormatterDecimalStyle];
    [numberFormatter setPositiveFormat:@"¤ #,##0.00"];
    [numberFormatter setNegativeFormat:@"¤ -#,##0.00"];
    
    NSString *totalString = [numberFormatter stringFromNumber:[NSNumber numberWithFloat: subtotal]];
    
    self.ytdTotalOutlet.text = totalString;
}


-(NSDate *)beginDate:(NSString *)monthOrYtd{
    
    NSString *monthString;
    NSString *dayString;
    NSString *yearString;
    
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    
    NSDate *dateFromString = [[NSDate alloc] init];
    
    if ([monthOrYtd  isEqual: @"YTD"])
    {
        monthString = @"January";
        dayString = @"1";
        yearString = self.yearOutlet.text;
    }
    else
    {
        monthString = self.monthOutlet.text;
        dayString = @"1";
        yearString = self.yearOutlet.text;
    }
        
        
    NSString *fileLine = [NSString stringWithFormat:@"%@, %@, %@", monthString, dayString, yearString];
    
    [dateFormatter setDateFormat:@"MMMM, dd, yyyy"];
    
    dateFromString = [dateFormatter dateFromString:fileLine];
    
    return dateFromString;
}

-(NSDate *)endDate{
    
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    
    NSDate *dateToString = [[NSDate alloc] init];

    [dateFormatter setDateFormat:@"MMMM, dd, yyyy"];
    
    NSString *monthToString = self.monthOutlet.text;
    NSString *dayToString;
    NSString *yearToString = self.yearOutlet.text;
    NSString *yearIsLeap;
    
    yearIsLeap = [self leapYear:yearToString];
    
    if ([monthToString isEqualToString:@"February"])
    {
        if ([yearIsLeap isEqualToString:@"Leap Year"])
        {
            dayToString = @"29";
        }
        else
        {
           dayToString = @"28";
        }
    } else
        if ([monthToString isEqualToString:@"April"]
            ||[monthToString isEqualToString:@"June"]
            ||[monthToString isEqualToString:@"September"]
            ||[monthToString isEqualToString:@"November"]
            ){
            dayToString = @"30";
        } else {
            dayToString = @"31";
        }
   
    
    NSString *toDate = [NSString stringWithFormat:@"%@, %@, %@", monthToString, dayToString, yearToString];
    
    [dateFormatter setDateFormat:@"MMMM, dd, yyyy"];
    
    dateToString = [dateFormatter dateFromString:toDate];
    
    return dateToString;

}


-(NSString *)leapYear:(NSString *)yearString
{

    NSInteger yearInt = [yearString integerValue];
    NSString *leapId;

    if(((yearInt %4==0)&&(yearInt %100!=0))||(yearInt %400==0))
    {
        leapId = @"Leap Year";
        NSLog(@"Leap Year");
    }
    else
    {
        leapId = @"Not a Leap Year";
        NSLog(@"Not a Leap Year");
    }

    return leapId;
}


/*
if(((yearint %4==0)&&(yearint %100!=0))||(yearint %400==0)){
    NSLog(@"Leap Year");
}
else{
    NSLog(@"Not a Leap Year");
}
*/

@end
