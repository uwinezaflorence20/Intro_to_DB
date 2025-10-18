#!/usr/bin/env python3
"""
MySQLServer.py
Creates the 'alx_book_store' database and executes the SQL inside alx_book_store.sql
(alx_book_store.sql should contain only table creation statements, NOT CREATE DATABASE).
"""

import os
import mysql.connector
from mysql.connector import Error

SQL_FILE = "alx_book_store.sql"
DB_NAME = "alx_book_store"

def read_sql_file(path):
    with open(path, "r", encoding="utf-8") as f:
        return f.read()

def execute_sql_script(cursor, sql_script):
    """
    Execute SQL script which may contain multiple statements separated by ';'.
    Uses cursor.execute(..., multi=True) to run multi-statement scripts.
    """
    for result in cursor.execute(sql_script, multi=True):
        # We avoid using SELECT/SHOW. We also don't need to fetch results.
        # The loop ensures all statements are executed.
        pass

def create_database_and_tables(host="localhost", user="root", password=""):
    connection = None
    cursor = None
    try:
        # 1) Connect to MySQL server (no database specified)
        connection = mysql.connector.connect(
            host=host,
            user=user,
            password=password,
            autocommit=True  # avoid needing explicit commit for CREATE DATABASE
        )

        if not connection.is_connected():
            raise Error("Failed to connect to MySQL server.")

        cursor = connection.cursor()
        # Create database if it doesn't exist (safe if it already exists)
        cursor.execute(f"CREATE DATABASE IF NOT EXISTS `{DB_NAME}`")
        print(f"Database '{DB_NAME}' created successfully!")

        # Close this cursor/connection and reconnect to the new database
        cursor.close()
        connection.close()

        # 2) Reconnect specifying the database to run table creation scripts
        connection = mysql.connector.connect(
            host=host,
            user=user,
            password=password,
            database=DB_NAME
        )
        if not connection.is_connected():
            raise Error(f"Failed to connect to MySQL database '{DB_NAME}'.")

        cursor = connection.cursor()
        # Read SQL file
        if not os.path.isfile(SQL_FILE):
            raise FileNotFoundError(f"SQL file '{SQL_FILE}' not found in current directory.")

        sql_script = read_sql_file(SQL_FILE)

        # Execute the SQL script (multi-statement)
        execute_sql_script(cursor, sql_script)
        connection.commit()

        print("SQL script executed successfully — tables should be created (Authors, Books, Customers, Orders, Order_Details).")

    except FileNotFoundError as fnf:
        print(f"File error: {fnf}")
    except Error as e:
        print(f"Error while connecting to MySQL or executing SQL: {e}")
    except Exception as ex:
        print(f"Unexpected error: {ex}")
    finally:
        # Clean up: close cursor and connection if open
        try:
            if cursor is not None:
                cursor.close()
        except Exception:
            pass
        try:
            if connection is not None and connection.is_connected():
                connection.close()
        except Exception:
            pass

if __name__ == "__main__":
    # Replace password argument or set to empty to prompt change in script
    # You can also wrap this call to read credentials from environment variables if desired.
    create_database_and_tables(
        host="localhost",
        user="root",
        password="your_password_here"  # <-- replace with your MySQL password
    )
