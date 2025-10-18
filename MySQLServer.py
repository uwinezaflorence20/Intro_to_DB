
"""
MySQLServer.py
A simple Python script to create the 'alx_book_store' database.
If the database already exists, it will not fail.
"""

import mysql.connector
def create_database():
    try:

        connection = mysql.connector.connect(
            host='localhost',
            user='root',
            password='your_password'  # Replace with your MySQL root password
        )

        if connection.is_connected():
            cursor = connection.cursor()
            cursor.execute("CREATE DATABASE IF NOT EXISTS alx_book_store")
            print("Database 'alx_book_store' created successfully!")

    except mysql.connector.Error as e:
        print(f"Error while connecting to MySQL: {e}")

    finally:
        if connection.is_connected():
            cursor.close()
            connection.close()
    

if __name__ == "__main__":
    create_database()
