//
//  LoginRequest.m
//  Conframe
//
//  Created by Austin Bales on 5/22/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "LoginRequest.h"
#import "ASIHTTPRequest.h"


@implementation LoginRequest

- (id)init
{
    self = [super init];
    if (self) {
        // Initialization code here.
    }
    
    return self;
}

- (void)dealloc
{
    [super dealloc];
}

- (IBAction)grabURLInBackground:(id)sender
{
  NSURL *url = [NSURL URLWithString:@"http://allseeing-i.com"];
  __block ASIHTTPRequest *request = [ASIHTTPRequest requestWithURL:url];
//  [request setUsername: 
  [request setCompletionBlock:^{
      // Use when fetching text data
    NSString *responseString = [request responseString];
    
      // Use when fetching binary data
    NSData *responseData = [request responseData];
  }];
  [request setFailedBlock:^{
    NSError *error = [request error];
  }];
  [request startAsynchronous];
}

@end
