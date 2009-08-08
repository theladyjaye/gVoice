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

#import "GVOperation.h"
#import "GVAPISettings.h"

@implementation GVOperation
@synthesize command = _command;
@synthesize delegate;

+ (GVOperation *) operationWithCommand:(id<GVCommand>)aCommand;
{
	GVOperation * operation = [[[GVOperation alloc] init] autorelease];
	operation.command       = aCommand;
	return operation;
}

- (void)operationDidFinish:(NSDictionary *)operationInfo
{
	[self.delegate performSelectorOnMainThread:@selector(operationDidFinish:) withObject:operationInfo waitUntilDone:YES];
}

-(void)main
{
	
	NSHTTPURLResponse * response  = nil;
	NSError * error               = nil;
	
	NSData * data = [NSURLConnection sendSynchronousRequest:[self.command request] returningResponse:&response error:&error];
	
	NSArray * cookies     = [NSHTTPCookie cookiesWithResponseHeaderFields:[response allHeaderFields] forURL:[NSURL URLWithString:kGVCookieUrl]];
	[[NSHTTPCookieStorage sharedHTTPCookieStorage] setCookies:cookies forURL:[NSURL URLWithString:kGVCookieUrl] mainDocumentURL:[NSURL URLWithString:kGVCookieUrl]];
	
	NSString * dataString = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
	NSLog(@"%@", [response allHeaderFields]);
	NSLog(@"%@", dataString);
	
	NSDictionary * operationInfo = [NSDictionary dictionaryWithObjectsAndKeys:[self.command class], kGVOperationKeyClass, error, kGVOperationKeyError, nil];
	
	self.command = nil;
	[self operationDidFinish:operationInfo];
	
}


- (void)dealloc
{
	self.command = nil;
	[super dealloc];
}


@end
