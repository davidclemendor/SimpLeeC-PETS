//
//  SLAddExpenseViewController.m
//  Simplee Expenses
//
//  Created by David Clemendor on 5/1/14.
//  Copyright (c) 2014 Endless Possibilities Finite Solutions Inc. All rights reserved.
//

#import "SLAddExpenseViewController.h"

@interface SLAddExpenseViewController ()

@end

@implementation SLAddExpenseViewController

@synthesize addExpense;
int theInteger;

@synthesize dateExpenseStringValue, pickCategoryStringValue, pickVendorStringValue, pickWhyStringValue,segmentPaymentStringValue;

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
    
    _amount.delegate = self;
    
    NSDate *today = [NSDate date];
    
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    
    [dateFormatter setTimeStyle:NSDateFormatterNoStyle];
    
    [dateFormatter setDateStyle:NSDateFormatterMediumStyle];
   
    [dateFormatter setDateFormat:@"MM/dd/yyyy"];

    if (dateExpenseStringValue)
    {
       [self.dateExpenseLabel setTitle:dateExpenseStringValue forState:UIControlStateNormal];
        
    } else {
    
        [self.dateExpenseLabel setTitle:[dateFormatter stringFromDate:today] forState:UIControlStateNormal];
    }

}

-(void)viewWillAppear:(BOOL)animated
{
    
    if (dateExpenseStringValue)
    {
        [self.dateExpenseLabel setTitle:dateExpenseStringValue forState:UIControlStateNormal];
        
    }
    
    if (pickCategoryStringValue)
    {
        [self.pickCategoryButton setTitle:pickCategoryStringValue forState:UIControlStateNormal];
        
    }
    
    if (pickVendorStringValue)
    {
        [self.pickVendorButton setTitle:pickVendorStringValue forState:UIControlStateNormal];
        
    }
    
    if (pickWhyStringValue)
    {
        [self.pickExpenseWhyButton setTitle:pickWhyStringValue forState:UIControlStateNormal];
        
    }

}

-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    
    if ([[segue identifier] isEqualToString:@"datePicker"]) {
        UINavigationController *navController = segue.destinationViewController;
        
        SLDatePickViewController *vc2 = (SLDatePickViewController*)navController.topViewController;
        
        [vc2 setDelegate:self];
    }
    
    if ([[segue identifier] isEqualToString:@"category"]) {
        UINavigationController *navController = segue.destinationViewController;
        
        SLExpenseCategoryTableViewController *vc2 = (SLExpenseCategoryTableViewController*)navController.topViewController;

        [vc2 setDelegate:self];
    }
    
    if ([[segue identifier] isEqualToString:@"vendor"]) {
        UINavigationController *navController = segue.destinationViewController;
        
        SLExpenseVendorTableViewController *vc2 = (SLExpenseVendorTableViewController*)navController.topViewController;
        
        [vc2 setDelegate:self];
    }
    
    if ([[segue identifier] isEqualToString:@"why"]) {
        UINavigationController *navController = segue.destinationViewController;
        
        SLExpenseWhyTableViewController *vc2 = (SLExpenseWhyTableViewController*)navController.topViewController;
        
        [vc2 setDelegate:self];
    }



}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)cancel:(id)sender {
    [super cancelAndDismiss];
}

- (IBAction)save:(id)sender {
   
    if ([_amount.text isEqualToString:@""])
    {
        UIAlertView *alert = [[UIAlertView alloc]
                              initWithTitle:@"Field Check"
                              message:@"Amount is required Field"
                              delegate:self
                              cancelButtonTitle:@"OK"
                              otherButtonTitles:nil, nil];
        
        [alert show];
        
        return;
    }

    NSDate *today;

    today = [NSDate date];
    
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    // this is imporant - we set our input date format to match our input string
    // if format doesn't match you'll get nil from your string, so be careful
    [dateFormatter setDateFormat:@"MM/dd/yyyy"];
    NSDate *dateFromString = [[NSDate alloc] init];

    dateFromString = [dateFormatter dateFromString:dateExpenseStringValue];
    
    NSNumberFormatter *numberFormatter = [[NSNumberFormatter alloc] init];
    
    [numberFormatter setNumberStyle:NSNumberFormatterDecimalStyle];
    
    NSString *purchasePriceString = _amount.text;
    NSDecimalNumber *purchasePriceDecimal = [NSDecimalNumber decimalNumberWithString:purchasePriceString];

    if (segmentPaymentStringValue == nil)
    {
        addExpense.paymentType = @"Cash";
    } else {
        addExpense.paymentType = segmentPaymentStringValue;
    }

    if (dateFromString == nil)
    {
        addExpense.expenseDate = today;
    } else {
        addExpense.expenseDate = dateFromString;
    }
    
    addExpense.expenseAmount = purchasePriceDecimal;
    
    if (pickVendorStringValue == nil)
    {
        addExpense.expenseOutlet = @"Non Specified";
    } else {
        addExpense.expenseOutlet = pickVendorStringValue;
    }

    if (pickCategoryStringValue == nil)
    {
        addExpense.expenseType = @"Miscellaneous";
    } else {
        addExpense.expenseType = pickCategoryStringValue;
    }
 
    if (pickWhyStringValue == nil)
    {
        addExpense.expenseWhy = @"No Reason Specified";

    } else {
        addExpense.expenseWhy = pickWhyStringValue;
    }

    [super saveAndDismiss];
}

- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string
{
    if (textField == self.amount)
    {
        NSString *newString = [textField.text stringByReplacingCharactersInRange:range withString:string];
        
        NSString *expression = @"^([0-9]+)?(\\.([0-9]{1,2})?)?$";
        
        NSRegularExpression *regex = [NSRegularExpression regularExpressionWithPattern:expression
                                                                               options:NSRegularExpressionCaseInsensitive
                                                                                 error:nil];
        NSUInteger numberOfMatches = [regex numberOfMatchesInString:newString
                                                            options:0
                                                              range:NSMakeRange(0, [newString length])];
        if (numberOfMatches == 0)
            return NO;
    }
    
    return YES;
}

-(void)setDateExpense:(NSString*)dateExpenseString
{
    dateExpenseStringValue = dateExpenseString;
}

-(void)setVendor:(NSString*)pickVendorString
{
    pickVendorStringValue = pickVendorString;
}

-(void)setCategory:(NSString*)pickCategoryString
{
    pickCategoryStringValue = pickCategoryString;
}

-(void)setWhy:(NSString *)pickWhyString
{
    pickWhyStringValue = pickWhyString;
}

- (IBAction)paymentTypeSegement:(id)sender {

    UISegmentedControl *segmentedControl = (UISegmentedControl *)sender;
    segmentPaymentStringValue = [segmentedControl titleForSegmentAtIndex: [segmentedControl selectedSegmentIndex]];
    [self resignFirstResponder];

}
@end
