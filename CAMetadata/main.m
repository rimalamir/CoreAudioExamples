//
//  main.m
//  CAMetadata
//
//  Created by Amir Rimal on 24/08/2021.
//

#import <Foundation/Foundation.h>
//#import "getFileInfo.m"
//#import "toneGenerator.m"
//#import "formatTester.m"
#import "audioQueueRecording.m"

//Audio location is passed from scheme
int main(int argc, const char * argv[]) {
    @autoreleasepool {
        //getMediaInfo(argc, argv);
//        generateTone(argc, argv);
//        formatTester(argc, argv);
        audioQueueRecording(argc, argv);
    }
}

