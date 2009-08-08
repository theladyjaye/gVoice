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

#define kGVDefaultTimeout    10
#define kGVAuthorizationUrl  @"https://www.google.com/accounts/ServiceLoginAuth?service=grandcentral"
#define kGVBaseUrl           @"https://www.google.com/voice/"
#define kGVCookieUrl         @"https://google.com/voice/"
#define kGVCallUrl           @"https://www.google.com/voice/call/connect/"
#define kGVCallCancelUrl     @"https://www.google.com/voice/call/cancel/"
#define kGVSMSUrl            @"https://www.google.com/voice/sms/send/"
#define kGVSessionKey        @"kGVSessionKey"


#define kGVOperationKeyClass  @"class"
#define kGVOperationKeyError  @"error"
#define kGVOperationKeySender @"GVInstance"
