###从数据库读取数据到CSV，使用EXCEL打开中文显示乱码问题

我们的SQLite数据库的文本编码是采用的UTF8

	SQLITE_API int SQLITE_STDCALL sqlite3_open(
	const char *filename,   /* Database filename (UTF-8) */
	sqlite3 **ppDb          /* OUT: SQLite db handle */
	);


如果不进行编码转换，就读取数据写入CSV文件的话，EXCEL打开中文显示是乱码的。

原因：因为EXCEL打开文件时默认使用unicode的编码方式。在Unicode基本多文种平面定义的字符（无论是拉丁字母、汉字或其他文字或符号），一律使用2字节储存。恰恰UTF-8是1字节的存储方式。

国标码是汉字的国家标准编码，目前主要有GB2312、GBK、GB18030三种。
1、GB2312编码方案于1980年发布，收录汉字6763个，采用双字节编码。
2、GBK编码方案于1995年发布，收录汉字21003个，采用双字节编码。
3、GB18030编码方案于2000年发布第一版，收录汉字27533个；2005年发布第二版，收录汉字70000余个，以及多种少数民族文字。GB18030采用单字节、双字节、四字节分段编码。

在NSUTF8StringEncoding定义文件,并没有找到中文编码格式

	/* Note that in addition to the values explicitly listed below, NSStringEncoding supports encodings provided by CFString.
	See CFStringEncodingExt.h for a list of these encodings.
	See CFString.h for functions which convert between NSStringEncoding and 	CFStringEncoding.
	*/
	typedef NSUInteger NSStringEncoding;
	NS_ENUM(NSStringEncoding) {
    NSASCIIStringEncoding = 1,		/* 0..127 only */
    NSNEXTSTEPStringEncoding = 2,
    NSJapaneseEUCStringEncoding = 3,
    NSUTF8StringEncoding = 4,
    NSISOLatin1StringEncoding = 5,
    NSSymbolStringEncoding = 6,
    NSNonLossyASCIIStringEncoding = 7,
    NSShiftJISStringEncoding = 8,          /* kCFStringEncodingDOSJapanese */
    NSISOLatin2StringEncoding = 9,
    NSUnicodeStringEncoding = 10,
    NSWindowsCP1251StringEncoding = 11,    /* Cyrillic; same as AdobeStandardCyrillic */
    NSWindowsCP1252StringEncoding = 12,    /* WinLatin1 */
    NSWindowsCP1253StringEncoding = 13,    /* Greek */
    NSWindowsCP1254StringEncoding = 14,    /* Turkish */
    NSWindowsCP1250StringEncoding = 15,    /* WinLatin2 */
    NSISO2022JPStringEncoding = 21,        /* ISO 2022 Japanese encoding for e-mail */
    NSMacOSRomanStringEncoding = 30,

    NSUTF16StringEncoding = NSUnicodeStringEncoding,      /* An alias for NSUnicodeStringEncoding */

    NSUTF16BigEndianStringEncoding = 0x90000100,          /* NSUTF16StringEncoding encoding with explicit endianness specified */
    NSUTF16LittleEndianStringEncoding = 0x94000100,       /* NSUTF16StringEncoding encoding with explicit endianness specified */

    NSUTF32StringEncoding = 0x8c000100,                   
    NSUTF32BigEndianStringEncoding = 0x98000100,          /* NSUTF32StringEncoding encoding with explicit endianness specified */
    NSUTF32LittleEndianStringEncoding = 0x9c000100        /* NSUTF32StringEncoding encoding with explicit endianness specified */
	};

但是apple给了我们提示CFStringEncodingExt.h，找到了kCFStringEncodingGB_18030_2000，终于解决了编码的问题。

解决办法：
	
	//将UTF8编码转成GB18030
	NSString* line = [[NSString alloc] initWithFormat: @"%d,%@,%s,%s\r\n", sqliteID, viewUIDString, key_number, time_1];
                NSStringEncoding enc
                = CFStringConvertEncodingToNSStringEncoding(kCFStringEncodingGB_18030_2000);//编码转换，UTF8转GBK
                const uint8_t *lineStr = (const uint8_t *)[line cStringUsingEncoding:enc];
                NSInteger lineLength = [line lengthOfBytesUsingEncoding:enc];
                result = [output write:lineStr  maxLength: lineLength];

之后用EXCEL就没有问题了，哈哈。