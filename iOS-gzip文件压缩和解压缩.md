##GZIP文件压缩和解压缩

Here’s an example of how you would use the class:

	/**
	 @file LFCGzipUtility.h
	 @author Clint Harris (www.clintharris.net)

	 Note: The code in this file has been commented so as to be compatible with
	 Doxygen, a tool for automatically generating HTML-based documentation from
	 source code. See http://www.doxygen.org for more info.
	 */
	 
	 #import <Foundation/Foundation.h>
	 #import "zlib.h"
 
	@interface LFCGzipUtility : NSObject
	{
	 
	}
 
	+(NSData*) gzipData:(NSData *)pUncompressedData;  //压缩
	+(NSData*) ungzipData:(NSData *)compressedData;  //解压缩
 
	@end
	
	
	***************************************************************
	
	/**
	 @file LFCGzipUtility.m
	 */
	 
	 
	 #import "LFCGzipUtility.h"
 
	@implementation LFCGzipUtility
 
	+(NSData*) gzipData: (NSData*)pUncompressedData
	{
    	if (!pUncompressedData || [pUncompressedData length] == 0)
    	{
        	NSLog(@"%s: Error: Can't compress an empty or null NSData object.", __func__);
        	return nil;
    	}
 
    	z_stream zlibStreamStruct;
    	zlibStreamStruct.zalloc    = Z_NULL; // Set zalloc, zfree, and opaque to Z_NULL so
    	zlibStreamStruct.zfree     = Z_NULL; // that when we call deflateInit2 they will be
    	zlibStreamStruct.opaque    = Z_NULL; // updated to use default allocation functions.
    	zlibStreamStruct.total_out = 0; // Total number of output bytes produced so far
    	zlibStreamStruct.next_in   = (Bytef*)[pUncompressedData bytes]; // Pointer to input bytes
    	zlibStreamStruct.avail_in  = [pUncompressedData length]; // Number of input bytes left to process
 
    	int initError = deflateInit2(&zlibStreamStruct, Z_DEFAULT_COMPRESSION, Z_DEFLATED, (15+16), 8, Z_DEFAULT_STRATEGY);
    	if (initError != Z_OK)
    	{
        	NSString *errorMsg = nil;
        	switch (initError)
        	{
            	case Z_STREAM_ERROR:
                	errorMsg = @"Invalid parameter passed in to function.";
                	break;
            	case Z_MEM_ERROR:
                	errorMsg = @"Insufficient memory.";
                	break;
            	case Z_VERSION_ERROR:
                	errorMsg = @"The version of zlib.h and the version of the library linked do not match.";
                	break;
            	default:
               		errorMsg = @"Unknown error code.";
                	break;
        	}
        	NSLog(@"%s: deflateInit2() Error: \"%@\" Message: \"%s\"", __func__, errorMsg, zlibStreamStruct.msg);
        	return nil;
    	}
 
    	// Create output memory buffer for compressed data. The zlib documentation states that
    	// destination buffer size must be at least 0.1% larger than avail_in plus 12 bytes.
    	NSMutableData *compressedData = [NSMutableData dataWithLength:[pUncompressedData length] * 1.01 + 12];
 
    	int deflateStatus;
    	do
    	{
        	// Store location where next byte should be put in next_out
        	zlibStreamStruct.next_out = [compressedData mutableBytes] + zlibStreamStruct.total_out;
 
        	// Calculate the amount of remaining free space in the output buffer
        	// by subtracting the number of bytes that have been written so far
        	// from the buffer's total capacity
        	zlibStreamStruct.avail_out = [compressedData length] - zlibStreamStruct.total_out;
        	deflateStatus = deflate(&zlibStreamStruct, Z_FINISH);
 
    	} while ( deflateStatus == Z_OK );
 
    	// Check for zlib error and convert code to usable error message if appropriate
    	if (deflateStatus != Z_STREAM_END)
    	{
        	NSString *errorMsg = nil;
        	switch (deflateStatus)
        	{
            	case Z_ERRNO:
                	errorMsg = @"Error occured while reading file.";
                	break;
            	case Z_STREAM_ERROR:
                	errorMsg = @"The stream state was inconsistent (e.g., next_in or next_out was NULL).";
                	break;
            	case Z_DATA_ERROR:
                	errorMsg = @"The deflate data was invalid or incomplete.";
                	break;
            	case Z_MEM_ERROR:
                	errorMsg = @"Memory could not be allocated for processing.";
                	break;
            	case Z_BUF_ERROR:
                	errorMsg = @"Ran out of output buffer for writing compressed bytes.";
                	break;
            	case Z_VERSION_ERROR:
                	errorMsg = @"The version of zlib.h and the version of the library linked do not match.";
                	break;
            	default:
                	errorMsg = @"Unknown error code.";
                	break;
        	}
        	NSLog(@"%s: zlib error while attempting compression: \"%@\" Message: \"%s\"", __func__, errorMsg, zlibStreamStruct.msg);
 
        	// Free data structures that were dynamically created for the stream.
        	deflateEnd(&zlibStreamStruct);
 
        	return nil;
    	}
    	// Free data structures that were dynamically created for the stream.
    	deflateEnd(&zlibStreamStruct);
    	[compressedData setLength: zlibStreamStruct.total_out];
    	NSLog(@"%s: Compressed file from %d KB to %d KB", __func__, 	[pUncompressedData length]/1024, [compressedData length]/1024);
 
    	return compressedData;
		}
 
	+(NSData *)ungzipData:(NSData *)compressedData
	{
    	if ([compressedData length] == 0)
        	return compressedData;
 
    		unsigned full_length = [compressedData length];
    		unsigned half_length = [compressedData length] / 2;
 
    		NSMutableData *decompressed = [NSMutableData dataWithLength: full_length + half_length];
    	BOOL done = NO;
    	int status;
 
    	z_stream strm;
    	strm.next_in = (Bytef *)[compressedData bytes];
    	strm.avail_in = [compressedData length];
    	strm.total_out = 0;
    	strm.zalloc = Z_NULL;
    	strm.zfree = Z_NULL;
    	if (inflateInit2(&strm, (15+32)) != Z_OK)
    	return nil;
 
    	while (!done) {
        	// Make sure we have enough room and reset the lengths.
        	if (strm.total_out >= [decompressed length]) {
            	[decompressed increaseLengthBy: half_length];
        	}
        	strm.next_out = [decompressed mutableBytes] + strm.total_out;
        	strm.avail_out = [decompressed length] - strm.total_out;
        	// Inflate another chunk.
        	status = inflate (&strm, Z_SYNC_FLUSH);
        	if (status == Z_STREAM_END) {
            	done = YES;
        	} else if (status != Z_OK) {
            	break;
        	}
    	}
 
    	if (inflateEnd (&strm) != Z_OK)
        	return nil;
    	// Set real length.
    	if (done) {
        	[decompressed setLength: strm.total_out];
        	return [NSData dataWithData: decompressed];
    	}
    	return nil;
	}
 
	@end
	
