###iOS-数据库SQLite的数据导出到CSV文件

CSV全称 Comma Separated values，是一种用来存储数据的纯文本文件格式，通常用于电子表格或数据库软件。用Excel或者Numbers都可以导出CSV格式的数据。

CSV是一种简单的数据文件交换方式，体积小、操作占用内存小、 生成速度快、行数无限制。
在一般情况下比Excel 更为简单方便，　导出文件是首选。

	CSV 的基本规则：
	
	1.开头是不留空，以行为单位。
	2.可含或不含列名，含列名则居文件第一行。
	3.一行数据不跨行，无空行。
	4.以半角逗号（即,）作分隔符，列为空也要表达其存在。
	5.列内容如存在半角逗号（即,）则用半角双引号（即""）将该字段值包含起来。
	6.列内容如存在半角引号（即"）则应替换成半角双引号（""）转义，并用半角引号（即""）将该字段值包含起来。
	7.文件读写时引号，逗号操作规则互逆。
	8.内码格式不限，可为 ASCII、Unicode 或者其他。
	9.不支持特殊字符

知道了CSV的基本规则，你是否有思路了呢？

实现思路：

1、我们知道sqlite数据表里面的列名，首先把sqlite的列名写入表头。

2、其次是读取sqlite的每一行的数据。sqlite3_step(compiledStatement) == SQLITE_ROW
我们把读取出来的数据，拼接成如：NSString* line = [[NSString alloc] initWithFormat: @"%d,%@,%s,%s\r\n", sqliteID, viewUIDString, key_number, time_1];写到我们的CSV文件里面。记得使用“\r\n”进行换行，我在mas os上面使用"\n"，在Windows上打开CSV文件却没进行换行。

简单介绍一下

\n是换行，英文是New line，表示使光标到行首

\r是回车，英文是Carriage return，表示使光标下移一格

\r\n表示回车换行

1、\n 软回车：

在Windows 中表示换行且回到下一行的最开始位置。相当于Mac OS 里的 \r 的效果。
在Linux、unix 中只表示换行，但不会回到下一行的开始位置。

2、\r 软空格：

在Linux、unix 中表示返回到当行的最开始位置。
在Mac OS 中表示换行且返回到下一行的最开始位置，相当于Windows 里的 \n 的效果。

	//导出csv文件
	- (void)exportCSV:(NSString*) filename
	{
    	[self openDb];
    
    	NSOutputStream* output = [[NSOutputStream alloc] initToFileAtPath: filename append: YES];
    	[output open];
    
    	if (![output hasSpaceAvailable]) {
        	NSLog(@"No space available in %@", filename);
        	// TODO: UIAlertView?
    	} else {
        
        	NSString* header = @"id,ViewUID,key_number,time_1\r\n";
        	const uint8_t *headerStr = (const uint8_t *)[header cStringUsingEncoding:NSUTF8StringEncoding];
        	NSInteger result = [output write: headerStr maxLength: [header length]];
        	if (result <= 0) {
            	NSLog(@"exportCsv encountered error=%d from header write", result);
        	}
        
        	NSString* sqlStatement = @"select id,ViewUID,key_number,time_1 from UMAnlyticsTable";
        	// Setup the SQL Statement and compile it for faster access
        	sqlite3_stmt* compiledStatement;
        	if (sqlite3_prepare_v2(db, [sqlStatement UTF8String], -1, &compiledStatement, NULL) == SQLITE_OK)
        	{
            	// Loop through the results and write them to the CSV file
            	while (sqlite3_step(compiledStatement) == SQLITE_ROW) {
                	// Read the data from the result row
                	int sqliteID = (int)sqlite3_column_int(compiledStatement, 0);
                	char *viewUID = (char *)sqlite3_column_text(compiledStatement, 1);
                	char *key_number = (char *)sqlite3_column_text(compiledStatement, 2);
                	char *time_1 = (char *)sqlite3_column_text(compiledStatement, 3);
                	NSString *viewUIDString = [[NSString alloc] initWithUTF8String:viewUID];
                	NSString* line = [[NSString alloc] initWithFormat: @"%d,%@,%s,%s\r\n", sqliteID, viewUIDString, key_number, time_1];
                	NSStringEncoding enc
                	= CFStringConvertEncodingToNSStringEncoding(kCFStringEncodingGB_18030_2000);//编码转换，UTF8转GBK
                	const uint8_t *lineStr = (const uint8_t *)[line cStringUsingEncoding:enc];
                	NSInteger lineLength = [line lengthOfBytesUsingEncoding:enc];
                	result = [output write:lineStr  maxLength: lineLength];
                	if (result <= 0) {
                    	NSLog(@"exportCsv encountered error=%d from header write", result);
                	}
            	}
    
            	// Release the compiled statement from memory
            	sqlite3_finalize(compiledStatement);
        	}
    	}
    	[output close];
    	[self closeDb];
    
	}
