//
//  TableDataSourceController.m
//  ClassRoster
//
//  Created by Anton Rivera on 4/9/14.
//  Copyright (c) 2014 Anton Hilario Rivera. All rights reserved.
//

#import "TableDataSourceController.h"
#import "ARClassmate.h"
#import "ARClassmateTableViewCell.h"

@implementation TableDataSourceController

//+(TableDataSourceController *)sharedData {
//    static dispatch_once_t pred;
//    static TableDataSourceController *shared = nil;
//    
//    dispatch_once(&pred, ^{
//        shared = [[TableDataSourceController alloc] init];
//        shared.teachers = [[TableDataSourceController teachersFromPlist] mutableCopy];
//        shared.students = [[TableDataSourceController studentsFromPlist] mutableCopy];
//    });
//    return shared;
//}

- (NSMutableArray *)studentsFromPlist
{
    NSMutableArray *studentArray = [NSMutableArray new];
    
    // Get path to student.plist in docs directory
    NSString *studentPlistPath = [[TableDataSourceController applicationDocumentsDirectory] stringByAppendingPathComponent:@"student.plist"];
    // Get path to people.plist in docs directory
    NSString *studentPathBundle = [[NSBundle mainBundle] pathForResource:@"people" ofType:@"plist"];
    // Checks if student.plist exists in docs directory
    if ([TableDataSourceController checkForFileInDocsDirectory:@"/student.plist"]) {
        // If yes,
        return [NSKeyedUnarchiver unarchiveObjectWithFile:studentPlistPath];
    } else {
        // Create rootDictionary with contents of people.plist
        NSDictionary *rootDictionary = [[NSDictionary alloc] initWithContentsOfFile:studentPathBundle];
        
        // Parse through rootDictionary for every student
        for (NSDictionary *student in [rootDictionary objectForKey:@"Students"]) {
            ARClassmate *myStudent = [[ARClassmate alloc] init];
            myStudent.firstName = [student objectForKey:@"FirstName"];
            myStudent.lastName = [student objectForKey:@"LastName"];
            myStudent.photoFilePath = [student objectForKey:@"PhotoPath"];
            // Add each student to the studentArray
            [studentArray addObject:myStudent];
            
            // archive studentArray to plist in doc directory
            [NSKeyedArchiver archiveRootObject:studentArray toFile:studentPlistPath];
        }
    }
    
    return [self studentsFromPlist];
}

- (NSMutableArray *)teachersFromPlist
{
    NSMutableArray *teacherArray = [NSMutableArray new];
    
    NSString *teacherPlistPath = [[TableDataSourceController applicationDocumentsDirectory] stringByAppendingPathComponent:@"teacher.plist"];
    NSString *teacherPathBundle = [[NSBundle mainBundle] pathForResource:@"people" ofType:@"plist"];
    if ([TableDataSourceController checkForFileInDocsDirectory:@"/teacher.plist"]) {
        return [NSKeyedUnarchiver unarchiveObjectWithFile:teacherPlistPath];
    } else {
        NSDictionary *rootDictionary = [[NSDictionary alloc] initWithContentsOfFile:teacherPathBundle];
        for (NSDictionary *teacher in [rootDictionary objectForKey:@"Teachers"]) {
            ARClassmate *myTeacher = [[ARClassmate alloc] init];
            myTeacher.firstName = [teacher objectForKey:@"FirstName"];
            myTeacher.lastName = [teacher objectForKey:@"LastName"];
            myTeacher.photoFilePath = [teacher objectForKey:@"PhotoPath"];
            [teacherArray addObject:myTeacher];
            
            [NSKeyedArchiver archiveRootObject:teacherArray toFile:teacherPlistPath];
        }
    }
    
    return [self teachersFromPlist];
}

+ (NSString *)applicationDocumentsDirectory
{
    // Gives a path to the directory
    return [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) firstObject];
}

+ (BOOL)checkForFileInDocsDirectory:(NSString *)fileName
{
    NSFileManager *myManager = [NSFileManager defaultManager];
    
    // Get path to filename in docs directory
    NSString *pathForFileInDocs = [[TableDataSourceController applicationDocumentsDirectory] stringByAppendingString:fileName];

    // Return yes if filename is in docs directory
    return [myManager fileExistsAtPath:pathForFileInDocs];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 2;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (section == 0) {
        return [self.students count];
    } else {
        return [self.teachers count];
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    ARClassmateTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"Cell" forIndexPath:indexPath];
    
    if (indexPath.section == 0) {
        cell.classmate = [self.students objectAtIndex:indexPath.row];
    } else {
        cell.classmate = [self.teachers objectAtIndex:indexPath.row];
    }
    
    return cell;
}

- (void)setUpData;
{
    self.students = [self studentsFromPlist];
    self.teachers = [self teachersFromPlist];
}

-(void)saveEditedText
{
    NSString *teacherPlistPath = [[TableDataSourceController applicationDocumentsDirectory] stringByAppendingPathComponent:@"/teacher.plist" ];
    [NSKeyedArchiver archiveRootObject:self.teachers toFile:teacherPlistPath];
    
    NSString *studentPlistPath = [[TableDataSourceController applicationDocumentsDirectory] stringByAppendingPathComponent:@"/student.plist" ];
    [NSKeyedArchiver archiveRootObject:self.students toFile:studentPlistPath];
}

#pragma mark - Swipe to delete methods

- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    return YES;
}

- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        if (indexPath.section == 0) {
            [self.students removeObjectAtIndex:indexPath.row];
        } else {
            [self.teachers removeObjectAtIndex:indexPath.row];
        }
    }
    [self saveEditedText];
    [tableView reloadData];
}

#pragma mark - Section Header method

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{
    if (section == 0) {
        return @"Students";
    } else {
        return @"Teachers";
    }
}

@end




















