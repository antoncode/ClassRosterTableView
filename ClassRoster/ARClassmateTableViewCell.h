//
//  ARClassmateTableViewCell.h
//  ClassRoster
//
//  Created by Anton Rivera on 4/7/14.
//  Copyright (c) 2014 Anton Hilario Rivera. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ARClassmate.h"

@interface ARClassmateTableViewCell : UITableViewCell

@property (nonatomic, weak) IBOutlet UIImageView *classmateImageView;
@property (nonatomic, weak) IBOutlet UILabel *classmateTextLabel;

@property (nonatomic, weak) ARClassmate *classmate;

@end
