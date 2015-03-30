//
//  Expenses.h
//  Simplee Expenses
//
//  Created by David Clemendor on 5/1/14.
//  Copyright (c) 2014 Endless Possibilities Finite Solutions Inc. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>


@interface Expenses : NSManagedObject

@property (nonatomic, retain) NSDate * expenseDate;
@property (nonatomic, retain) NSDecimalNumber * expenseAmount;
@property (nonatomic, retain) NSString * expenseType;
@property (nonatomic, retain) NSString * expenseOutlet;
@property (nonatomic, retain) NSString * paymentType;
@property (nonatomic, retain) NSString * expenseWhy;


@end
