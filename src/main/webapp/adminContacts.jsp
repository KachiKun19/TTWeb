<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<%@ taglib prefix="fmt" uri="jakarta.tags.fmt" %>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Quản Lý Liên Hệ - Kachi-Kun Shop</title>
    <link rel="icon" type="image/png" href="images/LogoRemake.png"/>
    <link rel="stylesheet" href="css/Admin.css"/>
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.2/css/all.min.css"/>
    <link href="https://fonts.googleapis.com/css2?family=Montserrat:wght@300;400;600;700&display=swap" rel="stylesheet">

    <style>
        .table-responsive {
            background: white;
            border-radius: 12px;
            box-shadow: 0 1px 3px rgba(0,0,0,.08);
            overflow-x: auto;
            padding: 0 0 10px;
        }

        .table-responsive table {
            width: 100%;
            border-collapse: collapse;
        }

        .table-responsive td {
            padding: 14px 16px;
            border-bottom: 1px solid #f1f5f9;
            vertical-align: middle;
            color: #334155;
            font-size: 14px;
        }

        .table-responsive tr:hover td {
            background-color: #f8f9ff;
        }

        .sender-name {
            font-weight: 600;
            color: #1e293b;
        }

        .sender-sub {
            font-size: 12px;
            color: #94a3b8;
            margin-top: 2px;
        }

        .message-preview {
            max-width: 280px;
            white-space: nowrap;
            overflow: hidden;
            text-overflow: ellipsis;
            color: #64748b;
        }

        .status-badge {
            padding: 4px 12px;
            border-radius: 20px;
            font-size: 11px;
            font-weight: 700;
            display: inline-block;
            letter-spacing: .3px;
            text-transform: uppercase;
        }

        .status-unread {
            background-color: #fff1f2;
            color: #e11d48;
            border: 1px solid #fecdd3;
        }

        .status-read {
            background-color: #f0fdf4;
            color: #16a34a;
            border: 1px solid #bbf7d0;
        }

        .status-replied {
            background-color: #eff6ff;
            color: #2563eb;
            border: 1px solid #bfdbfe;
        }

        .action-row {
            display: flex;
            gap: 6px;
            flex-wrap: wrap;
            margin-top: 6px;
        }

        /* Modal */
        .modal-overlay {
            display: none;
            position: fixed;
            inset: 0;
            background: rgba(15,23,42,.55);
            z-index: 1000;
            align-items: center;
            justify-content: center;
            padding: 20px;
        }

        .modal-overlay.open {
            display: flex;
        }

        .modal {
            background: white;
            border-radius: 16px;
            width: 100%;
            max-width: 540px;
            box-shadow: 0 20px 60px rgba(0,0,0,.25);
            max-height: 90vh;
            overflow-y: auto;
        }

        .modal-header {
            padding: 20px 24px;
            display: flex;
            justify-content: space-between;
            align-items: center;
        }

        .modal-header h3 {
            font-size: 17px;
            font-weight: 700;
            color: white;
        }

        .modal-close {
            background: rgba(255,255,255,.2);
            border: none;
            color: white;
            width: 30px;
            height: 30px;
            border-radius: 50%;
            font-size: 18px;
            cursor: pointer;
            display: flex;
            align-items: center;
            justify-content: center;
            line-height: 1;
            transition: background .2s;
        }

        .modal-close:hover { background: rgba(255,255,255,.35); }

        .modal-body {
            padding: 20px 24px;
        }

        .info-row {
            display: flex;
            gap: 8px;
            margin-bottom: 8px;
            font-size: 14px;
        }

        .info-label {
            font-weight: 600;
            color: #475569;
            min-width: 90px;
        }

        .info-value {
            color: #1e293b;
        }

        .message-box {
            background: #f8fafc;
            border: 1px solid #e2e8f0;
            border-radius: 8px;
            padding: 14px;
            margin: 14px 0;
            color: #475569;
            font-size: 14px;
            line-height: 1.6;
            white-space: pre-wrap;
        }

        .reply-textarea {
            width: 100%;
            height: 100px;
            padding: 12px;
            border: 1px solid #e2e8f0;
            border-radius: 8px;
            font-family: inherit;
            font-size: 14px;
            resize: vertical;
            outline: none;
            transition: border-color .2s;
        }

        .reply-textarea:focus {
            border-color: #6366f1;
            box-shadow: 0 0 0 3px rgba(99,102,241,.1);
        }

        .modal-footer {
            padding: 0 24px 20px;
            display: flex;
            gap: 10px;
            justify-content: flex-end;
        }

        .btn-cancel {
            padding: 9px 20px;
            border: 1px solid #e2e8f0;
            background: white;
            border-radius: 8px;
            color: #64748b;
            font-family: inherit;
            font-weight: 600;
            font-size: 13px;
            cursor: pointer;
            transition: background .2s;
        }

        .btn-cancel:hover { background: #f8fafc; }
    </style>
</head>
<body>
<c:if test="${empty user or user.role ne 1}">
    <c:redirect url="login"/>
</c:if>
<c:set var="activePage" value="contacts" scope="request"/>
<jsp:include page="componentsAdmin/headerAdmin.jsp"/>

<div class="admin-container">
    <jsp:include page="componentsAdmin/sidebarAdmin.jsp"/>

    <div class="main-content">
        <div class="page-header">
            <h2><i class="fas fa-envelope-open-text"></i> Hộp thư Liên hệ</h2>
        </div>

        <div class="table-responsive">
            <table>
                <thead>
                <tr>
                    <th style="width:50px;">ID</th>
                    <th style="width:20%;">Người gửi</th>
                    <th style="width:15%;">Chủ đề</th>
                    <th>Nội dung</th>
                    <th style="width:140px;">Thời gian</th>
                    <th style="width:160px;">Trạng thái</th>
                </tr>
                </thead>
                <tbody>
                <c:choose>
                    <c:when test="${empty messages}">
                        <tr>
                            <td colspan="6" style="text-align:center; padding:50px; color:#94a3b8;">
                                <i class="fas fa-inbox" style="font-size:3rem; display:block; margin-bottom:12px;"></i>
                                Chưa có tin nhắn liên hệ nào!
                            </td>
                        </tr>
                    </c:when>
                    <c:otherwise>
                        <c:forEach items="${messages}" var="msg">
                            <tr>
                                <td style="text-align:center; font-weight:600; color:#94a3b8;">#${msg.id}</td>
                                <td>
                                    <div class="sender-name">${msg.fullName}</div>
                                    <div class="sender-sub"><i class="fas fa-envelope" style="font-size:10px;"></i> ${msg.email}</div>
                                    <c:if test="${not empty msg.phone}">
                                        <div class="sender-sub"><i class="fas fa-phone" style="font-size:10px;"></i> ${msg.phone}</div>
                                    </c:if>
                                </td>
                                <td style="font-weight:600; color:#334155;">${msg.subject}</td>
                                <td>
                                    <div class="message-preview" title="${msg.message}">${msg.message}</div>
                                </td>
                                <td style="font-size:13px; color:#64748b;">
                                    <i class="far fa-clock"></i>
                                    <fmt:formatDate value="${msg.createdAt}" pattern="dd/MM/yyyy HH:mm"/>
                                </td>
                                <td>
                                    <c:choose>
                                        <c:when test="${msg.status == 'Chưa đọc'}">
                                            <span class="status-badge status-unread"><i class="fas fa-circle" style="font-size:7px;"></i> Chưa đọc</span>
                                        </c:when>
                                        <c:when test="${msg.status == 'Đã xem'}">
                                            <span class="status-badge status-read"><i class="fas fa-circle" style="font-size:7px;"></i> Đã xem</span>
                                        </c:when>
                                        <c:otherwise>
                                            <span class="status-badge status-replied"><i class="fas fa-circle" style="font-size:7px;"></i> Đã trả lời</span>
                                        </c:otherwise>
                                    </c:choose>
                                    <div class="action-row">
                                        <c:if test="${msg.status == 'Chưa đọc'}">
                                            <a href="adminContacts?action=markRead&id=${msg.id}" class="btn-action">
                                                <i class="fas fa-check"></i> Xử lý
                                            </a>
                                        </c:if>
                                        <a href="javascript:void(0)" class="btn-action"
                                           onclick="openModal('${msg.id}','${msg.fullName}','${msg.email}',`${msg.message}`)">
                                            <i class="fas fa-reply"></i> Trả lời
                                        </a>
                                    </div>
                                </td>
                            </tr>
                        </c:forEach>
                    </c:otherwise>
                </c:choose>
                </tbody>
            </table>
        </div>
    </div>
</div>

<!-- Modal phản hồi -->
<div class="modal-overlay" id="modalOverlay">
    <div class="modal">
        <div class="modal-header">
            <h3><i class="fas fa-reply"></i> Trả lời tin nhắn</h3>
            <button class="modal-close" onclick="closeModal()">&times;</button>
        </div>
        <div class="modal-body">
            <div class="info-row"><span class="info-label">Người gửi:</span><span class="info-value" id="modalName"></span></div>
            <div class="info-row"><span class="info-label">Email:</span><span class="info-value" id="modalEmail"></span></div>
            <div class="message-box" id="modalMessage"></div>
            <form action="adminReply" method="post" id="replyForm">
                <input type="hidden" name="id" id="replyId">
                <label style="font-size:13px; font-weight:600; color:#475569; display:block; margin-bottom:8px;">Nội dung phản hồi:</label>
                <textarea name="reply" class="reply-textarea" placeholder="Nhập phản hồi cho khách..." required></textarea>
                <div class="modal-footer" style="padding:12px 0 0;">
                    <button type="button" class="btn-cancel" onclick="closeModal()">Hủy</button>
                    <button type="submit" class="btn-action" style="padding:9px 20px; border:none; font-size:13px;">
                        <i class="fas fa-paper-plane"></i> Gửi phản hồi
                    </button>
                </div>
            </form>
        </div>
    </div>
</div>

<script>
    function openModal(id, name, email, message) {
        document.getElementById('modalName').textContent = name;
        document.getElementById('modalEmail').textContent = email;
        document.getElementById('modalMessage').textContent = message;
        document.getElementById('replyId').value = id;
        document.getElementById('modalOverlay').classList.add('open');
    }

    function closeModal() {
        document.getElementById('modalOverlay').classList.remove('open');
    }

    document.getElementById('modalOverlay').addEventListener('click', function(e) {
        if (e.target === this) closeModal();
    });
</script>
</body>
</html>
