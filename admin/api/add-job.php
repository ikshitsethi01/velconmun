<?php

$secret = "24053108VELCONADVIKJHAMBSMALLHEIGHT";

$key = $_POST["key"] ?? $_GET["key"] ?? null;
$committeeCode = $_POST["committeeCode"] ?? $_GET["committeeCode"] ?? null;

if ($key !== $secret) {
    http_response_code(401);
    exit("Unauthorized");
}

if (!$committeeCode) {
    exit("No committee code");
}

file_put_contents("job.txt", $committeeCode);

echo "Job stored";
