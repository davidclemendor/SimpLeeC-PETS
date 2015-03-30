//
//  SLExpenseVendorTableViewController.h
//  Simplee Expenses
//
//  Created by David Clemendor on 5/4/14.
//  Copyright (c) 2014 Endless Possibilities Finite Solutions Inc. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol pickVendor <NSObject>

    -(void)setVendor:(NSString*)pickVendorString;

@end

@interface SLExpenseVendorTableViewController : UITableViewController

@property (retain)id <pickVendor> delegate;

@property (strong, nonatomic)NSString *pickVendorStringValue;

@property (strong, nonatomic) IBOutlet UISearchBar *searchBar;

- (IBAction)cancel:(id)sender;

- (IBAction)save:(id)sender;

@end
