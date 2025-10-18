#!/usr/bin/env python3
"""
MySQLServer.py
Creates the 'alx_book_store' database on the MySQL server.
- If the database already exists, the script will NOT fail.
- Does NOT use SELECT or SHOW.
- Prints a success message when the CREATE statement runs.
- Prints error messages if connection/execution fails.
- Properly opens and closes cursor and connection.
"""

import sys
import mysql.connector
from mysql.connector import Error

DB_NAME = "alx_book_store"

def create_database(host="localhost", user="root", password=""):
    connection = None
    cursor = None
    try:
        # Connect to MySQL server (no database selected)
        connection = mysql.connector.connect(
            host=host,
            user=user,
            password=password,
            autocommit=True  # ensure DDL runs without explicit commit
        )

        if not connection.is_connected():
            print("Error: Unable to connect to MySQL server.")
            return

        cursor = connection.cursor()
        # Create database if it does not exist (safe if already present)
        cursor.execute(f"CREATE DATABASE IF NOT EXISTS `{DB_NAME}`")
        # Per requirements, print this message when the CREATE runs successfully
        print(f"Database '{DB_NAME}' created successfully!")

    except Error as err:
        print(f"Error while connecting to MySQL or executing statement: {err}")
    except Exception as ex:
        print(f"Unexpected error: {ex}")
    finally:
        # Close cursor and connection if they were opened
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
    # Replace the password below (or supply via environment variables / external config)
    # Example usage: modify host/user/password as needed before running.
    create_database(host="localhost", user="root", password="your_password_here")
