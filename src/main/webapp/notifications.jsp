<%--
  Created by IntelliJ IDEA.
  User: Admin
  Date: 4/26/2026
  Time: 7:45 AM
  To change this template use File | Settings | File Templates.
--%>
<h2>Phản hồi từ Admin</h2>

<c:forEach var="item" items="${listReply}">
  <div style="border:1px solid #ccc; margin:10px; padding:10px;">
    <p><b>Chủ đề:</b> ${item.subject}</p>
    <p><b>Nội dung bạn gửi:</b> ${item.message}</p>
    <p><b>Admin phản hồi:</b> ${item.replyMessage}</p>
    <p><i>${item.replyDate}</i></p>
  </div>
</c:forEach>
