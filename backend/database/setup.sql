-- Create database
CREATE DATABASE IF NOT EXISTS operationsports;
USE operationsports;

-- Create users table
CREATE TABLE IF NOT EXISTS users (
    id INT AUTO_INCREMENT PRIMARY KEY,
    username VARCHAR(50) UNIQUE NOT NULL,
    password VARCHAR(255) NOT NULL,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
);

-- Create index on username for faster lookups
CREATE INDEX idx_username ON users(username);

-- Insert a test user (password: test123)
INSERT INTO users (username, password) VALUES 
('testuser', 'test123')
ON DUPLICATE KEY UPDATE username = username; 