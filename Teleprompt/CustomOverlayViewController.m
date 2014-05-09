//
//  CustomOverlayViewController.m
//  Teleprompt
//
//  Created by Robert Figueras on 5/2/14.
//  Copyright (c) 2014 AppSpaceship. All rights reserved.
//

#import "CustomOverlayViewController.h"

@interface CustomOverlayViewController ()

@end

@implementation CustomOverlayViewController

- (void)viewDidLoad
{
    [super viewDidLoad];

    [[UIDevice currentDevice] beginGeneratingDeviceOrientationNotifications];
    [[NSNotificationCenter defaultCenter]
     addObserver:self selector:@selector(orientationChanged:)
     name:UIDeviceOrientationDidChangeNotification
     object:[UIDevice currentDevice]];

//    CGRect scrollFrame;
//    scrollFrame.origin = self.myTelePromt.frame.origin;
//    scrollFrame.size = CGSizeMake(self.view.frame.size.height, self.myTelePromt.frame.size.height);
//    self.myTelePromt.frame = scrollFrame;


}

- (void) orientationChanged:(NSNotification *)note
{

    UIDevice * device = note.object;
    switch(device.orientation)
    {
        case UIDeviceOrientationPortrait:
            self.promptLabel.text = @"PORTRAIT";
            break;

        case UIDeviceOrientationPortraitUpsideDown:
            self.promptLabel.text = @"UPSIDE DOWN";
            break;

        case UIDeviceOrientationLandscapeLeft:
            self.promptLabel.text = @"LANDSCAPE LEFT";
            break;

        case UIDeviceOrientationLandscapeRight:
            self.promptLabel.text = @"LANDSCAPE RIGHT";
            break;
            
        default:
            break;
    };
}


-(BOOL)shouldAutorotate
{
    return YES;
}



- (void) startToScroll {

    self.myTelePromt.scrollEnabled = NO;
    
    CGFloat scrollHeight = 200;
    [UIView animateWithDuration:10
                          delay:0
                        options:UIViewAnimationOptionCurveLinear | UIViewAnimationOptionAllowUserInteraction
                     animations:^{
                         self.myTelePromt.contentOffset = CGPointMake(0, scrollHeight);
                     }
                     completion:nil];
}


@end
