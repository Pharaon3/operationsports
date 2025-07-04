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
    
    // Set user property values
    $user->username = $data->username;
    $user->password = $data->password;
    
    // Attempt to login
    if($user->login($data->username, $data->password)) {
        // Create response array
        $response = array(
            "status" => "success",
            "message" => "Login successful",
            "user" => array(
                "id" => $user->id,
                "username" => $user->username
            )
        );
        
        // Set response code - 200 OK
        http_response_code(200);
        
        // Tell the user login was successful
        echo json_encode($response);
    } else {
        // Set response code - 401 Unauthorized
        http_response_code(401);
        
        // Tell the user login failed
        echo json_encode(array(
            "status" => "error",
            "message" => "Invalid username or password"
        ));
    }
} else {
    // Set response code - 400 Bad Request
    http_response_code(400);
    
    // Tell the user data is incomplete
    echo json_encode(array(
        "status" => "error",
        "message" => "Unable to login. Data is incomplete."
    ));
}
?> 