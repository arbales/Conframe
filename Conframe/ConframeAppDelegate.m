//
//  ConframeAppDelegate.m
//  Conframe
//
//  Created by Austin Robert Bales on 5/19/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "ConframeAppDelegate.h"

@implementation ConframeAppDelegate
@synthesize groups_controller;
@synthesize username_field;
@synthesize password_field;
@synthesize error_message;
@synthesize login_box;
@synthesize groups_list;
@synthesize topics_list;
@synthesize groups_popup;
@synthesize background;
@synthesize spinner;
@synthesize username;

@synthesize window, webview;

+ (void)setupDefaults
{
    NSString *userDefaultsValuesPath;
    NSDictionary *userDefaultsValuesDict;
    NSDictionary *initialValuesDict;
    NSArray *resettableUserDefaultsKeys;
    
    userDefaultsValuesPath = [[NSBundle mainBundle] pathForResource:@"UserDefaults" ofType:@"plist"];
    userDefaultsValuesDict = [NSDictionary dictionaryWithContentsOfFile:userDefaultsValuesPath];
    
    [[NSUserDefaults standardUserDefaults] registerDefaults:userDefaultsValuesDict];
    
    // if your application supports resetting a subset of the defaults to
    // factory values, you should set those values
    // in the shared user defaults controller
    //resettableUserDefaultsKeys=[NSArray arrayWithObjects:@"Value1",@"Value2",@"Value3",nil];
    //initialValuesDict=[userDefaultsValuesDict dictionaryWithValuesForKeys:resettableUserDefaultsKeys];
    
    // Set the initial values in the shared user defaults controller
    // [[NSUserDefaultsController sharedUserDefaultsController] setInitialValues:initialValuesDict];
    
}


+ (void)initialize {
    [self setupDefaults];
}

- (void)applicationDidFinishLaunching:(NSNotification *)aNotification
{
    
    [error_message setHidden:TRUE];
    
    
  //NSNotificationCenter *center = [NSNotificationCenter defaultCenter]; 
  //[center addObserver:self selector:@selector (webViewProgressFinished:) name:WebViewProgressFinishedNotification object:webview]; 
}

/* Called when the client receives a new message */
- (void)newMessage:(MHConvoreMessage *)message
{
    NSLog(@"[%@]: %@", message.user.name, message.message);
}

- (void)getGroups {
    [client groups:^(NSArray *groups, NSError *error) {
        [self setGroups_list:groups];
        NSLog(@"Groups.");
    }];
}
- (IBAction)loginToConvore:(id)sender {
    [spinner startAnimation: self];
    [[login_box animator] setAlphaValue:0.0];
    client = [MHConvoreClient clientWithUsername:[username_field stringValue] password:[password_field stringValue]];
    client.listener = self;
    
    [client verifyAccount:^ (MHConvoreUser *user, NSError *error) {
        [spinner stopAnimation: self];

        if (error == nil) {
            [self getGroups];
            [client listen];
            [error_message setHidden:TRUE];
            [[login_box animator] setAlphaValue:0.0];
            [login_box setHidden:true];
        } else {
            [[login_box animator] setAlphaValue:1.0];
            [error_message setHidden:false];
            [error_message setStringValue:[error localizedDescription]];
        }
    }];
    
}
- (IBAction)showGroup:(id)sender {

    [client topicsInGroup:[[[groups_controller selectedObjects] objectAtIndex:0] valueForKey:@"groupId"] block:^(NSArray *topics, NSError *error) {
        [self setTopics_list: topics];
    }]; 
}
@end
