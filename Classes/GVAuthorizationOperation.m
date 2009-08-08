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
#import "GVAuthorizationOperation.h"
#import "GVAPISettings.h"
#import "GVCommand.h"

@implementation GVAuthorizationOperation

+ (GVAuthorizationOperation *) authorizationOperationWithCommand:(id<GVCommand>)aCommand;
{
	GVAuthorizationOperation * operation = [[[GVAuthorizationOperation alloc] init] autorelease];
	operation.command       = aCommand;
	return operation;
}



- (void)main
{
	NSLog(@"AuthOperationStart");
	NSHTTPURLResponse * response  = nil;
	NSError * error               = nil;
	
	[NSURLConnection sendSynchronousRequest:[self.command request] returningResponse:&response error:&error];
	
	NSLog(@"%@", [response allHeaderFields]);
	
	if(!error)
	{
		
		NSString * authorized = [[response allHeaderFields] valueForKey:@"Set-Cookie"];
		NSError * status      = nil;
		NSRange range         = [authorized rangeOfString:@"SID"];
		
		
		
		if(range.location != NSNotFound)
		{
			//NSArray * cookies_round1; 
			//NSArray * cookies_round2;
			
			NSArray * cookies1     = [NSHTTPCookie cookiesWithResponseHeaderFields:[response allHeaderFields] forURL:[NSURL URLWithString:kGVCookieUrl]];
			
			
			//make a secondary request to get the _rnr_se value
			// there has to be a better way than this...

			
			// get the data we need to scan: 
			NSData * data         = [NSURLConnection sendSynchronousRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:kGVBaseUrl]] returningResponse:&response error:nil];
			NSArray * cookies2    = [NSHTTPCookie cookiesWithResponseHeaderFields:[response allHeaderFields] forURL:[NSURL URLWithString:kGVCookieUrl]];
			
			NSMutableArray * cookies = [NSMutableArray array];
			
			for(NSHTTPCookie * c in cookies1){
				[cookies addObject:c];
			}
			
			for(NSHTTPCookie * c in cookies2){
				[cookies addObject:c];
			}
			
			NSLog(@"------------------------------ %@", cookies);
			
			[[NSHTTPCookieStorage sharedHTTPCookieStorage] setCookies:cookies forURL:[NSURL URLWithString:kGVCookieUrl] mainDocumentURL:[NSURL URLWithString:kGVCookieUrl]];
			
			NSString * dataString = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
			
			NSRange range         = [dataString rangeOfString:@"_rnr_se\" value=\""];
			NSString * part       = [dataString substringFromIndex:(range.location + range.length)];
			NSScanner * scanner   = [NSScanner scannerWithString:part];
			NSString * key;
			
			[scanner scanUpToString:@"\"" intoString:&key];
			
			
			[[NSUserDefaults standardUserDefaults] setObject:key forKey:kGVSessionKey];
			[[NSUserDefaults standardUserDefaults] synchronize];
		}
		else
		{
			status = [NSError errorWithDomain:NSURLErrorDomain code:1 userInfo:nil];
		}
		
		NSDictionary * info = [NSDictionary dictionaryWithObjectsAndKeys:[self.command class], kGVOperationKeyClass, status, kGVOperationKeyError, nil];
		
		self.command = nil;
		[self operationDidFinish:info];
	 
	}
}

- (void) dealloc
{
	NSLog(@"auth operation dealloc");
	[super dealloc];
}
@end
