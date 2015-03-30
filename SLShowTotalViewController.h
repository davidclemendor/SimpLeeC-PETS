//
//  SLShowTotalViewController.h
//  Simplee Expenses
//
//  Created by David Clemendor on 5/1/14.
//  Copyright (c) 2014 Endless Possibilities Finite Solutions Inc. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SLShowTotalViewController : UIViewController <NSFetchedResultsControllerDelegate>

@property (strong, nonatomic) IBOutlet UILabel *ytdTotalOutlet;

@property (strong, nonatomic) IBOutlet UILabel *grandTotalOutlet;

@property (strong, nonatomic) IBOutlet UILabel *cashTotal;

@property (strong, nonatomic) IBOutlet UILabel *creditTotalOutlet;

@property (strong, nonatomic) IBOutlet UILabel *debitTotalOutlet;

@property (strong, nonatomic) IBOutlet UILabel *checkTotalOutlet;

@property (strong, nonatomic) IBOutlet UISegmentedControl *quarter1Outlet;

@property (strong, nonatomic) IBOutlet UISegmentedControl *quarter2Outlet;
@property (strong, nonatomic) IBOutlet UISegmentedControl *quarter3Outlet;
@property (strong, nonatomic) IBOutlet UISegmentedControl *quarter4Outlet;


@property (strong, nonatomic) IBOutlet UILabel *monthOutlet;

@property (strong, nonatomic) IBOutlet UILabel *yearOutlet;

@property (strong, nonatomic) IBOutlet UISegmentedControl *yearSegmentOutlet;


- (IBAction)yearAction:(id)sender;

- (IBAction)quarter1Action:(id)sender;

- (IBAction)quarter2Action:(id)sender;

- (IBAction)quarter3Action:(id)sender;

- (IBAction)quarter4Action:(id)sender;

@end
