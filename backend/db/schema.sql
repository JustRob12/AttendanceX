-- Drop database if exists (be careful with this in production)
DROP DATABASE IF EXISTS attendancex_db;

-- Create database
CREATE DATABASE attendancex_db;

-- Use the database
USE attendancex_db;

-- Create users table
CREATE TABLE users (
  id INT AUTO_INCREMENT PRIMARY KEY,
  name VARCHAR(100) NOT NULL,
  email VARCHAR(100) NOT NULL UNIQUE,
  password VARCHAR(255) NOT NULL,
  role ENUM('admin', 'user') DEFAULT 'user',
  created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
  updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
);

-- Create attendance records table
CREATE TABLE attendance (
  id INT AUTO_INCREMENT PRIMARY KEY,
  user_id INT NOT NULL,
  check_in DATETIME NOT NULL,
  check_out DATETIME,
  status ENUM('present', 'absent', 'late') DEFAULT 'present',
  note TEXT,
  created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
  updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  FOREIGN KEY (user_id) REFERENCES users(id)
);

-- Create initial admin user (password: admin123)
INSERT INTO users (name, email, password, role) 
VALUES ('Admin User', 'admin@example.com', '$2a$10$yjlJiY/g8h8BkQjIg2.JjOKWRxTSn//RjBxUfJ5MVw5eBMQ8o7IJO', 'admin');

-- Create some test users (password: password123)
INSERT INTO users (name, email, password) 
VALUES 
  ('John Doe', 'john@example.com', '$2a$10$NR6ZXhmxTn7lsZwLjZz6j.NQmACILqQTY7OlZ1eRTvFQneoq4cMZa'),
  ('Jane Smith', 'jane@example.com', '$2a$10$NR6ZXhmxTn7lsZwLjZz6j.NQmACILqQTY7OlZ1eRTvFQneoq4cMZa'); 