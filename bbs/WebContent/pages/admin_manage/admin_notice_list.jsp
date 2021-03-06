<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="/WEB-INF/c.tld" %>
<%@ taglib prefix="fn" uri="/WEB-INF/fn.tld" %>
<%@ include file="/comm/jsp/common.jsp"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<title>后台管理_公告列表</title>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<script type="text/javascript" src="js/admin_manage/admin_notice_list.js"></script>
<style type="text/css">
body{
	border: 1px solid #87CEEB;
}

#list td{
	font-size: 13px;
	border-top: 1px dashed #B0C4DE;
	vertical-align: middle;
	padding-top: 5px;
	padding-bottom: 2px;
}

.bg_tr_1{
	background-color:#FF8C00;
}

.bg_tr_2{
	background-color:#FF8C00;
}

.bg_tr{
	background-color: #F0F8FF;
}

th{
	font-size: 15px;
	color: #4169E1;
	background-color: white;
	font-weight: bolder;
}
a:visited{
	color:blue;
}
</style>
<script type="text/javascript">
		$(document).ready(function(){
			$('#list tr:even').addClass("bg_tr");
		});
</script>
</head>
<body>
<div style="width: 100%;height: 100%">
	<table style="width: 90%;font-size: 15px;margin:20px; font-weight: bolder">
		<tr>
			<td>
				<img src="images/anc.png">&nbsp;&nbsp;公告列表
				&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
				<img alt="添加公告" src="images/add_note.gif">&nbsp;&nbsp;
				<a href="/bbs/admin/admin_notice_add.action" style="font-size: 13px;">添加公告</a>
				&nbsp;&nbsp;&nbsp;&nbsp;
				<img alt="刷新列表" src="images/action_refresh.gif">&nbsp;&nbsp;
				<a href="javaScript:document.execCommand('Refresh')" style="font-size: 13px;">刷新列表</a>
			</td>
		</tr>
	</table>
	
	<c:choose>
		<c:when test="${notices.totalCount=='0'}">
			<table style="width: 90%;margin:20px;">
				<tr>
					<td>
						<font style="font-size: 13px;color: red;">暂无任何公告</font>
					</td>
				</tr>
			</table>
		</c:when>
		<c:otherwise>
		<table id="list" style="width: 90%;margin:20px;" cellspacing="0">
		<tr>
			<th>序号</th>
			<th>标题</th>
			<th>公告内容</th>
			<th>发布时间</th>
			<th>发布人</th>
			<th style="text-align: center">管理</th>
		</tr>
		<c:set value="1" var="i"/>
			<c:forEach var="noticeVO" items="${notices.items}">
				<tr>
					<td style="color:#4169E1;font-weight: bolder;padding-left: 10px;">
						${i+(pageInfo.currentPage-1)*8}
					</td>
					<td align="left">
						<c:choose>
						<c:when test="${fn:length(noticeVO.title)<=10}">
							&nbsp;${noticeVO.title}"
						</c:when>
						<c:otherwise>
							&nbsp;${fn:substring(noticeVO.title,0,10)}……
						</c:otherwise>
						</c:choose>
					</td>
					<td align="left">
					<a href="admin/notice-viewNotice?noticeVO.id=${noticeVO.id}&currentPage=${pageInfo.currentPage}">
					<c:choose>
						<c:when test="${fn:length(noticeVO.content)<=8}">
							&nbsp;${noticeVO.content}"
						</c:when>
						<c:otherwise>
							&nbsp;${fn:substring(noticeVO.content,0,8)}……
						</c:otherwise>
					</c:choose>
					</a>
					</td>
					<td>&nbsp;${noticeVO.publishtimeStr}</td>
					<td align="left">&nbsp;${noticeVO.publisher}</td>
					<td style="text-align: center;width: 200px">
					<img alt="查看公告" src="images/view_note.gif">
					<a href="admin/notice-viewNotice?noticeVO.id=${noticeVO.id}&currentPage=${pageInfo.currentPage}" onclick="showMask();">查看</a>
					<img alt="删除公告" src="images/delete_note.gif">
					<a href="javaScript:void(0);" onclick="deleteNotice(${noticeVO.id},${pageInfo.currentPage});" onclick="showMask();">删除</a>
					<img alt="修改公告" src="images/edit_note.gif">
					<a href="admin/notice-editNotice?noticeVO.id=${noticeVO.id}&currentPage=${pageInfo.currentPage}" onclick="showMask();">修改</a>
					</td>
				</tr>
				<c:set value="${i+1}" var="i"/>
			</c:forEach>
			</table>
			<!-- 分页工具条 -->
			<table style="width: 90%;margin:20px;font-size: 12px;color: blue">
				<tr>
					<td>
						共${notices.totalCount}条&nbsp;&nbsp;
						每页${pageInfo.itemNums} 条&nbsp;&nbsp;
						本页${pageInfo.currentItemNums} 条&nbsp;&nbsp;
						共${pageInfo.allPages}页
					</td>
					<td align="right">
					<c:choose>
					<c:when test="${pageInfo.currentPage!=1}">
						<img onclick="window.location.href='admin/notice-queryAllNotice?currentPage=1'" src="images/resultset_first.png" alt="第一页" style="cursor: pointer;"/>
						<img onclick="window.location.href='admin/notice-queryAllNotice?currentPage=${pageInfo.currentPage-1}'" src="images/resultset_previous.png" alt="上一页" style="cursor: pointer;"/>
					</c:when>
					</c:choose>
					 第${pageInfo.currentPage}页
					 <c:choose>
						 <c:when test="${pageInfo.currentPage!=pageInfo.allPages}">
							<img onclick="window.location.href='admin/notice-queryAllNotice?currentPage=${pageInfo.currentPage+1}'" src="images/resultset_next.png" alt="下一页" style="cursor: pointer;"/>
						 	<img onclick="window.location.href='admin/notice-queryAllNotice?currentPage=${pageInfo.allPages}'" src="images/resultset_last.png" alt="最后一页" style="cursor: pointer;"/>
						 </c:when>
					 </c:choose>
					</td>
				</tr>
			</table>
		</c:otherwise>
	</c:choose>
</div>
</body>
</html>
