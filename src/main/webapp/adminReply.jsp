<%--
  Created by IntelliJ IDEA.
  User: Admin
  Date: 3/23/2026
  Time: 2:19 AM
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
</head>
<body>
<form action="adminReply" method="post">
    <input type="hidden" name="id" value="${contact.id}">

    <textarea name="reply" required></textarea>

    <button type="submit">Gửi</button>
</form>
</body>
</html>
