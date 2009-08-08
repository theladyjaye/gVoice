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

#import "GVCall.h"
#import "GVAPISettings.h"

@implementation GVCall
- (id)initWithSessionKey:(NSString *)sessionKey forwardingNumber:(NSString *)forwardingNumber outgoingNumber:(NSString *)outgoingNumber subscriberNumber:(NSString *)subscriberNumber
{
	if(self = [super init])
	{
		_sessionKey       = sessionKey;
		_forwardingNumber = forwardingNumber;
		_outgoingNumber   = outgoingNumber;
		_subscriberNumber = subscriberNumber ? subscriberNumber : @"undefined";
		
		[_sessionKey retain];
		[_forwardingNumber retain];
		[_outgoingNumber retain];
		[_subscriberNumber retain];
	}
	
	return self;
}

-(NSURLRequest *) request
{
	
	NSMutableURLRequest * request = [NSMutableURLRequest requestWithURL:[NSURL URLWithString:kGVCallUrl] 
															cachePolicy:NSURLRequestUseProtocolCachePolicy
														timeoutInterval:kGVDefaultTimeout];
	
	
	NSString * body = [NSString stringWithFormat:@"_rnr_se=%@&forwardingNumber=%@&outgoingNumber=%@&subscriberNumber=%@", _sessionKey, _forwardingNumber, _outgoingNumber, _subscriberNumber];
	body = [body stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
	
	NSArray * cookies          = [[NSHTTPCookieStorage sharedHTTPCookieStorage] cookiesForURL:[NSURL URLWithString:kGVCookieUrl]];
	
	
	NSDictionary * headers     = [NSHTTPCookie requestHeaderFieldsWithCookies:cookies];
	
	NSLog(@"----------------------------- %@", headers);
	
	[request setAllHTTPHeaderFields:headers];
	[request setHTTPMethod:@"POST"];
	[request setHTTPBody: [NSData dataWithBytes:[body UTF8String] length:[body length]]];
	
	
	return request;
}

- (void) dealloc
{
	[_sessionKey release];
	[_forwardingNumber release];
	[_outgoingNumber release];
	[_subscriberNumber release];
	
	[super dealloc];
}

@end
