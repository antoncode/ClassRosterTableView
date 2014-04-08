//
//  ARDetailViewController.h
//  ClassRoster
//
//  Created by Anton Rivera on 4/8/14.
//  Copyright (c) 2014 Anton Hilario Rivera. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ARClassmate.h"

@interface ARDetailViewController : UIViewController

@property (nonatomic, weak) ARClassmate *selectedPerson;

- (IBAction)findpicture:(id)sender;

@end
