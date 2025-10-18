-- task_4.sql
-- Prints full description of the table 'Books' in alx_book_store

SELECT 
    COLUMN_NAME AS ColumnName,
    COLUMN_TYPE AS ColumnType,
    IS_NULLABLE AS IsNullable,
    COLUMN_KEY AS ColumnKey,
    COLUMN_DEFAULT AS DefaultValue,
    EXTRA AS ExtraInfo
FROM INFORMATION_SCHEMA.COLUMNS
WHERE TABLE_SCHEMA = DATABASE()
  AND TABLE_NAME = 'Books'
ORDER BY ORDINAL_POSITION;
