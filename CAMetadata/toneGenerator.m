//
//  toneGenerator.m
//  CAMetadata
//
//  Created by Amir Rimal on 24/08/2021.
//

#import <Foundation/Foundation.h>
#import <CoreAudio/CoreAudio.h>
#import <AudioToolbox/AudioFile.h>

#define SAMPLE_RATE 44100
#define DURATION 5.0
//Uncomment to generate different sounds
//#define FILENAME_FORMAT @"%0.3f-square.aif"
//#define FILENAME_FORMAT @"%0.3f-saw.aif"
#define FILENAME_FORMAT @"%0.3f-sine.aif"

static void sawWave(int i, SInt16 *sample, double waveLengthInSamples) {
    *sample = CFSwapInt16HostToBig(((i / waveLengthInSamples) * SHRT_MAX * 2) - SHRT_MAX);
}

static void squareWave(int i, SInt16 *sample, double waveLengthInSamples) {
    if (i < waveLengthInSamples / 2) {
        *sample = CFSwapInt16HostToBig(SHRT_MAX);
    } else {
        *sample = CFSwapInt16HostToBig(SHRT_MIN);
    }
}

static void sineWave(int i, SInt16 *sample, double waveLengthInSamples) {
    *sample = CFSwapInt16HostToBig((SInt16) SHRT_MAX * sin (2 * M_PI * (i / waveLengthInSamples)));
}

//Argument = 261.626
static int generateTone(int argc, const char **argv) {
    if (argc < 2) {
        printf ("Usage: CAToneFileGenerator n\n(where n is tone in Hz)");
        return  -1;
    }
    
    double hz = atof(argv[1]);
    assert(hz > 0);
    
    NSLog(@"Generating %f hz tone", hz);
    
    NSString *fileName = [NSString stringWithFormat:FILENAME_FORMAT, hz];
    NSString *filePath = [[[NSFileManager defaultManager] currentDirectoryPath] stringByAppendingPathComponent:fileName];
    NSURL *fileURL = [NSURL fileURLWithPath:filePath];
    
    AudioStreamBasicDescription asbd;
    memset(&asbd, 0, sizeof(asbd));
    
    asbd.mSampleRate = SAMPLE_RATE;
    asbd.mFormatID = kAudioFormatLinearPCM;
    asbd.mFormatFlags = kAudioFormatFlagIsBigEndian | kAudioFormatFlagIsSignedInteger | kAudioFormatFlagIsPacked;
    
    asbd.mBitsPerChannel = 16;
    asbd.mChannelsPerFrame = 1;
    
    asbd.mFramesPerPacket = 1;
    asbd.mBytesPerFrame = 2;
    asbd.mBytesPerPacket = 2;
    
    AudioFileID audioFile;
    OSStatus audioErr = noErr;
    audioErr = AudioFileCreateWithURL((__bridge CFURLRef)fileURL, kAudioFileAIFFType, &asbd, kAudioFileFlags_EraseFile, &audioFile);
    
    assert(audioErr == noErr);
    
    long maxSampleCount = SAMPLE_RATE * DURATION;
    
    long sampleCount = 0;
    UInt32 bytesToWrite = 2;
    double waveLengthInSamples = SAMPLE_RATE / hz;
    
    while (sampleCount < maxSampleCount) {
        
        for (int i = 0; i < waveLengthInSamples; i++) {
            //Square wave
            SInt16 sample;
            
//            squareWave(i, &sample, waveLengthInSamples);
            
//            sawWave(i, &sample, waveLengthInSamples);
            
            sineWave(i, &sample, waveLengthInSamples);
            
            audioErr = AudioFileWriteBytes(audioFile, false, sampleCount * 2, &bytesToWrite, &sample);
            assert(audioErr == noErr);
            sampleCount++;
        }
        
        
    }
    
    audioErr = AudioFileClose(audioFile);
    
    assert(audioErr == noErr);
    NSLog(@"Wrote %ld samples", sampleCount);
    
    
    return 0;
}
