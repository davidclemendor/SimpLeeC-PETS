//
//  SLCoreViewController.m
//  Simplee Expenses
//
//  Created by David Clemendor on 5/1/14.
//  Copyright (c) 2014 Endless Possibilities Finite Solutions Inc. All rights reserved.
//

#import "SLCoreViewController.h"
#import "SLAppDelegate.h"

@interface SLCoreViewController ()

@end

@implementation SLCoreViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

-(NSManagedObjectContext*)managedObjectContext {
    
    return [(SLAppDelegate*)[[UIApplication sharedApplication]delegate]managedObjectContext];
    
}

-(void) cancelAndDismiss{
    
    [self.managedObjectContext rollback];
    
    [self dismissViewControllerAnimated:YES completion:nil];
    
}

-(void) saveAndDismiss {
    
    NSError *error = nil;
    
    //NSLog(@"Save and Dismiss Simplee");
    
    if ([self.managedObjectContext hasChanges]) {
        if (![self.managedObjectContext save:&error]) {
            //NSLog(@"Save Failed: %@", [error localizedDescription]);
        } else {
            //NSLog(@"Save Succeeded");
        }
        
    }
    
    [self dismissViewControllerAnimated:YES completion:nil];
    
}


- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
