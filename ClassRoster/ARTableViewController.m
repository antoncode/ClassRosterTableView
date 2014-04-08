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
    
    self.navigationItem.title = @"Roster";
    
    [self createClassRoster];
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{
    if (section == 0) {
        return @"Students";
    } else {
        return @"Teachers";
    }
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 2;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (section == 0) {
        return [self.classmates count];
    } else {
        return [self.teachers count];
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    ARClassmateTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"Cell" forIndexPath:indexPath];
    
    if (indexPath.section == 0) {
        cell.classmate = [self.classmates objectAtIndex:indexPath.row];
    } else {
        cell.classmate = [self.teachers objectAtIndex:indexPath.row];
    }

    return cell;
}

#pragma mark - Navigation

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    NSIndexPath *selectedRowIndexPath = [self.tableView indexPathForSelectedRow];
    NSInteger *selectedSection = (NSInteger *)selectedRowIndexPath.section;
    
    if ([segue.identifier isEqualToString:@"showDetailSegue"]) {
        UIViewController *destinationViewController = segue.destinationViewController;
        
        if (selectedSection == 0) {
            ARClassmate *selectedClassmate = [self.classmates objectAtIndex:[[self.tableView indexPathForSelectedRow] row]];
//            destinationViewController.navigationItem.title = [NSString stringWithFormat:@"%@ %@", selectedClassmate.firstName, selectedClassmate.lastName];
            [(ARDetailViewController *)destinationViewController setSelectedPerson:selectedClassmate];
        } else {
            ARClassmate *selectedTeacher = [self.teachers objectAtIndex:[[self.tableView indexPathForSelectedRow] row]];
//            destinationViewController.navigationItem.title = [NSString stringWithFormat:@"%@ %@", selectedTeacher.firstName, selectedTeacher.lastName];
            [(ARDetailViewController *)destinationViewController setSelectedPerson:selectedTeacher];
        }
    }
}

#pragma mark - Helper methods

- (void)createClassRoster
{
    ARClassmate *michael = [ARClassmate new];
    michael.firstName = @"Michael";
    michael.lastName = @"Babiy";
    michael.role = Student;
    
    ARClassmate *cole = [ARClassmate new];
    cole.firstName = @"Cole";
    cole.lastName = @"Bratcher";
    cole.role = Student;
    cole.tableViewPhoto = [UIImage imageNamed:@"Cole.jpg"];
    
    ARClassmate *john = [ARClassmate new];
    john.firstName = @"John";
    john.lastName = @"Clem";
    john.role = Teacher;
    john.tableViewPhoto = [UIImage imageNamed:@"john.jpeg"];
    
    ARClassmate *christopher = [ARClassmate new];
    christopher.firstName = @"Christopher";
    christopher.lastName = @"Cohan";
    christopher.role = Student;
    christopher.tableViewPhoto = [UIImage imageNamed:@"Christopher.jpg"];
    
    ARClassmate *dan = [ARClassmate new];
    dan.firstName = @"Dan";
    dan.lastName = @"Fairbanks";
    dan.role = Student;
    
    ARClassmate *brad = [ARClassmate new];
    brad.firstName = @"Brad";
    brad.lastName = @"Johnson";
    brad.role = Teacher;
    brad.tableViewPhoto = [UIImage imageNamed:@"brad.jpg"];
    
    ARClassmate *lauren = [ARClassmate new];
    lauren.firstName = @"Lauren";
    lauren.lastName = @"Lee";
    lauren.role = Student;
    lauren.tableViewPhoto = [UIImage imageNamed:@"lauren.jpeg"];
    
    ARClassmate *lindy = [ARClassmate new];
    lindy.firstName = @"Lindy";
    lindy.lastName = @"CF";
    lindy.role = Teacher;
    
    ARClassmate *sean = [ARClassmate new];
    sean.firstName = @"Sean";
    sean.lastName = @"McNeil";
    sean.role = Student;
    
    ARClassmate *taylor = [ARClassmate new];
    taylor.firstName = @"Taylor";
    taylor.lastName = @"Potter";
    taylor.role = Student;
    
    ARClassmate *brian = [ARClassmate new];
    brian.firstName = @"Brian";
    brian.lastName = @"Radebaugh";
    brian.role = Student;
    
    ARClassmate *brook = [ARClassmate new];
    brook.firstName = @"Brook";
    brook.lastName = @"Riggio";
    brook.role = Teacher;
    brook.tableViewPhoto = [UIImage imageNamed:@"brook.jpeg"];
    
    ARClassmate *anton = [ARClassmate new];
    anton.firstName = @"Anton";
    anton.lastName = @"Rivera";
    anton.role = Student;
    anton.tableViewPhoto = [UIImage imageNamed:@"anton.jpeg"];
    
    ARClassmate *reed = [ARClassmate new];
    reed.firstName = @"Reed";
    reed.lastName = @"Sweeney";
    reed.role = Student;
    
    ARClassmate *ryo = [ARClassmate new];
    ryo.firstName = @"Ryo";
    ryo.lastName = @"Tulman";
    ryo.role = Student;
    ryo.tableViewPhoto = [UIImage imageNamed:@"ryo.jpg"];
    
    ARClassmate *matthew = [ARClassmate new];
    matthew.firstName = @"Matthew";
    matthew.lastName = @"Voss";
    matthew.role = Student;
    matthew.tableViewPhoto = [UIImage imageNamed:@"Matthew.jpg"];
    
    ARClassmate *will = [ARClassmate new];
    will.firstName = @"Will";
    will.lastName = @"CF";
    will.role = Teacher;
    
    self.classmates = [NSMutableArray arrayWithObjects:michael, cole, christopher, dan, lauren, sean, taylor, brian, anton, reed, ryo, matthew, nil];
    self.teachers = [NSMutableArray arrayWithObjects:john, brad, lindy, brook, will, nil];
}

@end















