//
//  SLUtilityViewController.h
//  Simplee Expenses
//
//  Created by David Clemendor on 5/6/14.
//  Copyright (c) 2014 Endless Possibilities Finite Solutions Inc. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MessageUI/MessageUI.h>
#import "Expenses.h"

@interface SLUtilityViewController : UIViewController <NSFetchedResultsControllerDelegate>

@property (nonatomic, strong)Expenses *expenses;

- (IBAction)sendEmail:(id)sender;

- (IBAction)resetDatabase:(id)sender;

@property (strong, nonatomic) IBOutlet UILabel *numberOfRecords;


@end
