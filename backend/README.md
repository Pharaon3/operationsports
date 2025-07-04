# PHP Backend Server for OperationSports

A simple PHP backend server with MySQL database for user authentication.

## Features

- User registration and login
- Plain text password storage (no hashing)
- MySQL database integration
- RESTful API endpoints
- CORS support for cross-origin requests
- JSON responses

## Requirements

- PHP 7.4 or higher
- MySQL 5.7 or higher
- Web server (Apache/Nginx) or PHP built-in server

## Setup Instructions

### 1. Database Setup

1. Create a MySQL database and import the setup script:
```bash
mysql -u root -p < database/setup.sql
```

Or manually create the database and table:
```sql
CREATE DATABASE operationsports;
USE operationsports;

CREATE TABLE users (
    id INT AUTO_INCREMENT PRIMARY KEY,
    username VARCHAR(50) UNIQUE NOT NULL,
    password VARCHAR(255) NOT NULL,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
);
```

### 2. Configuration

Update the database connection settings in `config/database.php`:
```php
private $host = "localhost";
private $db_name = "operationsports";
private $username = "your_mysql_username";
private $password = "your_mysql_password";
```

### 3. Start the Server

Using PHP's built-in server:
```bash
cd backend
php -S localhost:8000
```

Or configure your web server (Apache/Nginx) to point to the backend directory.

## API Endpoints

### POST /api/login

Authenticate a user with username and password.

**Request Body:**
```json
{
    "username": "testuser",
    "password": "test123"
}
```

**Success Response (200):**
```json
{
    "status": "success",
    "message": "Login successful",
    "user": {
        "id": 1,
        "username": "testuser"
    }
}
```

**Error Response (401):**
```json
{
    "status": "error",
    "message": "Invalid username or password"
}
```

### POST /api/register

Register a new user.

**Request Body:**
```json
{
    "username": "newuser",
    "password": "newpassword"
}
```

**Success Response (201):**
```json
{
    "status": "success",
    "message": "User was created successfully"
}
```

**Error Response (400):**
```json
{
    "status": "error",
    "message": "Username already exists"
}
```

## Testing

### Using cURL

**Login:**
```bash
curl -X POST http://localhost:8000/api/login \
  -H "Content-Type: application/json" \
  -d '{"username":"testuser","password":"test123"}'
```

**Register:**
```bash
curl -X POST http://localhost:8000/api/register \
  -H "Content-Type: application/json" \
  -d '{"username":"newuser","password":"newpassword"}'
```

### Using Postman

1. Set the request method to POST
2. Set the URL to `http://localhost:8000/api/login` or `http://localhost:8000/api/register`
3. Set the Content-Type header to `application/json`
4. Add the request body in JSON format

## Security Features

- SQL injection prevention using prepared statements
- Input sanitization
- CORS headers for cross-origin requests
- Proper HTTP status codes
- **Note: Passwords are stored in plain text (no hashing)**

## File Structure

```
backend/
├── config/
│   └── database.php          # Database connection configuration
├── models/
│   └── User.php              # User model with database operations
├── api/
│   ├── login.php             # Login endpoint
│   └── register.php          # Registration endpoint
├── database/
│   └── setup.sql             # Database setup script
└── README.md                 # This file
```

## Default Test User

The setup script creates a test user:
- Username: `testuser`
- Password: `test123`

You can use these credentials to test the login functionality. 