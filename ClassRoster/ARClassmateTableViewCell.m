//
//  ARClassmateTableViewCell.m
//  ClassRoster
//
//  Created by Anton Rivera on 4/7/14.
//  Copyright (c) 2014 Anton Hilario Rivera. All rights reserved.
//

#import "ARClassmateTableViewCell.h"

@implementation ARClassmateTableViewCell

- (void)setClassmate:(ARClassmate *)classmate
{
    _classmate = classmate;
    
    self.classmateTextLabel.text = _classmate.firstName;
    if (_classmate.photo) {
        self.classmateImageView.layer.cornerRadius = 25;
        [self.classmateImageView.layer setMasksToBounds:YES];
        self.classmateImageView.image = _classmate.photo;
    } else {
        self.classmateImageView.layer.cornerRadius = 25;
        [self.classmateImageView.layer setMasksToBounds:YES];
        self.classmateImageView.image = [UIImage imageNamed:@"default.png"];
    }
}

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
    }
    return self;
}

- (void)awakeFromNib
{
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
