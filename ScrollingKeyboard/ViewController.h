//
//  ViewController.h
//  ScrollingKeyboard
//
//  Created by Elliot Schrock on 11/16/12.
//  Copyright (c) 2012 Elliot Schrock. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ViewController : UIViewController
@property (strong, nonatomic) IBOutlet UITextField *textField1;
@property (strong, nonatomic) IBOutlet UITextField *textField2;
@property (strong, nonatomic) IBOutlet UITextField *textField3;
@property (strong, nonatomic) IBOutlet UITextField *textField4;
@property (strong, nonatomic) IBOutlet UIScrollView *scrollView;
- (IBAction)switchToggled:(UISwitch *)sender;

@end
