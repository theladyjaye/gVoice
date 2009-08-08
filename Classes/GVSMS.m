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
#import "GVSMS.h"
#import "GVAPISettings.h"

@implementation GVSMS
- (id)initWithSessionKey:(NSString *)sessionKey phoneNumber:(NSString *)phoneNumber message:(NSString *)message threadId:(NSString *)threadId
{
	if(self = [super init])
	{
		_sessionKey  = sessionKey;
		_phoneNumber = phoneNumber;
		_message     = message;
		
		if(threadId){
			_threadId = threadId;
			[_threadId retain];
		}
		
		[_sessionKey retain];
		[_phoneNumber retain];
		[_message retain];
	}
	return self;
}

-(NSURLRequest *) request
{
	
	NSMutableURLRequest * request = [NSMutableURLRequest requestWithURL:[NSURL URLWithString:kGVSMSUrl] 
															cachePolicy:NSURLRequestUseProtocolCachePolicy
														timeoutInterval:kGVDefaultTimeout];
	
	
	NSString * body = [NSString stringWithFormat:@"_rnr_se=%@&phoneNumber=%@&text=%@&id=%@", _sessionKey, _phoneNumber, _message, _threadId];
	body = [body stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
	
	NSArray * cookies          = [[NSHTTPCookieStorage sharedHTTPCookieStorage] cookiesForURL:[NSURL URLWithString:kGVCookieUrl]];
	
	
	NSDictionary * headers     = [NSHTTPCookie requestHeaderFieldsWithCookies:cookies];
	
	[request setAllHTTPHeaderFields:headers];
	[request setHTTPMethod:@"POST"];
	[request setHTTPBody: [NSData dataWithBytes:[body UTF8String] length:[body length]]];
	
	
	return request;
}

- (void) dealloc
{
	[_sessionKey release];
	[_phoneNumber release];
	[_message release];
	[_threadId release];
	
	[super dealloc];
}

@end
