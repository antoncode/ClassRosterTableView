//
//  TableDataSourceController.h
//  ClassRoster
//
//  Created by Anton Rivera on 4/9/14.
//  Copyright (c) 2014 Anton Hilario Rivera. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface TableDataSourceController : NSObject <UITableViewDataSource>

@property (nonatomic, strong) NSMutableArray *students, *teachers;

+ (NSString *)applicationDocumentsDirectory;
+ (BOOL)checkForFileInDocsDirectory:(NSString *)fileName;


- (void)setUpData;
-(void)saveEditedText;
//+(TableDataSourceController *)sharedData; // For singleton

@end
