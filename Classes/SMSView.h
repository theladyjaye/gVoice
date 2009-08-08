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

#import <UIKit/UIKit.h>


@interface SMSView : UIViewController <UITextViewDelegate> {
	UITextField * phoneNumber;
	UITextView * message;
	UILabel * characterCount;
}

@property(nonatomic, retain) IBOutlet UITextField * phoneNumber;
@property(nonatomic, retain) IBOutlet UITextView * message;
@property(nonatomic, retain) IBOutlet UILabel * characterCount;
@property(nonatomic, readonly)  NSInteger  remainingCharacters;

- (IBAction)send;
- (IBAction)cancel;
@end
