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
#import "GVAuthorizationDelegate.h"
@class AppSettings;
@interface SettingsView : UIViewController <GVAuthorizationDelegate>{
	
	UITextField * email;
	UITextField * password;
	UITextField * phoneNumber;
	
	AppSettings * settings;
}

@property(nonatomic, retain) IBOutlet UITextField * email;
@property(nonatomic, retain) IBOutlet UITextField * password;
@property(nonatomic, retain) IBOutlet UITextField * phoneNumber;

- (IBAction)authorize;
@end
