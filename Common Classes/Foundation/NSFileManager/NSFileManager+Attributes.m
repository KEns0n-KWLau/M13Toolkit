//
//  NSFileManager+Attributes.m
//  M13Toolkit
/*Copyright (c) 2015 Brandon McQuilkin
 
 Permission is hereby granted, free of charge, to any person obtaining a copy of this software and associated documentation files (the "Software"), to deal in the Software without restriction, including without limitation the rights to use, copy, modify, merge, publish, distribute, sublicense, and/or sell copies of the Software, and to permit persons to whom the Software is furnished to do so, subject to the following conditions:
 
 The above copyright notice and this permission notice shall be included in all copies or substantial portions of the Software.
 
 THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.
 */

#import "NSFileManager+Attributes.h"
#include <sys/xattr.h>

@implementation NSFileManager (Attributes)

- (NSDate *)creationDateForItemAtPath:(NSString *)path error:(NSError *__autoreleasing *)error
{
    return (NSDate *)[[[NSFileManager defaultManager] attributesOfItemAtPath:path error:error] objectForKey:NSFileCreationDate];
}

- (BOOL)addSkipBackupAttributeToItemAtPath:(NSString *)path
{
    const char* filePath = [path fileSystemRepresentation];
    const char* attrName = "com.apple.MobileBackup";
    u_int8_t attrValue = 1;
    
    int result = setxattr(filePath, attrName, &attrValue, sizeof(attrValue), 0, 0);
    return result == 0;
}

@end
