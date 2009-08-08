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

#import "AppSettings.h"

#define kAppSettingsEmailKey        @"email"
#define kAppSettingsPasswordKey     @"password"
#define kAppSettingsPhoneNumberKey  @"phone"
#define kAppSettingsValidAuthKey    @"validAuth"

@implementation AppSettings
@dynamic email, password, phoneNumber, validAuth;


- (void)setValidAuth:(BOOL)value
{
	[[NSUserDefaults standardUserDefaults] setBool:value forKey:kAppSettingsValidAuthKey];
	[[NSUserDefaults standardUserDefaults] synchronize];
}

- (BOOL)validAuth
{
	return [[NSUserDefaults standardUserDefaults] boolForKey:kAppSettingsValidAuthKey];
}


- (void)setEmail:(NSString *)value
{
	[[NSUserDefaults standardUserDefaults] setObject:value forKey:kAppSettingsEmailKey];
	[[NSUserDefaults standardUserDefaults] synchronize];
}

- (NSString *)email
{
	return [[NSUserDefaults standardUserDefaults] stringForKey:kAppSettingsEmailKey];
}

- (void)setPassword:(NSString *)value
{
	[[NSUserDefaults standardUserDefaults] setObject:value forKey:kAppSettingsPasswordKey];
	[[NSUserDefaults standardUserDefaults] synchronize];
}

- (NSString *)password
{
	return [[NSUserDefaults standardUserDefaults] stringForKey:kAppSettingsPasswordKey];
}

- (void)setPhoneNumber:(NSString *)value
{
	[[NSUserDefaults standardUserDefaults] setObject:value forKey:kAppSettingsPhoneNumberKey];
	[[NSUserDefaults standardUserDefaults] synchronize];
}

- (NSString *)phoneNumber
{
	return [[NSUserDefaults standardUserDefaults] stringForKey:kAppSettingsPhoneNumberKey];
}

- (void)dealloc
{
	[[NSUserDefaults standardUserDefaults] synchronize];
	[super dealloc];
}


@end
