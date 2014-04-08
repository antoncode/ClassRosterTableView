//
//  ARDetailViewController.m
//  ClassRoster
//
//  Created by Anton Rivera on 4/8/14.
//  Copyright (c) 2014 Anton Hilario Rivera. All rights reserved.
//

#import "ARDetailViewController.h"
#import <AssetsLibrary/AssetsLibrary.h>

@interface ARDetailViewController () <UIActionSheetDelegate, UIImagePickerControllerDelegate, UINavigationControllerDelegate>

@property (nonatomic, strong) UIActionSheet *myActionSheet;

@property (nonatomic, weak) IBOutlet UIButton *myPhoto;
@property (weak, nonatomic) IBOutlet UITextField *twitterTextField;
@property (weak, nonatomic) IBOutlet UITextField *gitHubTextField;

@end

@implementation ARDetailViewController

- (void)viewDidLoad
{
    [super viewDidLoad];

    self.navigationItem.title = [NSString stringWithFormat:@"%@ %@", _selectedPerson.firstName, _selectedPerson.lastName];
}

- (IBAction)findpicture:(id)sender
{
    NSLog(@"button pressed");
    
    if ([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera]) {
        self.myActionSheet = [[UIActionSheet alloc] initWithTitle:@"Photos"
                                                         delegate:self
                                                cancelButtonTitle:@"Cancel"
                                           destructiveButtonTitle:@"Delete Photo"
                                                otherButtonTitles:@"Take Photo", @"Choose Photo", nil];
    } else {
        self.myActionSheet = [[UIActionSheet alloc] initWithTitle:@"Photos"
                                                         delegate:self
                                                cancelButtonTitle:@"Cancel"
                                           destructiveButtonTitle:@"Delete Photo"
                                                otherButtonTitles:@"Choose Photo", nil];
    }
    
    [self.myActionSheet showInView:self.view];
}

- (void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex
{
    NSLog(@" %ld", buttonIndex);
    
    UIImagePickerController *imagePicker = [[UIImagePickerController alloc] init];
    
    imagePicker.delegate = self;
    imagePicker.allowsEditing = YES;
    
    if ([[actionSheet buttonTitleAtIndex:buttonIndex] isEqualToString:@"Take Photo"]) {
        imagePicker.sourceType = UIImagePickerControllerSourceTypeCamera;
    } else if ([[actionSheet buttonTitleAtIndex:buttonIndex] isEqualToString:@"Choose Photo"]) {
        imagePicker.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
    } else {
        return;
    }
    
    [self presentViewController:imagePicker animated:YES completion:nil];
}

#pragma mark - UIImagePickerController Delegate methods

- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info
{
    UIImage *editedImage = [info objectForKey:UIImagePickerControllerEditedImage];
//    UIImage *originalImage = [info objectForKey:UIImagePickerControllerOriginalImage];    
//    _imageView.image = [info objectForKey:UIImagePickerControllerEditedImage];
    
    [self dismissViewControllerAnimated:YES completion:^{
        NSLog(@"Completed");
        
        ALAssetsLibrary *assetsLibrary = [ALAssetsLibrary new]; // ALAssetsLibrary - Window in to users photo library.
        if ([ALAssetsLibrary authorizationStatus] == ALAuthorizationStatusAuthorized) {
            [assetsLibrary writeImageToSavedPhotosAlbum:editedImage.CGImage // Creates a CGImage from UIImage
                                            orientation:ALAssetOrientationUp
                                        completionBlock:^(NSURL *assetURL, NSError *error) {
                                            if (error) {
                                                NSLog(@"Error Saving Image: %@", error.localizedDescription);
                                            }
                                        }];
        } else if ([ALAssetsLibrary authorizationStatus] == ALAuthorizationStatusDenied || [ALAssetsLibrary authorizationStatus] == ALAuthorizationStatusRestricted || [ALAssetsLibrary authorizationStatus] == ALAuthorizationStatusNotDetermined) {
            UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"Cannot Save Photo"
                                                                message:@"Authorization status not granted"
                                                               delegate:nil
                                                      cancelButtonTitle:@"OK"
                                                      otherButtonTitles:nil];
            [alertView show];
        } else {
            NSLog(@"Authorization Not Determined");
        }
    }];
    
    _myPhoto.layer.cornerRadius = 116.5;
    [_myPhoto.layer setMasksToBounds:YES];
    [_myPhoto setBackgroundImage:editedImage forState:UIControlStateNormal];
}

@end















