//
//  SLCustomTableViewCell.h
//  Simplee Expenses
//
//  Created by David Clemendor on 5/9/14.
//  Copyright (c) 2014 Endless Possibilities Finite Solutions Inc. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SLCustomTableViewCell : UITableViewCell

@property (strong, nonatomic) IBOutlet UILabel *customCategory;

@property (strong, nonatomic) IBOutlet UILabel *customDate;

@property (strong, nonatomic) IBOutlet UILabel *customAmount;

@end
