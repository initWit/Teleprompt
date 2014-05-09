//
//  CustomOverlayViewController.h
//  Teleprompt
//
//  Created by Robert Figueras on 5/2/14.
//  Copyright (c) 2014 AppSpaceship. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CustomOverlayViewController : UIViewController
@property (strong, nonatomic) IBOutlet UILabel *promptLabel;
@property (strong, nonatomic) IBOutlet UIScrollView *myTelePromt;

- (void) startToScroll;

@end
