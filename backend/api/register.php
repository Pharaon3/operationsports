<?php
// Set headers for CORS and JSON response
header("Access-Control-Allow-Origin: *");
header("Content-Type: application/json; charset=UTF-8");
header("Access-Control-Allow-Methods: POST");
header("Access-Control-Max-Age: 3600");
header("Access-Control-Allow-Headers: Content-Type, Access-Control-Allow-Headers, Authorization, X-Requested-With");

// Include database and user model
include_once '../config/database.php';
include_once '../models/User.php';

// Get database connection
$database = new Database();
$db = $database->getConnection();

// Initialize user object
$user = new User($db);

// Get posted data
$data = json_decode(file_get_contents("php://input"));

// Check if data is not empty
if(!empty($data->username) && !empty($data->password)) {
    
    // Check if username already exists
    if($user->usernameExists($data->username)) {
        // Set response code - 400 Bad Request
        http_response_code(400);
        
        // Tell the user username already exists
        echo json_encode(array(
            "status" => "error",
            "message" => "Username already exists"
        ));
        return;
    }
    
    // Set user property values
    $user->username = $data->username;
    $user->password = $data->password;
    
    // Create the user
    if($user->create()) {
        // Set response code - 201 Created
        http_response_code(201);
        
        // Tell the user user was created
        echo json_encode(array(
            "status" => "success",
            "message" => "User was created successfully"
        ));
    } else {
        // Set response code - 503 Service Unavailable
        http_response_code(503);
        
        // Tell the user user was not created
        echo json_encode(array(
            "status" => "error",
            "message" => "Unable to create user"
        ));
    }
} else {
    // Set response code - 400 Bad Request
    http_response_code(400);
    
    // Tell the user data is incomplete
    echo json_encode(array(
        "status" => "error",
        "message" => "Unable to create user. Data is incomplete."
    ));
}
?> 