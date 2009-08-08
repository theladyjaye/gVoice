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

#import "SMSView.h"
#import "GVGoogleVoice.h"

const static NSInteger maxChars = 160;

@interface SMSView()
- (void)updateCharacterCount;
@end

@implementation SMSView
@synthesize phoneNumber, message, characterCount;
@dynamic remainingCharacters;

- (void)textViewDidChange:(UITextView *)textView
{
	[self updateCharacterCount];
}

- (BOOL)textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text
{
	BOOL status = YES;
	
	if(self.remainingCharacters == 0 && range.length != 1)
	{
		status = NO;
	}
	
	return status;
}

- (void)textViewDidBeginEditing:(UITextView *)textView
{
	[self updateCharacterCount];
}

- (NSInteger) remainingCharacters
{
	return maxChars - [message.text length];
}

- (IBAction)cancel
{
	// slops...
	[phoneNumber resignFirstResponder];
	[message resignFirstResponder];
}

- (IBAction)send
{
	GVGoogleVoice * voice = [[GVGoogleVoice alloc] init];
	[voice sms:phoneNumber.text message:message.text threadId:nil];
	[voice autorelease];
	
	message.text = [NSString string];
	[self updateCharacterCount];
	
}

- (void)updateCharacterCount
{
	self.characterCount.text = [NSString stringWithFormat:@"%i", self.remainingCharacters];
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

/*
// Implement viewDidLoad to do additional setup after loading the view, typically from a nib.
- (void)viewDidLoad {
    [super viewDidLoad];
}
*/

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
    [super dealloc];
}


@end
