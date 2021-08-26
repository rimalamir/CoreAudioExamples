//
//  formatTester.m
//  CAMetadata
//
//  Created by Amir Rimal on 25/08/2021.
//

#import <Foundation/Foundation.h>
#import <CoreAudio/CoreAudio.h>
#import <AudioToolbox/AudioFile.h>


/*static int formatTester(int argc, const char **argv) {
    
    AudioFileTypeAndFormatID fileTypeAndFormat;
    fileTypeAndFormat.mFileType = kAudioFileAIFFType;
    fileTypeAndFormat.mFormatID = kAudioFormatLinearPCM;
    
    OSStatus audioErr = noErr;
    UInt32 infoSize = 0;
    
    audioErr = AudioFileGetGlobalInfoSize(kAudioFileGlobalInfo_AvailableStreamDescriptionsForFormat, sizeof(fileTypeAndFormat), &fileTypeAndFormat, &infoSize);
    
    assert(audioErr == noErr);
    
    AudioStreamBasicDescription *asbds = malloc(infoSize);
    audioErr = AudioFileGetGlobalInfo(kAudioFileGlobalInfo_AvailableStreamDescriptionsForFormat, sizeof(fileTypeAndFormat), &fileTypeAndFormat, &infoSize, asbds);
    
    assert(audioErr == noErr);
    
    int asbdCount = infoSize / sizeof(AudioStreamBasicDescription);
    
    for (int i = 0; i < asbdCount; i++) {
        UInt32 format4cc = CFSwapInt32HostToBig(asbds[i].mFormatID);
        
        NSLog(@"%d: mFormatId: %4.4s, mFormatFlags: %d, mBitsPerChannel: %d", i, (char*)&format4cc, asbds[i].mFormatFlags, asbds[i].mBitsPerChannel);
    }
    
    free(asbds);
    
    return 0;
}

*/
