//
//  ARTableViewController.h
//  ClassRoster
//
//  Created by Anton Rivera on 4/7/14.
//  Copyright (c) 2014 Anton Hilario Rivera. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TableDataSourceController.h"

@interface ARTableViewController : UITableViewController

@property (nonatomic, strong) TableDataSourceController *myDataSource;  // Must be strong

@end
