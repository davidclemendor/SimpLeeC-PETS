//
//  SLDatePickViewController.h
//  Simplee Expenses
//
//  Created by David Clemendor on 5/1/14.
//  Copyright (c) 2014 Endless Possibilities Finite Solutions Inc. All rights reserved.
//

#import <UIKit/UIKit.h>
//#import "SLCoreViewController.h"

@protocol dateExpense <NSObject>

    -(void)setDateExpense:(NSString*)dateExpenseString;

@end

@interface SLDatePickViewController : UIViewController

@property (retain)id <dateExpense> delegate;

@property (strong, nonatomic)NSString *dateExpenseStringValue;

- (IBAction)cancel:(id)sender;

- (IBAction)save:(id)sender;

- (IBAction)pickDate:(id)sender;

@property (strong, nonatomic) IBOutlet UIDatePicker *dateExpensePicker;

@end
