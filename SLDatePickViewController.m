//
//  SLDatePickViewController.m
//  Simplee Expenses
//
//  Created by David Clemendor on 5/1/14.
//  Copyright (c) 2014 Endless Possibilities Finite Solutions Inc. All rights reserved.
//

#import "SLDatePickViewController.h"

@interface SLDatePickViewController ()

@end

@implementation SLDatePickViewController

@synthesize delegate, dateExpenseStringValue;

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
    
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (IBAction)cancel:(id)sender {

    [self dismissViewControllerAnimated:YES completion:nil];
}


- (IBAction)save:(id)sender {
    
    NSLog(@"Save Data Called");
    
    //dateExpenseStringValue = self.pickDateTextField.text;
    
    //datePrescriptionStringValue = @"12/13/2014";
    
    NSDate *myDate = _dateExpensePicker.date;
    
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
 
    [dateFormatter setDateFormat:@"MM/dd/yyyy"];
    
    dateExpenseStringValue = [dateFormatter stringFromDate:myDate];
    
    [[self delegate]setDateExpense:dateExpenseStringValue];
    
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (IBAction)pickDate:(id)sender {
    
    /* Nothing Here Will Keep Place for Future Use */
    
}

@end
