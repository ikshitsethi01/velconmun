<?php

$secret = "SUPER_SECRET_KEY";

if ($_GET["key"] !== $secret) {
    http_response_code(401);
    exit("Unauthorized");
}

file_put_contents("job.txt", "");

echo "Cleared";
