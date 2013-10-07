//
//  main.m
//  safe-xcode-select
//
//  Created by Jeff Kelley on 10/7/13.
//  Copyright (c) 2013 Detroit Labs. All rights reserved.
//


#import <Foundation/Foundation.h>


static void usage(void);


int main(int argc, const char * argv[])
{
    int returnValue = EXIT_SUCCESS;

    @autoreleasepool {
        
        // The first (and only) argument should be a path to an Xcode.app bundle
        if (argc != 2) {
            usage();
            returnValue = EXIT_FAILURE;
        }
        else {
            NSString *path =
            [[NSString alloc] initWithCString:argv[1]
                                     encoding:NSUTF8StringEncoding];
            
            BOOL isDirectory;
            NSFileManager *fileManager = [NSFileManager defaultManager];
            
            if (path &&
                ([path hasSuffix:@".app"] || [path hasSuffix:@".app/"]) &&
                [fileManager fileExistsAtPath:path isDirectory:&isDirectory] &&
                isDirectory) {
                NSString *finalPath =
                [[path stringByAppendingPathComponent:@"Contents"]
                 stringByAppendingPathComponent:@"Developer"];
                
                NSTask *task =
                [NSTask launchedTaskWithLaunchPath:@"/usr/bin/xcode-select"
                                         arguments:@[ @"--switch", finalPath ]];
                
                [task waitUntilExit];
                
                returnValue = [task terminationStatus];
            }
            else {
                usage();
                returnValue = EXIT_FAILURE;
            }
        }
    }
    
    return returnValue;
}

static void usage(void)
{
    printf("Usage: safe-xcode-select <Xcode path>\n");
}