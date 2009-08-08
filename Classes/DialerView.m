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

#import "DialerView.h"
#import "AppSettings.h"
#import "GVGoogleVoice.h"

@interface DialerView()
- (void)updateTextView:(NSString *)value;
@end

@implementation DialerView
@synthesize phoneNumber;

- (void)updateTextView:(NSString *)value
{
	phoneNumber.text = [NSString stringWithFormat:@"%@%@", phoneNumber.text, value];
}

- (IBAction)one 
{
	[self updateTextView:@"1"];
}

- (IBAction)two
{
	[self updateTextView:@"2"];
}

- (IBAction)three
{
	[self updateTextView:@"3"];
}

- (IBAction)four
{
	[self updateTextView:@"4"];
}

- (IBAction)five
{
	[self updateTextView:@"5"];
}

- (IBAction)six
{
	[self updateTextView:@"6"];
}

- (IBAction)seven
{
	[self updateTextView:@"7"];
}

- (IBAction)eight
{
	[self updateTextView:@"8"];
}

- (IBAction)nine
{
	[self updateTextView:@"9"];
}

- (IBAction)zero
{
	[self updateTextView:@"0"];
}

- (IBAction)pound
{
	[self updateTextView:@"#"];
}

- (IBAction)star
{
	[self updateTextView:@"*"];
}

- (IBAction)call
{
	[voice call:settings.phoneNumber outgoingNumber:phoneNumber.text subscriberNumber:nil];	
}

- (IBAction)backspace
{
	if([phoneNumber.text length] > 0)
	{
		phoneNumber.text = [phoneNumber.text substringToIndex:([phoneNumber.text length]-1)];
	}
}

/*
 // The designated initializer.  Override if you create the controller programmatically and want to perform customization that is not appropriate for viewDidLoad.
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
    if (self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil]) {
        // Custom initialization
    }
    return self;
}
*/



- (void)viewDidLoad 
{
	voice    = [[GVGoogleVoice alloc] init];
	settings = [[AppSettings alloc] init];
	[super viewDidLoad];	
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

- (void)viewDidUnload {
	// Release any retained subviews of the main view.
	// e.g. self.myOutlet = nil;
}


- (void)dealloc {
    [settings release];
	[voice release];
	[super dealloc];
}


@end
