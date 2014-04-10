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

+ (NSArray *)classmate // Override getter
{
    NSMutableArray *studentArray = [NSMutableArray new];
    NSString *plistPath = [[NSBundle mainBundle] pathForResource:@"people" ofType:@"plist"];

    // if file exists
        // unarchive from plist
    // else
        // setup plist
    
    if ([TableDataSourceController checkForPlistFileInDocs:@"people.plist"]) {  // Initial load
        return [NSKeyedUnarchiver unarchiveObjectWithFile:plistPath];
    } else {
        // load classmates from .plist
        NSDictionary *rootDictionary = [[NSDictionary alloc] initWithContentsOfFile:plistPath];
        for (NSDictionary *students in [rootDictionary objectForKey:@"Students"]) {
            ARClassmate *myStudent = [[ARClassmate alloc] init]; // FIX!!!
            [studentArray addObject:myStudent];
        }
    }
    
    [NSKeyedArchiver archiveRootObject:studentArray toFile:plistPath];
    
    return [TableDataSourceController classmate];
}

+(NSString *)applicationDocumentsDirectory
{
    // Gives a path to the directory
    return [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) firstObject];
}

+ (BOOL)checkForPlistFileInDocs:(NSString *)fileName
{
    NSError *error;
    
    NSFileManager *myManager = [NSFileManager defaultManager];
    
    NSString *pathForPlistInBundle = [[NSBundle mainBundle] pathForResource:@"people" ofType:@"plist"];
    NSString *pathForPlistInDocs = [[TableDataSourceController applicationDocumentsDirectory] stringByAppendingString:fileName];
    [myManager copyItemAtPath:pathForPlistInBundle toPath:pathForPlistInDocs error:&error];
    
//    if ([myManager fileExistsAtPath:pathForPlistInBundle]) {
//        return YES;
//    }

    return [myManager fileExistsAtPath:pathForPlistInDocs];
    
//    [myManager copyItemAtPath:pathForPlistInBundle toPath:pathForPlistInDocs error:&error];
//    if (error) {
//        NSLog(@"error: %@", error.localizedDescription);
//        NSlog(@"more error: %@", error.debugDescription);
//    } else {
//        NSLog(@" success!");
//        return YES;
//    }
//    
//    return NO;
}

//- (id)init
//{
//    self = [super init];
//    
//    if (self) {
//        [self createClassRoster];
//    }
//    
//    return self;
//}

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

#pragma mark - Helper methods
//
//- (void)createClassRoster
//{
//    ARClassmate *michael = [ARClassmate new];
//    michael.firstName = @"Michael";
//    michael.lastName = @"Babiy";
//    michael.role = Student;
//    
//    ARClassmate *cole = [ARClassmate new];
//    cole.firstName = @"Cole";
//    cole.lastName = @"Bratcher";
//    cole.role = Student;
//    cole.tableViewPhoto = [UIImage imageNamed:@"Cole.jpg"];
//    
//    ARClassmate *john = [ARClassmate new];
//    john.firstName = @"John";
//    john.lastName = @"Clem";
//    john.role = Teacher;
//    john.tableViewPhoto = [UIImage imageNamed:@"john.jpeg"];
//    
//    ARClassmate *christopher = [ARClassmate new];
//    christopher.firstName = @"Christopher";
//    christopher.lastName = @"Cohan";
//    christopher.role = Student;
//    christopher.tableViewPhoto = [UIImage imageNamed:@"Christopher.jpg"];
//    
//    ARClassmate *dan = [ARClassmate new];
//    dan.firstName = @"Dan";
//    dan.lastName = @"Fairbanks";
//    dan.role = Student;
//    
//    ARClassmate *brad = [ARClassmate new];
//    brad.firstName = @"Brad";
//    brad.lastName = @"Johnson";
//    brad.role = Teacher;
//    brad.tableViewPhoto = [UIImage imageNamed:@"brad.jpg"];
//    
//    ARClassmate *lauren = [ARClassmate new];
//    lauren.firstName = @"Lauren";
//    lauren.lastName = @"Lee";
//    lauren.role = Student;
//    lauren.tableViewPhoto = [UIImage imageNamed:@"lauren.jpeg"];
//    
//    ARClassmate *lindy = [ARClassmate new];
//    lindy.firstName = @"Lindy";
//    lindy.lastName = @"CF";
//    lindy.role = Teacher;
//    
//    ARClassmate *sean = [ARClassmate new];
//    sean.firstName = @"Sean";
//    sean.lastName = @"McNeil";
//    sean.role = Student;
//    
//    ARClassmate *taylor = [ARClassmate new];
//    taylor.firstName = @"Taylor";
//    taylor.lastName = @"Potter";
//    taylor.role = Student;
//    
//    ARClassmate *brian = [ARClassmate new];
//    brian.firstName = @"Brian";
//    brian.lastName = @"Radebaugh";
//    brian.role = Student;
//    
//    ARClassmate *brook = [ARClassmate new];
//    brook.firstName = @"Brook";
//    brook.lastName = @"Riggio";
//    brook.role = Teacher;
//    brook.tableViewPhoto = [UIImage imageNamed:@"brook.jpeg"];
//    
//    ARClassmate *anton = [ARClassmate new];
//    anton.firstName = @"Anton";
//    anton.lastName = @"Rivera";
//    anton.role = Student;
//    anton.tableViewPhoto = [UIImage imageNamed:@"anton.jpeg"];
//    
//    ARClassmate *reed = [ARClassmate new];
//    reed.firstName = @"Reed";
//    reed.lastName = @"Sweeney";
//    reed.role = Student;
//    
//    ARClassmate *ryo = [ARClassmate new];
//    ryo.firstName = @"Ryo";
//    ryo.lastName = @"Tulman";
//    ryo.role = Student;
//    ryo.tableViewPhoto = [UIImage imageNamed:@"ryo.jpg"];
//    
//    ARClassmate *matthew = [ARClassmate new];
//    matthew.firstName = @"Matthew";
//    matthew.lastName = @"Voss";
//    matthew.role = Student;
//    matthew.tableViewPhoto = [UIImage imageNamed:@"Matthew.jpg"];
//    
//    ARClassmate *will = [ARClassmate new];
//    will.firstName = @"Will";
//    will.lastName = @"CF";
//    will.role = Teacher;
//    
//    self.students = [NSMutableArray arrayWithObjects:michael, cole, christopher, dan, lauren, sean, taylor, brian, anton, reed, ryo, matthew, nil];
//    self.teachers = [NSMutableArray arrayWithObjects:john, brad, lindy, brook, will, nil];
//}

@end
