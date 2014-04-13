//
//  ARDetailViewController.m
//  ClassRoster
//
//  Created by Anton Rivera on 4/8/14.
//  Copyright (c) 2014 Anton Hilario Rivera. All rights reserved.
//

#import "ARDetailViewController.h"
#import <AssetsLibrary/AssetsLibrary.h>
#import "Social/Social.h"

@interface ARDetailViewController () <UIActionSheetDelegate, UIImagePickerControllerDelegate, UINavigationControllerDelegate, UITextFieldDelegate>

@property (nonatomic, strong) UIActionSheet *myActionSheet;

@property (weak, nonatomic) IBOutlet UITextField *firstNameTextField;
@property (weak, nonatomic) IBOutlet UITextField *lastNameTextField;
@property (weak, nonatomic) IBOutlet UITextField *twitterTextField;
@property (weak, nonatomic) IBOutlet UITextField *gitHubTextField;
@property (nonatomic, weak) IBOutlet UIButton *myPhotoButton;

@property (nonatomic, strong) UISlider *sliderRed;
@property (nonatomic, strong) UISlider *sliderGreen;
@property (nonatomic, strong) UISlider *sliderBlue;

@end

@implementation ARDetailViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.twitterTextField.delegate = self;
    self.gitHubTextField.delegate = self;

    _sliderRed = [UISlider new];
    _sliderGreen = [UISlider new];
    _sliderBlue = [UISlider new];

    // Gets rid of extra blank space on top of view
    self.automaticallyAdjustsScrollViewInsets = NO;
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    if (_selectedPerson.firstName) {
        _firstNameTextField.text = [NSString stringWithFormat:@"%@", _selectedPerson.firstName];
        self.navigationItem.title = [NSString stringWithFormat:@"%@ %@", _selectedPerson.firstName, _selectedPerson.lastName];
    }
    if (_selectedPerson.lastName) {
        _lastNameTextField.text = [NSString stringWithFormat:@"%@", _selectedPerson.lastName];
    }
    
    if (_selectedPerson.twitterAccount) {
        _twitterTextField.text = [NSString stringWithFormat:@"%@", _selectedPerson.twitterAccount];
    }
    if (_selectedPerson.gitHubAccount) {
        _gitHubTextField.text = [NSString stringWithFormat:@"%@", _selectedPerson.gitHubAccount];
    }
    
    NSData *data = [NSData dataWithContentsOfFile:_selectedPerson.photoFilePath];
    UIImage *image = [UIImage imageWithData:data];
    [_myPhotoButton setBackgroundImage:image forState:UIControlStateNormal];
    
    if (!image) {
        [_myPhotoButton setBackgroundImage:[UIImage imageNamed:@"default"] forState:UIControlStateNormal];
    }
    _myPhotoButton.layer.cornerRadius = 116.5;
    [_myPhotoButton.layer setMasksToBounds:YES];
    
    if (_selectedPerson.favoriteRed) {
        [_sliderRed setValue:_selectedPerson.favoriteRed];
    } else {
        [_sliderRed setValue:0.5];
        _selectedPerson.favoriteRed = 0.5;
    }
    if (_selectedPerson.favoriteGreen) {
        [_sliderGreen setValue:_selectedPerson.favoriteGreen];
    } else {
        [_sliderGreen setValue:0.5];
        _selectedPerson.favoriteGreen = 0.5;
    }
    if (_selectedPerson.favoriteBlue) {
        [_sliderBlue setValue:_selectedPerson.favoriteBlue];
    } else {
        [_sliderBlue setValue:0.5];
        _selectedPerson.favoriteBlue = 0.5;
    }
    
    self.view.backgroundColor = [UIColor colorWithRed:_sliderRed.value green:_sliderGreen.value blue:_sliderBlue.value alpha:1];
}

- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    
    _selectedPerson.firstName = _firstNameTextField.text;
    _selectedPerson.lastName = _lastNameTextField.text;
    
    [self.dataController saveEditedText];
    
    _selectedPerson.twitterAccount = _twitterTextField.text;
    _selectedPerson.gitHubAccount = _gitHubTextField.text;
    _selectedPerson.favoriteRed = _sliderRed.value;
    _selectedPerson.favoriteGreen = _sliderGreen.value;
    _selectedPerson.favoriteBlue = _sliderBlue.value;
}

- (IBAction)findpicture:(id)sender
{
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
    
    [self dismissViewControllerAnimated:YES completion:^{
//        ALAssetsLibrary *assetsLibrary = [ALAssetsLibrary new]; // ALAssetsLibrary - Window in to users photo library.
        if ([ALAssetsLibrary authorizationStatus] == ALAuthorizationStatusAuthorized) {
//            [assetsLibrary writeImageToSavedPhotosAlbum:editedImage.CGImage // Creates a CGImage from UIImage
//                                            orientation:ALAssetOrientationUp
//                                        completionBlock:^(NSURL *assetURL, NSError *error) {
//                                            if (error) {
//                                                NSLog(@"Error Saving Image: %@", error.localizedDescription);
//                                            }
//                                        }];
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
    
    _myPhotoButton.layer.cornerRadius = 116.5;
    [_myPhotoButton.layer setMasksToBounds:YES];
    [_myPhotoButton setBackgroundImage:editedImage forState:UIControlStateNormal];
    
    NSString *photoFilePath = [[TableDataSourceController applicationDocumentsDirectory] stringByAppendingPathComponent:[NSString stringWithFormat:@"/%@.jpg", _selectedPerson.firstName]];
    _selectedPerson.photoFilePath = photoFilePath;
    
    NSData *data = UIImagePNGRepresentation(editedImage);
    [data writeToFile:photoFilePath atomically:YES];
}

-(BOOL) textFieldShouldReturn:(UITextField *)textField
{
    // Return dismisses keyboard
    [textField resignFirstResponder];
    return YES;
}

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    // dismiss keyboard when user taps anywhere on the screen
    [self.view endEditing:YES];
}

- (IBAction)sharePost:(id)sender
{
    NSString *text = _selectedPerson.firstName;
    NSData *data = [NSData dataWithContentsOfFile:_selectedPerson.photoFilePath];
    UIImage *image = [UIImage imageWithData:data];
    UIActivityViewController *activityController;
    
    if(image) {
        activityController = [[UIActivityViewController alloc] initWithActivityItems:@[text, image] applicationActivities:nil];
        //        [activityController setExcludedActivityTypes:@[UIActivityTypePostToFacebook]];
    } else {
        activityController = [[UIActivityViewController alloc] initWithActivityItems:@[text] applicationActivities:nil];
    }
    
    [self presentViewController:activityController animated:YES completion:nil];
}

#pragma mark - Background Color methods

- (IBAction)rDidChange:(id)sender
{
    _sliderRed = (UISlider *)sender;
    
    UIColor *backgroundColor = [UIColor colorWithRed:_sliderRed.value green:_sliderGreen.value blue:_sliderBlue.value alpha:1];
    self.view.backgroundColor = backgroundColor;
}

- (IBAction)gDidChange:(id)sender
{
    _sliderGreen = (UISlider *)sender;
    
    UIColor *backgroundColor = [UIColor colorWithRed:_sliderRed.value green:_sliderGreen.value blue:_sliderBlue.value alpha:1];
    self.view.backgroundColor = backgroundColor;
}

- (IBAction)bDidChange:(id)sender {
    _sliderBlue = (UISlider *)sender;
    
    UIColor *backgroundColor = [UIColor colorWithRed:_sliderRed.value green:_sliderGreen.value blue:_sliderBlue.value alpha:1];
    self.view.backgroundColor = backgroundColor;
    
    
}


@end















