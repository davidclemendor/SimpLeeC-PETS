//
//  SLExpenseTableViewController.h
//  Simplee Expenses
//
//  Created by David Clemendor on 5/1/14.
//  Copyright (c) 2014 Endless Possibilities Finite Solutions Inc. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Expenses.h"

@interface SLExpenseTableViewController : UITableViewController <NSFetchedResultsControllerDelegate>

@property (nonatomic, strong)Expenses *expenses;

@end
