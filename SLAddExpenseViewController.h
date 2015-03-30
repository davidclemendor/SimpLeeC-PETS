//
//  SLAddExpenseViewController.h
//  Simplee Expenses
//
//  Created by David Clemendor on 5/1/14.
//  Copyright (c) 2014 Endless Possibilities Finite Solutions Inc. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SLCoreViewController.h"
#import "Expenses.h"
#import "SLDatePickViewController.h"
#import "SLExpenseVendorTableViewController.h"
#import "SLExpenseCategoryTableViewController.h"
#import "SLExpenseWhyTableViewController.h"


@interface SLAddExpenseViewController : SLCoreViewController <UITextFieldDelegate, dateExpense, pickCategory, pickVendor, pickWhy>

    @property (strong, nonatomic)NSString *dateExpenseStringValue;

    @property (strong, nonatomic)NSString *pickCategoryStringValue;

    @property (strong, nonatomic)NSString *pickVendorStringValue;

    @property (strong, nonatomic)NSString *pickWhyStringValue;

    @property (strong, nonatomic)NSString *segmentPaymentStringValue;

@property (nonatomic, strong) Expenses *addExpense;

- (IBAction)cancel:(id)sender;

- (IBAction)save:(id)sender;

@property (strong, nonatomic) IBOutlet UIButton *dateExpenseLabel;

@property (strong, nonatomic) IBOutlet UIButton *pickCategoryButton;

@property (strong, nonatomic) IBOutlet UIButton *pickVendorButton;

@property (strong, nonatomic) IBOutlet UIButton *pickExpenseWhyButton;

@property (strong, nonatomic) IBOutlet UITextField *amount;

@property (strong, nonatomic) IBOutlet UISegmentedControl *paymentTypeOutlet;


- (IBAction)paymentTypeSegement:(id)sender;




@end
