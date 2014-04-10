//
//  ARTableViewController.m
//  ClassRoster
//
//  Created by Anton Rivera on 4/7/14.
//  Copyright (c) 2014 Anton Hilario Rivera. All rights reserved.
//

#import "ARTableViewController.h"
#import "ARClassmate.h"
#import "ARClassmateTableViewCell.h"
#import "ARDetailViewController.h"

@interface ARTableViewController () <UITableViewDataSource, UITableViewDelegate>

@end

@implementation ARTableViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.tableView.dataSource = self;
    self.tableView.delegate = self;
    
    self.myDataSource = [[TableDataSourceController alloc] init];
    self.tableView.dataSource = self.myDataSource;
    
    self.navigationItem.title = @"Roster";
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{
    if (section == 0) {
        
        return @"Students";
    } else {
        return @"Teachers";
    }
}

#pragma mark - Navigation

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    NSIndexPath *selectedRowIndexPath = [self.tableView indexPathForSelectedRow];
    NSInteger *selectedSection = (NSInteger *)selectedRowIndexPath.section;
    
    if ([segue.identifier isEqualToString:@"showDetailSegue"]) {
        UIViewController *destinationViewController = segue.destinationViewController;
        
        if (selectedSection == 0) {
            ARClassmate *selectedClassmate = [[_myDataSource students] objectAtIndex:[[self.tableView indexPathForSelectedRow] row]];
            [(ARDetailViewController *)destinationViewController setSelectedPerson:selectedClassmate];
        } else {
            ARClassmate *selectedTeacher = [[_myDataSource teachers] objectAtIndex:[[self.tableView indexPathForSelectedRow] row]];
            [(ARDetailViewController *)destinationViewController setSelectedPerson:selectedTeacher];
        }
    }
}



@end















