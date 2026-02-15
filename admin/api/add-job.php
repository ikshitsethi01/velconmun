<?php

$secret = "24053108VELCONADVIKJHAMBSMALLHEIGHT";

if ($_POST["key"] !== $secret) {
    http_response_code(401);
    exit("Unauthorized");
}

$committeeCode = $_POST["committeeCode"];

if (!$committeeCode) {
    exit("No committee code");
}

file_put_contents("job.txt", $committeeCode);

echo "Job stored";
