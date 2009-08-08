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

#import "SettingsView.h"
#import "GVAPISettings.h"
#import "AppSettings.h"
#import "GVGoogleVoice.h"

@implementation SettingsView
@synthesize email, password, phoneNumber;

- (IBAction)authorize
{
	settings.email       = email.text;
	settings.password    = password.text;
	settings.phoneNumber = phoneNumber.text;
	
	// this is sloppy...
	[email resignFirstResponder];
	[password resignFirstResponder];
	[phoneNumber resignFirstResponder];
	
	GVGoogleVoice * voice = [[GVGoogleVoice alloc] init];
	voice.delegate = self;
	[voice authorize:settings.email password:settings.password];
}

- (void)viewDidLoad 
{
	settings         = [[AppSettings alloc] init];
	email.text       = settings.email;
	password.text    = settings.password;
	phoneNumber.text = settings.phoneNumber;
	
	[super viewDidLoad];
}

- (void)googleVoiceAuthorizationDidFinish:(GVGoogleVoice *)voice info:(NSDictionary *)userInfo;
{
	if([userInfo objectForKey:kGVOperationKeyError])
	{	
		settings.validAuth     = NO;
		UIAlertView * alert    = [[UIAlertView alloc] initWithTitle:@"Invalid Login" message:@"Oops...Invalid login.  Did you enter your username and password correctly?" delegate:nil cancelButtonTitle:@"Dismiss" otherButtonTitles:nil];
		[alert show];
		[alert release];
	}
	else
	{
		settings.validAuth     = YES;
	}
	
	[voice release];
}


/*
// Override to allow orientations other than the default portrait orientation.
- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
    // Return YES for supported orientations
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}
*/

- (void)didReceiveMemoryWarning {
	// Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
	
	// Release any cached data, images, etc that aren't in use.
}

- (void)viewDidUnload 
{
	
	settings.email       = email.text;
	settings.password    = password.text;
	settings.phoneNumber = phoneNumber.text;
	
	self.email       = nil;
	self.password    = nil;
	self.phoneNumber = nil;	
}


- (void)dealloc {
    [settings release];
	[super dealloc];
}


@end
