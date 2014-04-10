//
//  ARClassmate.h
//  ClassRoster
//
//  Created by Anton Rivera on 4/7/14.
//  Copyright (c) 2014 Anton Hilario Rivera. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef enum {
    Student = 0,
    Teacher = 1
} Role;

@interface ARClassmate : NSObject <NSCoding>

@property (nonatomic, strong) NSString *firstName;
@property (nonatomic, strong) NSString *lastName;
@property (nonatomic, strong) UIImage *tableViewPhoto;
@property (assign) Role role;
@property (nonatomic, strong) NSString *twitterAccount;
@property (nonatomic, strong) NSString *gitHubAccount;

@end
