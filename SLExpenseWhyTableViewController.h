//
//  SLExpenseWhyTableViewController.h
//  Simplee Expenses
//
//  Created by David Clemendor on 5/15/14.
//  Copyright (c) 2014 Endless Possibilities Finite Solutions Inc. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol pickWhy <NSObject>

-(void)setWhy:(NSString*)pickWhyString;

@end

@interface SLExpenseWhyTableViewController : UITableViewController

@property (retain)id <pickWhy> delegate;

@property (strong, nonatomic)NSString *pickWhyStringValue;

@property (strong, nonatomic) IBOutlet UISearchBar *searchBar;

- (IBAction)cancel:(id)sender;

- (IBAction)save:(id)sender;

@end
