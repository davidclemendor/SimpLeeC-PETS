//
//  SLExpenseCategoryTableViewController.h
//  Simplee Expenses
//
//  Created by David Clemendor on 5/4/14.
//  Copyright (c) 2014 Endless Possibilities Finite Solutions Inc. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol pickCategory <NSObject>

    -(void)setCategory:(NSString*)pickCategoryString;

@end

@interface SLExpenseCategoryTableViewController : UITableViewController

@property (retain)id <pickCategory> delegate;

@property (strong, nonatomic)NSString *pickCategoryStringValue;

@property (strong, nonatomic) IBOutlet UISearchBar *searchBar;

- (IBAction)cancel:(id)sender;

- (IBAction)save:(id)sender;


@end
