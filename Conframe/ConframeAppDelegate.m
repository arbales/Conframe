//
//  ConframeAppDelegate.m
//  Conframe
//
//  Created by Austin Robert Bales on 5/19/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "ConframeAppDelegate.h"
#import <objc/runtime.h>

@implementation ConframeAppDelegate
@synthesize groups_controller;
@synthesize username_field;
@synthesize password_field;
@synthesize error_message;
@synthesize login_box;
@synthesize groups_list;
@synthesize topics_list;
@synthesize avatar;
@synthesize groups_popup;
@synthesize background;
@synthesize titleView;
@synthesize spinner;
@synthesize username;

@synthesize window, webview;

+ (void)setupDefaults
{
    NSString *userDefaultsValuesPath;
    NSDictionary *userDefaultsValuesDict;
    //NSDictionary *initialValuesDict;
    //NSArray *resettableUserDefaultsKeys;
    
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
  [window setContentBorderThickness:32.0 forEdge:NSMinYEdge];
  [window setContentBorderThickness:32.0 forEdge:NSMaxYEdge];
  
  id class = [[[window contentView] superview] class];  // Add our drawRect: to the frame class 
  Method m0 = class_getInstanceMethod([self class], @selector(drawRect:));
  class_addMethod(class, @selector(drawRectOriginal:), method_getImplementation(m0), method_getTypeEncoding(m0));  // Exchange methods
  Method m1 = class_getInstanceMethod(class, @selector(drawRect:)); 
  Method m2 = class_getInstanceMethod(class, @selector(drawRectOriginal:)); method_exchangeImplementations(m1, m2); 
  
  [self setupTitle];
  [self setupAccessory];
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
            [[loginView animator] setAlphaValue:0.0];
          NSOperationQueue *queue = [[NSOperationQueue alloc] init];
          [queue setName:@"com.App.Task"];
          
          [queue addOperationWithBlock:^{
            NSURL *imageURL = [NSURL URLWithString:user.avatarURL];
            NSData *imageData = [imageURL resourceDataUsingCache:NO];
            NSImage *imageFromBundle = [[NSImage alloc] initWithData:imageData];
            [avatar setImage:imageFromBundle];
          }];  

          
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

-(void)setupTitle {
  NSView *themeFrame = [[window contentView] superview];
  NSRect container = [themeFrame frame];  // c for "container"
  
  NSRect titleViewRect = [titleView frame];
  NSRect titleFrame = NSMakeRect(
                                 (container.size.width / 2) - (titleViewRect.size.width / 2),   // x position
                                 container.size.height - (titleViewRect.size.height), // y position
                                 titleViewRect.size.width,  // width
                                 titleViewRect.size.height);        // height
  [[titleView cell] setBackgroundStyle:NSBackgroundStyleDark]; 
  [titleView setFrame:titleFrame];
  [[[window contentView] superview] addSubview:titleView];
}

-(void)setupAccessory {
  NSView *themeFrame = [[window contentView] superview];
  NSRect container = [themeFrame frame];  // c for "container"
  NSRect aV = [accessoryView frame];      // aV for "accessory view"
  NSRect titleViewRect = [titleView frame];
  
  NSRect newFrame = NSMakeRect(
                               container.size.width - aV.size.width,   // x position
                               container.size.height - aV.size.height, // y position
                               aV.size.width,  // width
                               aV.size.height);        // height
  [accessoryView setFrame:newFrame];
  [themeFrame addSubview:accessoryView];
}


- (void)drawRect:(NSRect)rect
{
    // Call original drawing method
	[self drawRectOriginal:rect];
  
    //
    // Build clipping path : intersection of frame clip (bezier path with rounded corners) and rect argument
    //
	NSRect windowRect = [[self window] frame];
	windowRect.origin = NSMakePoint(0, 0);
  
	float cornerRadius = [self roundedCornerRadius];
	[[NSBezierPath bezierPathWithRoundedRect:windowRect xRadius:cornerRadius yRadius:cornerRadius] addClip];
	[[NSBezierPath bezierPathWithRect:rect] addClip];
  
    //
    // Draw background image (extend drawing rect : biggest rect dimension become's rect size)
    //
	NSRect imageRect = windowRect;
	if (imageRect.size.width > imageRect.size.height)
	{
		imageRect.origin.y = -(imageRect.size.width-imageRect.size.height)/2;
		imageRect.size.height = imageRect.size.width;
	}
	else
	{
		imageRect.origin.x = -(imageRect.size.height-imageRect.size.width)/2;
		imageRect.size.width = imageRect.size.height;
	}
    //[[NSImage imageNamed:NSImageNameActionTemplate] drawInRect:imageRect fromRect:NSZeroRect operation:NSCompositeSourceAtop fraction:0.15];
  
    //
    // Draw a background color on top of everything
    //
	CGContextRef context = [[NSGraphicsContext currentContext]graphicsPort];
	CGContextSetBlendMode(context, kCGBlendModeMultiply);
	[[NSColor colorWithCalibratedRed:0.1 green:0.13 blue:0.15 alpha:0.7] set];
	[[NSBezierPath bezierPathWithRect:rect] fill];
  
  
}
@end
