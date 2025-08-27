-- AKS Demo Database Initialization Script
-- This script sets up the complete database structure for the AKS demo application
-- Database: testdb (used by Backend application)
-- User: testuser (with full permissions)

-- Create database if not exists
CREATE DATABASE IF NOT EXISTS testdb;
USE testdb;

-- Create users table for user authentication
CREATE TABLE IF NOT EXISTS users (
    id INT AUTO_INCREMENT PRIMARY KEY,
    username VARCHAR(255) UNIQUE NOT NULL,
    password VARCHAR(255) NOT NULL,
    created_at DATETIME DEFAULT CURRENT_TIMESTAMP
);

-- Create messages table for user messages
CREATE TABLE IF NOT EXISTS messages (
    id INT AUTO_INCREMENT PRIMARY KEY,
    message TEXT NOT NULL,
    user_id VARCHAR(255),
    created_at DATETIME DEFAULT CURRENT_TIMESTAMP
);

-- Create testuser account if not exists
CREATE USER IF NOT EXISTS 'testuser'@'%' IDENTIFIED BY '9lx8GPzdPK';

-- Grant all privileges on testdb to testuser
GRANT ALL PRIVILEGES ON testdb.* TO 'testuser'@'%';

-- Apply privileges
FLUSH PRIVILEGES;

-- Show final status
SELECT 'Database setup completed successfully!' as Status;
SHOW DATABASES LIKE 'testdb';
SHOW TABLES;
SHOW GRANTS FOR 'testuser'@'%'; 