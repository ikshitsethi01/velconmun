<!DOCTYPE html>
<html>
<head>
    <title>Allotment Admin</title>
</head>
<body>

<h2>Run Allotment</h2>

<form method="POST" action="api/add-job.php">
    <label>Committee Code:</label><br>
    <input type="text" name="committeeCode" required><br><br>

    <input type="hidden" name="key" value="SUPER_SECRET_KEY">

    <button type="submit">Run Allotment</button>
</form>

</body>
</html>
