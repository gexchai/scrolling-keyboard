//
//  ViewController.m
//  ScrollingKeyboard
//
//  Created by Elliot Schrock on 11/16/12.
//  Copyright (c) 2012 Elliot Schrock. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()<UITextFieldDelegate>

@end

@implementation ViewController
@synthesize scrollView = _scrollView;
CGFloat animatedDistance;
static const CGFloat KEYBOARD_ANIMATION_DURATION = 0.3;
static const CGFloat MINIMUM_SCROLL_FRACTION = 0.2;
static const CGFloat MAXIMUM_SCROLL_FRACTION = 0.8;
static const CGFloat PORTRAIT_KEYBOARD_HEIGHT = 216;
static const CGFloat LANDSCAPE_KEYBOARD_HEIGHT = 162;

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    //Don't forget to set the delegates!
    [self.textField1 setDelegate:self];
    [self.textField2 setDelegate:self];
    [self.textField3 setDelegate:self];
    [self.textField4 setDelegate:self];
}

//this method is based on the one from the cocoa with love blog,
//but simplified and improved by the use of a scrollview
- (void)textFieldDidBeginEditing:(UITextField *)textField
{
    CGRect textFieldRect = [self.view.window convertRect:textField.bounds fromView:textField];
    CGRect viewRect = [self.view.window convertRect:self.view.bounds fromView:self.view];
    
    CGFloat midline = textFieldRect.origin.y + 0.5 * textFieldRect.size.height;
    CGFloat numerator = midline - viewRect.origin.y - MINIMUM_SCROLL_FRACTION * viewRect.size.height;
    CGFloat denominator = (MAXIMUM_SCROLL_FRACTION - MINIMUM_SCROLL_FRACTION) * viewRect.size.height;
    CGFloat heightFraction = numerator / denominator;
    
    if (heightFraction < 0.0) {
        heightFraction = 0.0;
    }else if (heightFraction > 1.0) {
        heightFraction = 1.0;
    }
    
    UIInterfaceOrientation orientation = [[UIApplication sharedApplication] statusBarOrientation];
    if (orientation == UIInterfaceOrientationPortrait || orientation == UIInterfaceOrientationPortraitUpsideDown) {
        animatedDistance = floor(PORTRAIT_KEYBOARD_HEIGHT * heightFraction);
    }else {
        animatedDistance = floor(LANDSCAPE_KEYBOARD_HEIGHT * heightFraction);
    }
    
    CGSize newSize = self.scrollView.contentSize;
    newSize.height += animatedDistance;
    
    self.scrollView.contentSize = newSize;
    CGPoint p = self.scrollView.contentOffset;
    p.y += animatedDistance;
    [UIView beginAnimations:nil context:NULL];
    [UIView setAnimationBeginsFromCurrentState:YES];
    [UIView setAnimationDuration:KEYBOARD_ANIMATION_DURATION];
    
    [self.scrollView setContentOffset:p animated:NO];
    
    [UIView commitAnimations];
}

- (BOOL)textFieldShouldEndEditing:(UITextField *)textField
{
    CGSize newSize = self.scrollView.contentSize;
    newSize.height -= animatedDistance;
    CGPoint p = self.scrollView.contentOffset;
    p.y = 0;
    [UIView beginAnimations:nil context:NULL];
    [UIView setAnimationBeginsFromCurrentState:YES];
    [UIView setAnimationDuration:KEYBOARD_ANIMATION_DURATION];
    self.scrollView.contentSize = newSize;
    [self.scrollView setContentOffset:p animated:NO];
    [UIView commitAnimations];
    return YES;
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [textField resignFirstResponder];
    return YES;
}

- (IBAction)switchToggled:(UISwitch *)sender
{
    if (sender.on) {
        [self.textField1 setDelegate:self];
        [self.textField2 setDelegate:self];
        [self.textField3 setDelegate:self];
        [self.textField4 setDelegate:self];
    }else{
        [self.textField1 setDelegate:nil];
        [self.textField2 setDelegate:nil];
        [self.textField3 setDelegate:nil];
        [self.textField4 setDelegate:nil];
    }
}
@end
