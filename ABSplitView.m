//
//  ABSplitView.m
//  Conframe
//
//  Created by Austin Bales on 5/23/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "ABSplitView.h"


@implementation ABSplitView

- (NSColor*)dividerColor {
  return [NSColor colorWithCalibratedRed:0.61 green:0.73 blue:0.85 alpha:0.7];
}
- (CGFloat)maxPossiblePositionOfDividerAtIndex:(NSInteger) index{
  return 350;
}
@end
