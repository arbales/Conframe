//
//  MiddleAlignedTextFieldCell.m
//  Conframe
//
//  Created by Austin Robert Bales on 5/22/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "MiddleAlignedTextFieldCell.h"


@implementation MiddleAlignedTextFieldCell

- (NSRect)titleRectForBounds:(NSRect)theRect {
    NSRect titleFrame = [super titleRectForBounds:theRect];
    NSSize titleSize = [[self attributedStringValue] size];
    titleFrame.size.width = titleFrame.size.width - 12.0;
    titleFrame.origin.x = theRect.origin.x + 10.0;
    titleFrame.origin.y = theRect.origin.y - .5 + (theRect.size.height - titleSize.height) / 2.0;
    return titleFrame;
}

- (void)drawInteriorWithFrame:(NSRect)cellFrame inView:(NSView *)controlView {
    NSRect titleRect = [self titleRectForBounds:cellFrame];
    [[self attributedStringValue] drawInRect:titleRect];
}

@end