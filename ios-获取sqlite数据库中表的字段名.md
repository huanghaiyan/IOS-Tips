###iOS-获取SQLite数据库中表的字段名

	NSString *path = [[[NSBundle mainBundle] bundlePath]stringByAppendingPathComponent:@"branddb.sqlite"];
    
    sqlite3 *database;
    sqlite3_open([path UTF8String], &database);
    
    sqlite3_stmt *statement;

    const char *getColumn = "PRAGMA table_info(menu)";
    sqlite3_prepare_v2(database, getColumn, -1, &statement, nil);
    while (sqlite3_step(statement) == SQLITE_ROW) {
        char *nameData = (char *)sqlite3_column_text(statement, 1);
        NSString *columnName = [[NSString alloc] initWithUTF8String:nameData];
        NSLog(@"columnName:%@",columnName);
    }
    
    sqlite3_finalize(statement);
   
注：当前代码查询的是 menu表的字段名