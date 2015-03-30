//
//  SLReadExpenseViewController.m
//  Simplee Expenses
//
//  Created by David Clemendor on 5/6/14.
//  Copyright (c) 2014 Endless Possibilities Finite Solutions Inc. All rights reserved.
//

#import "SLReadExpenseViewController.h"

@interface SLReadExpenseViewController ()

@end

@implementation SLReadExpenseViewController

@synthesize addExpense;

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
    
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"MM/dd/yyyy"];
    NSString *strDate = [dateFormatter stringFromDate:addExpense.expenseDate];
    
    NSNumberFormatter *numberFormatter = [[NSNumberFormatter alloc]init];
    
    [numberFormatter setNumberStyle:NSNumberFormatterDecimalStyle];
    [numberFormatter setPositiveFormat:@"¤ #,##0.00"];
    [numberFormatter setNegativeFormat:@"¤ -#,##0.00"];
    
    NSString *strCurrency = [numberFormatter stringFromNumber:addExpense.expenseAmount];

    
    _date.enabled = NO;
    _amount.enabled = NO;
    _payment.enabled = NO;
    _category.enabled = NO;
    _vendor.enabled = NO;
    _why.enabled = NO;
    
    _date.borderStyle = UITextBorderStyleNone;
    _amount.borderStyle = UITextBorderStyleNone;
    _payment.borderStyle = UITextBorderStyleNone;
    _category.borderStyle = UITextBorderStyleNone;
    _vendor.borderStyle = UITextBorderStyleNone;
    _why.borderStyle = UITextBorderStyleNone;
    
    _date.text = strDate;
    _amount.text = strCurrency;
    _payment.text = addExpense.paymentType;
    _category.text = addExpense.expenseType;
    _vendor.text = addExpense.expenseOutlet;
    _why.text = addExpense.expenseWhy;

    
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)doneAction:(id)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
}
@end
