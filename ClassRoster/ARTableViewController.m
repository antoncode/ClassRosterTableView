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

@interface ARTableViewController () <UITableViewDataSource, UITableViewDelegate, UIActionSheetDelegate>

@property (nonatomic, strong) UIActionSheet *myActionSheet;

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
    }
}

#pragma mark - Adding a person

- (IBAction)addPerson:(id)sender
{
    self.myActionSheet = [[UIActionSheet alloc] initWithTitle:@"Add Person"
                                                     delegate:self
                                            cancelButtonTitle:@"Cancel"
                                       destructiveButtonTitle:nil
                                            otherButtonTitles:@"Add Student", @"Add Teacher", nil];
    
    [self.myActionSheet showInView:self.view];
}

- (void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex
{
    ARClassmate *newPerson = [ARClassmate new];
    
    if (buttonIndex == 0) {
        [_myDataSource.students addObject:newPerson];
        [self.tableView selectRowAtIndexPath:[NSIndexPath indexPathForItem:[_myDataSource.students count]-1 inSection:0]
                                    animated:YES
                              scrollPosition:UITableViewScrollPositionNone];
    } else if (buttonIndex == 1) {
        [_myDataSource.teachers addObject:newPerson];
        [self.tableView selectRowAtIndexPath:[NSIndexPath indexPathForItem:[_myDataSource.teachers count]-1 inSection:1]
                                    animated:YES
                              scrollPosition:UITableViewScrollPositionNone];
    }
    [self performSegueWithIdentifier:@"showDetailSegue" sender:self];
}

#pragma mark - Sorting method

- (IBAction)sortTableView:(id)sender
{
    [_myDataSource.students sortUsingDescriptors:@[[NSSortDescriptor sortDescriptorWithKey:@"firstName" ascending:YES selector:@selector(localizedStandardCompare:)]]];
    [_myDataSource.teachers sortUsingDescriptors:@[[NSSortDescriptor sortDescriptorWithKey:@"firstName" ascending:YES selector:@selector(localizedStandardCompare:)]]];

    [self.tableView reloadData];
}


@end















