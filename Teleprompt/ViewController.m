//
//  ViewController.m
//  Teleprompt
//
//  Created by Robert Figueras on 5/2/14.
//  Copyright (c) 2014 AppSpaceship. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController

#define DEGREES_RADIANS(angle) ((angle) / 180.0 * M_PI)

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    
    self.view.backgroundColor = [UIColor brownColor];
    
    self.navigationController.navigationBarHidden = YES;

    [[UIDevice currentDevice] beginGeneratingDeviceOrientationNotifications];
    [[NSNotificationCenter defaultCenter]
     addObserver:self selector:@selector(orientationChanged:)
     name:UIDeviceOrientationDidChangeNotification
     object:[UIDevice currentDevice]];
}

- (void) viewWillAppear:(BOOL)animated{

}

- (void) orientationChanged:(NSNotification *)note
{
    UIDevice * device = note.object;
    switch(device.orientation)
    {
        case UIDeviceOrientationPortrait:
            self.orientationLabel.text = @"PORTRAIT";
            self.view.transform = CGAffineTransformRotate(CGAffineTransformIdentity, DEGREES_RADIANS(90));
            break;

        case UIDeviceOrientationPortraitUpsideDown:
            self.orientationLabel.text = @"UPSIDEDOWN";
            self.view.transform = CGAffineTransformRotate(CGAffineTransformIdentity, DEGREES_RADIANS(270));
            break;

        case UIDeviceOrientationLandscapeLeft:
            self.orientationLabel.text = @"LANDSCAPE LEFT";
            break;

        case UIDeviceOrientationLandscapeRight:
            self.orientationLabel.text = @"LANDSCAPE RIGHT";
            self.view.transform = CGAffineTransformRotate(CGAffineTransformIdentity, DEGREES_RADIANS(270));
            break;

        default:
            break;
    };
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(BOOL)shouldAutorotate
{
    return NO;
}

//-(NSUInteger)supportedInterfaceOrientations
//{
//    return UIInterfaceOrientationMaskLandscape;
//}

//- (UIInterfaceOrientation)preferredInterfaceOrientationForPresentation{
//    return UIInterfaceOrientationLandscapeRight;
//
//}



@end
