//
//  CameraViewController.h
//  Ribbit
//
//  Created by Robert Figueras on 5/1/14.
//  Copyright (c) 2014 AppSpaceship. All rights reserved.
//

#import <UIKit/UIKit.h>
//#import <Parse/Parse.h>
#import "CustomOverlayViewController.h"



@interface CameraViewController : UIViewController <UIImagePickerControllerDelegate, UINavigationControllerDelegate>

@property (nonatomic, strong) UIImagePickerController *imagePicker;
@property (nonatomic, strong) UIImage *image;
@property (nonatomic, strong) NSString *videoFilePath;

@property (nonatomic, strong) CustomOverlayViewController *overlayVC;




@end