使用代码示例：

压缩：
	
	NSString *csvPath = @"/Users/xiaohei/Desktop/stream_ios.csv";
    NSFileManager* fm = [NSFileManager defaultManager];
    NSData* data = [[NSData alloc] init];
    data = [fm contentsAtPath:csvPath];

    NSData *dateGzip = [LFCGzipUtility gzipData:data];
    NSLog(@"%@",dateGzip);
    
    NSString *fileName = @"/Users/xiaohei/Desktop/stream_ios.csv.gz";
    
    [dateGzip writeToFile: fileName atomically: NO];
    
    注意事项：压缩的文件后缀需要有csv：文件类型，gz：压缩的什么格式
    
解压缩：

	NSString *fileName = @"/Users/xiaohei/Desktop/stream_ios.csv.gz";
    NSFileManager* fm = [NSFileManager defaultManager];
    NSData* data = [[NSData alloc] init];
    data = [fm contentsAtPath:fileName];
    NSData *dataUnGzip = [LFCGzipUtility ungzipData:data];
    NSString *unGzipfileName = @"/Users/xiaohei/Desktop/stream_ios.csv";
    [dataUnGzip writeToFile: unGzipfileName atomically: NO];
    
    注意事项：解压缩的文件后缀需要有csv：文件类型
  压缩和解压缩效果如下：
   ![icon压缩图片](http://v2it.win/wp-content/uploads/2017/04/屏幕快照-2017-04-10-下午10.24.05.png)
	 