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

#import "GVAuthorization.h"
#import "GVAPISettings.h"

@implementation GVAuthorization 

- (id)initWithEmail:(NSString *)email password:(NSString *)password
{
	if(self = [super init])
	{
		_email    = email;
		_password = password;
		
		[_email retain];
		[_password retain];
	}
	
	return self;
}

-(NSURLRequest *) request
{

	NSMutableURLRequest * request = [NSMutableURLRequest requestWithURL:[NSURL URLWithString:kGVAuthorizationUrl] 
															cachePolicy:NSURLRequestUseProtocolCachePolicy
														timeoutInterval:kGVDefaultTimeout];
	
	
	NSString * body = [NSString stringWithFormat:@"Email=%@&Passwd=%@", _email, _password];
	body = [body stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
	
	[request setHTTPMethod:@"POST"];
	[request setHTTPBody: [NSData dataWithBytes:[body UTF8String] length:[body length]]];
	
	return request;
}

- (void)dealloc
{
	[_email release];
	[_password release];
	
	[super dealloc];
}

@end
