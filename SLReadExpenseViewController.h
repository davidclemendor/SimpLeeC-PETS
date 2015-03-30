//
//  SLReadExpenseViewController.h
//  Simplee Expenses
//
//  Created by David Clemendor on 5/6/14.
//  Copyright (c) 2014 Endless Possibilities Finite Solutions Inc. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Expenses.h"

@interface SLReadExpenseViewController : UIViewController

@property (nonatomic, strong) Expenses *addExpense;

- (IBAction)doneAction:(id)sender;


@property (strong, nonatomic) IBOutlet UITextField *date;

@property (strong, nonatomic) IBOutlet UITextField *amount;

@property (strong, nonatomic) IBOutlet UITextField *payment;

@property (strong, nonatomic) IBOutlet UITextField *category;

@property (strong, nonatomic) IBOutlet UITextField *vendor;

@property (strong, nonatomic) IBOutlet UITextField *why;

@end
