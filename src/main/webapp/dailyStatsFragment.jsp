<%@ page contentType="text/html;charset=UTF-8" language="java"%>
<%@ taglib prefix="c" uri="jakarta.tags.core"%>
<%@ taglib prefix="fmt" uri="jakarta.tags.fmt"%>

<div
	style="display: flex; justify-content: space-between; align-items: center; margin-bottom: 25px; background: #f8f9fa; padding: 15px 20px; border-radius: 12px; border: 1px solid #e9ecef; box-shadow: 0 2px 4px rgba(0, 0, 0, 0.02);">

	<button onclick="loadMonth(${prevMonth}, ${prevYear})"
		style="background: white; border: 1px solid #ddd; padding: 8px 16px; border-radius: 20px; cursor: pointer; transition: all 0.2s; color: #555; font-weight: 600; display: flex; align-items: center; gap: 5px;">
		<i class="fas fa-chevron-left"></i> <span style="font-size: 13px;">T${prevMonth}</span>
	</button>

	<div
		style="text-align: center; display: flex; flex-direction: column; align-items: center; gap: 8px;">

		<h3
			style="margin: 0; color: #2d7e7e; text-transform: uppercase; font-size: 18px; font-weight: 700;">
			<i class="fas fa-calendar-alt"></i> THÁNG ${selectedMonth} /
			${selectedYear}
		</h3>

		<a
			href="exportRevenueStats?month=${selectedMonth}&year=${selectedYear}"
			style="text-decoration: none;">
			<button
				style="background-color: #107c41; color: white; border: none; padding: 5px 12px; border-radius: 4px; cursor: pointer; font-size: 12px; font-weight: 600; display: flex; align-items: center; gap: 5px; box-shadow: 0 2px 4px rgba(0, 0, 0, 0.1); transition: transform 0.2s;">
				<i class="fas fa-file-excel"></i> Tải báo cáo tháng này
			</button>
		</a>

	</div>

	<button onclick="loadMonth(${nextMonth}, ${nextYear})"
		style="background: white; border: 1px solid #ddd; padding: 8px 16px; border-radius: 20px; cursor: pointer; transition: all 0.2s; color: #555; font-weight: 600; display: flex; align-items: center; gap: 5px;">
		<span style="font-size: 13px;">T${nextMonth}</span> <i
			class="fas fa-chevron-right"></i>
	</button>
</div>

<c:if test="${empty dailyStats}">
	<div class="no-data-message"
		style="padding: 40px; text-align: center; color: #999;">
		<i class="fas fa-search"
			style="font-size: 48px; margin-bottom: 15px; display: block; opacity: 0.5;"></i>
		<p>Tháng ${selectedMonth}/${selectedYear} chưa có doanh thu nào.</p>
	</div>
</c:if>

<c:if test="${not empty dailyStats}">
	<div class="revenue-table-container">
		<table class="revenue-table">
			<thead>
				<tr>
					<th style="width: 80px; text-align: center;">Ngày</th>
					<th style="width: 150px;">Số đơn hàng</th>
					<th style="width: 200px;">Doanh thu</th>
					<th>Hiệu suất ngày</th>
				</tr>
			</thead>
			<tbody>
				<c:set var="maxDailyRev" value="${0.0}" />
				<c:forEach items="${dailyStats}" var="day">
					<c:if test="${day.revenue > maxDailyRev}">
						<c:set var="maxDailyRev" value="${day.revenue}" />
					</c:if>
				</c:forEach>

				<c:set var="prevRevenue" value="${0.0}" />

				<c:forEach items="${dailyStats}" var="d" varStatus="loop">
					<tr style="border-bottom: 1px solid #f0f0f0;">

						<td style="padding: 15px; text-align: center;">
							<div
								style="background: #2d7e7e; color: white; width: 35px; height: 35px; border-radius: 50%; display: flex; align-items: center; justify-content: center; font-weight: bold; margin: 0 auto; box-shadow: 0 3px 6px rgba(45, 126, 126, 0.3);">
								${d.day}</div>
						</td>

						<td style="padding: 15px;"><span
							style="font-weight: 600; font-size: 14px; color: #555;"> <i
								class="fas fa-shopping-bag"
								style="color: #f39c12; margin-right: 5px;"></i> ${d.orderCount}
								đơn
						</span></td>

						<td style="padding: 15px;">
							<div
								style="font-size: 16px; font-weight: 700; color: #333; margin-bottom: 5px;">
								<fmt:formatNumber value="${d.revenue}" type="currency"
									currencySymbol="₫" />
							</div> <c:choose>
								<c:when test="${loop.first}">
									<span class="trend-badge trend-flat"><i
										class="fas fa-minus"></i> Khởi đầu</span>
								</c:when>
								<c:when test="${d.revenue > prevRevenue}">
									<span class="trend-badge trend-up"><i
										class="fas fa-arrow-up"></i> Tăng trưởng</span>
								</c:when>
								<c:when test="${d.revenue < prevRevenue}">
									<span class="trend-badge trend-down"><i
										class="fas fa-arrow-down"></i> Sụt giảm</span>
								</c:when>
								<c:otherwise>
									<span class="trend-badge trend-flat"><i
										class="fas fa-equals"></i> Giữ mức</span>
								</c:otherwise>
							</c:choose>
						</td>

						<td style="padding: 15px; width: 30%;"><c:set var="percent"
								value="${maxDailyRev > 0 ? (d.revenue / maxDailyRev * 100) : 0}" />
							<c:set var="barColor" value="bg-warning-gradient" /> <c:if
								test="${percent >= 80}">
								<c:set var="barColor" value="bg-success-gradient" />
							</c:if> <c:if test="${percent < 30}">
								<c:set var="barColor" value="bg-danger-gradient" />
							</c:if>

							<div class="progress-container">
								<div class="progress-bar-fill ${barColor}"
									style="width: ${percent}%;"></div>
							</div>
							<div
								style="text-align: right; font-size: 11px; color: #888; font-style: italic;">
								Đạt
								<fmt:formatNumber value="${percent}" maxFractionDigits="0" />
								% đỉnh tháng
							</div></td>
					</tr>
					<c:set var="prevRevenue" value="${d.revenue}" />
				</c:forEach>
			</tbody>
		</table>
	</div>
</c:if>