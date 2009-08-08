/**
 *    gVoice
 * 
 *    Copyright (C) 2009 Adam Venturella
 *
 *    LICENSE:
 *
 *    Licensed under the Apache License, Version 2.0 (the "License"); you may not
 *    use this file except in compliance with the License.  You may obtain a copy
 *    of the License at
 *
 *    http://www.apache.org/licenses/LICENSE-2.0
 *
 *    This library is distributed in the hope that it will be useful, but WITHOUT ANY WARRANTY; 
 *    without even the implied warranty of MERCHANTABILITY or FITNESS FOR A PARTICULAR 
 *    PURPOSE. See the License for the specific language governing permissions and
 *    limitations under the License.
 *
 *    Author: Adam Venturella - aventurella@gmail.com
 *
 **/

#import "NavigationView.h"
#import "GVGoogleVoice.h"
#import "AppSettings.h"
#import "GVAPISettings.h"

@interface NavigationView()
- (void) authorizationError;
@end

@implementation NavigationView
@synthesize tabBarController;

// Implement viewDidLoad to do additional setup after loading the view, typically from a nib.
- (void)viewDidLoad 
{
	AppSettings * settings = [[AppSettings alloc] init];
	tabBarController.delegate = self;
	
	if(settings.validAuth == NO)
	{
		[tabBarController setSelectedIndex:1];
	}
	else
	{
		GVGoogleVoice * voice = [[GVGoogleVoice alloc] init];
		[voice authorize:settings.email password:settings.password];
		voice.delegate = self;
	}
	
	[settings release];
	
	
	[self.view addSubview:tabBarController.view];
	[super viewDidLoad];
}

- (BOOL)tabBarController:(UITabBarController *)tabBarController shouldSelectViewController:(UIViewController *)viewController
{
	AppSettings * settings = [[AppSettings alloc] init];
	BOOL status = NO;
	
	if(settings.validAuth)
	{
		status = YES;
	}
	else
	{
		[self authorizationError];
	}
	
	return status;
}

- (void)googleVoiceAuthorizationDidFinish:(GVGoogleVoice *)voice info:(NSDictionary *)userInfo
{
	AppSettings * settings = [[AppSettings alloc] init];
	
	if([userInfo objectForKey:kGVOperationKeyError])
	{
		settings.validAuth     = NO;
		[self authorizationError];
	}
	else
	{
		settings.validAuth     = YES;
		NSLog(@"AUTHORIZED: %@", voice.sessionKey);
	}
	
	[settings release];
	[voice release];
	
}

- (void) authorizationError
{	
	UIAlertView * alert    = [[UIAlertView alloc] initWithTitle:@"Invalid Login" message:@"Oops...Invalid login.  Did you enter your username and password correctly?" delegate:nil cancelButtonTitle:@"Dismiss" otherButtonTitles:nil];
	[alert show];
	[alert release];
}


- (void)didReceiveMemoryWarning {
	// Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
	
	// Release any cached data, images, etc that aren't in use.
}

- (void)viewDidUnload 
{
	tabBarController = nil;
}


- (void)dealloc 
{
	[super dealloc];
}


@end
