//
//  CameraViewController.m
//  Ribbit
//
//  Created by Robert Figueras on 5/1/14.
//  Copyright (c) 2014 AppSpaceship. All rights reserved.
//

#import "CameraViewController.h"
#import <MobileCoreServices/UTCoreTypes.h>

#import "ViewController.h"


@interface CameraViewController ()

@end

@implementation CameraViewController

#define DEGREES_RADIANS(angle) ((angle) / 180.0 * M_PI)

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    [[UIDevice currentDevice] beginGeneratingDeviceOrientationNotifications];
    [[NSNotificationCenter defaultCenter]
     addObserver:self selector:@selector(orientationChanged:)
     name:UIDeviceOrientationDidChangeNotification
     object:[UIDevice currentDevice]];

    UIStoryboard*  sb = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    self.overlayVC = [sb instantiateViewControllerWithIdentifier:@"customOverlaySB"];



}

- (void) viewWillAppear:(BOOL)animated{

    [super viewWillAppear:animated];
    
    self.imagePicker = [[UIImagePickerController alloc]init];
    self.imagePicker.delegate = self;
    self.imagePicker.allowsEditing = NO;
    self.imagePicker.videoMaximumDuration = 7; // *** limit the lenghth of the videos (in seconds)
    
    // *** check to see if a camera source is available; if not, show the photo library instead ***/
    
    if ([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera]){
        self.imagePicker.sourceType = UIImagePickerControllerSourceTypeCamera;
        
        self.imagePicker.cameraDevice = UIImagePickerControllerCameraDeviceFront; // *** set camera to selfie

    }
    else {
        self.imagePicker.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
    }
    
//    self.imagePicker.mediaTypes =[UIImagePickerController availableMediaTypesForSourceType:self.imagePicker.sourceType];
    
    self.imagePicker.mediaTypes = [[NSArray alloc] initWithObjects: (NSString *) kUTTypeMovie, nil]; // *** make it so it only records video, not photo

    self.imagePicker.showsCameraControls = NO; // *** hide camera controls?
    
    
    // *** TRY TO ADD THE TELEPROMPT ******************************************

    [self presentViewController:self.imagePicker animated:NO completion:nil];
    

    UIView *overlayViewFromVC = self.overlayVC.view;

    //vc.promptLabel.text = @"WHY???";

    self.imagePicker.cameraOverlayView = overlayViewFromVC;
    
    //self.imagePicker.cameraOverlayView.transform = CGAffineTransformRotate(CGAffineTransformIdentity, DEGREES_RADIANS (90));
    
    // ************************************************************************

}

- (void) orientationChanged:(NSNotification *)note
{

    UIDevice * device = note.object;
    switch(device.orientation)
    {
        case UIDeviceOrientationPortrait:
            self.imagePicker.cameraOverlayView.transform = CGAffineTransformRotate(CGAffineTransformIdentity, DEGREES_RADIANS(270));
            break;

        case UIDeviceOrientationPortraitUpsideDown:
            self.imagePicker.cameraOverlayView.transform = CGAffineTransformRotate(CGAffineTransformIdentity, DEGREES_RADIANS(270));
            break;

        case UIDeviceOrientationLandscapeLeft:
            self.imagePicker.cameraOverlayView.transform = CGAffineTransformRotate(CGAffineTransformIdentity, DEGREES_RADIANS(90));
            break;

        case UIDeviceOrientationLandscapeRight:
            self.imagePicker.cameraOverlayView.transform = CGAffineTransformRotate(CGAffineTransformIdentity, DEGREES_RADIANS(270));
            break;

        default:
            break;
    };
}



#pragma mark - Image Picker Controller Delegate

- (void) imagePickerControllerDidCancel:(UIImagePickerController *)picker{
    
    // *** override method to display a different view controller ***/
    
    [self dismissViewControllerAnimated:NO completion:nil];
    
    // *** self.tabBarController will access the nearest tabBarController from any view controller ***/
    // *** this will display the first tab's viewcontroller right when the cancel button is clicked ***/

    [self.tabBarController setSelectedIndex:0];

}

- (void) imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info{
    
    NSString *mediaType = [info objectForKey:UIImagePickerControllerMediaType];
    
    if([mediaType isEqualToString:(NSString *)kUTTypeImage]){ // *** if the media is a photo (and not a video)
        
        self.image = [info objectForKey:UIImagePickerControllerOriginalImage]; // *** then get the image
        
        if (self.imagePicker.sourceType == UIImagePickerControllerSourceTypeCamera){ // *** if they used the camera (and not existing)
            UIImageWriteToSavedPhotosAlbum(self.image, nil, nil, nil); // *** then save to album
        }
        
        [self dismissViewControllerAnimated:YES completion:nil]; // *** since you are overriding the method, need to dismiss modal controller
        
    } else { // *** if the media is a video
        
        NSURL *imagePickerURL = [info objectForKey:UIImagePickerControllerMediaURL]; // *** find the video path
        self.videoFilePath = [imagePickerURL path];
        if (self.imagePicker.sourceType == UIImagePickerControllerSourceTypeCamera){ // *** if they used the camera (and not existing)
            
            if (UIVideoAtPathIsCompatibleWithSavedPhotosAlbum(self.videoFilePath)){ // *** and if the video is compatible
                UISaveVideoAtPathToSavedPhotosAlbum(self.videoFilePath, nil, nil, nil); // *** then save the video
            }
        }
        
        [self dismissViewControllerAnimated:YES completion:nil]; // *** since you are overriding the method, need to dismiss modal controller
    }
}

-(BOOL)shouldAutorotate
{
    return YES;
}



@end
