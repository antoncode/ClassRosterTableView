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
    
    _myDataSource = [TableDataSourceController new];
    [_myDataSource setUpData];
    
    self.tableView.dataSource = _myDataSource;
    self.tableView.delegate = self;
    
    self.navigationItem.title = @"Roster";
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self.tableView deselectRowAtIndexPath:[self.tableView indexPathForSelectedRow] animated:YES];
    [self.tableView reloadData];
}

#pragma mark - Navigation

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    NSIndexPath *selectedRowIndexPath = [self.tableView indexPathForSelectedRow];
    NSInteger *selectedSection = (NSInteger *)selectedRowIndexPath.section;
    
    UIViewController *destinationViewController = segue.destinationViewController;
    if ([segue.identifier isEqualToString:@"showDetailSegue"]) {
        if (selectedSection == 0) {
            ARClassmate *selectedClassmate = [[_myDataSource students] objectAtIndex:[[self.tableView indexPathForSelectedRow] row]];
            [(ARDetailViewController *)destinationViewController setSelectedPerson:selectedClassmate];
        } else {
            ARClassmate *selectedTeacher = [[_myDataSource teachers] objectAtIndex:[[self.tableView indexPathForSelectedRow] row]];
            [(ARDetailViewController *)destinationViewController setSelectedPerson:selectedTeacher];
        }
        
        [(ARDetailViewController *)destinationViewController setDataController:_myDataSource];
    } else if ([segue.identifier isEqualToString:@"addPersonSegue"]) {
        NSLog(@"Add Person!");
        
        
    }
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{
    if (section == 0) {
        
        return @"Students";
    } else {
        return @"Teachers";
    }
}



@end















