//
//  CustomStripe.m
//  Conframe
//
//  Created by Austin Robert Bales on 5/22/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "CustomStripe.h"


@implementation CustomStripe : NSView

- (void)drawRect:(NSRect)dirtyRect {
    // Fill in background Color
    //CGContextRef context = (CGContextRef) [[NSGraphicsContext currentContext] graphicsPort];
    //CGContextSetRGBFillColor(context, 0.227,0.251,0.337,0.8);
    //CGContextFillRect(context, NSRectToCGRect(dirtyRect));
    [[NSColor colorWithPatternImage:[NSImage imageNamed:@"stripe.png"]] set];
    NSRectFill (dirtyRect);
}

@end
