//
//  getFileInfo.m
//  CAMetadata
//
//  Created by Amir Rimal on 24/08/2021.
//

#import <Foundation/Foundation.h>
#import <CoreAudio/CoreAudio.h>
#import <AudioToolbox/AudioFile.h>

//Argument: /Users/amirrimal/Documents/CAMetadata/audio.mp3 
static int getMediaInfo(int argc, const char **argv) {
    if (argc < 2) {
        printf("Usage: CAMetadata /full/path/to/audiofile\n");
        return  -1;
    }
    
    
    NSString *audioFilePath = [[NSString stringWithUTF8String:argv[1]] stringByExpandingTildeInPath];
    NSURL *audioURL = [NSURL fileURLWithPath:audioFilePath];
    
    AudioFileID audioFile;
    OSStatus theErr = noErr;
    
    theErr = AudioFileOpenURL((__bridge CFURLRef)audioURL, kAudioFileReadPermission, 0, &audioFile);
    assert(theErr == noErr);
    
    UInt32 dictionarySize = 0;
    theErr = AudioFileGetPropertyInfo(audioFile, kAudioFilePropertyInfoDictionary, &dictionarySize, 0);
    
    assert(theErr == noErr);
    
    CFDictionaryRef dictionary;
    theErr = AudioFileGetProperty(audioFile, kAudioFilePropertyInfoDictionary, &dictionarySize, &dictionary);
    
    assert(theErr == noErr);
    NSLog(@"dictionary: %@", dictionary);
    CFRelease(dictionary);
    
    theErr = AudioFileClose(audioFile);
    
    assert(theErr == noErr);
    
    return  0;
}
