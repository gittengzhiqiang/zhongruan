<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/pages/admin/common/admin_meta.jsp" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
    <title>易食客后台管理系统</title>
</head>
<body class="sub-page">
<div class="page-header">
    <div class="page-title">
        <h3>用户管理</h3>
    </div>
</div>
<div class="breadcrumb-line">
    <ul class="breadcrumb">
        <li><a class="active">用户管理</a></li>
    </ul>
</div>
<form class="form-inline tab-pane" role="form" id="listForm" name="listForm" action="<s:url value="/admin/systemUserList.do" includeParams='none'/>" method="post">
<div class="block search">
    <a href="<s:url value="/admin/systemUserAddPage.do" includeParams='none'/>" class="btn btn-default pull-right">
        <span class="fa fa-plus fa-lg"></span> 添加用户
    </a>
</div>
<div class="block">
    <div class="datatable-tasks">
        <table class="table table-bordered">
            <thead>
            <tr>
                <th class="sq-city">序号</th>
                <th class="sq-center">用户名称</th>
                <th class="sq-action">操作</th>
            </tr>
            </thead>
            <tbody>
            <s:if test="pagination.hasData == true">
            <s:iterator value="pagination.dataList" status="rowstatus">
            <tr>
                <td class="task-desc">
                	<s:property value="id"/>
                </td>
                <td class="task-desc">
                    <s:property value="userName"/>
                </td>
                <td class="text-center">
                    <div class="btn-group">
                        <button type="button" class="btn btn-default" onclick="updateSystemUser(<s:property value="id"/>)">
                        	<i class="fa fa-pencil fa-lg"></i> 修改
                        </button>
                        <button type="button" class="btn btn-default" onclick="delSystemUser(<s:property value="id"/>)">
                        	<i class="fa fa-trash-o fa-lg"></i> 删除
                        </button>
                    </div>
                </td>
            </tr>
            </s:iterator>
            </s:if>
            <s:else>
				<tr>
					<td colspan="3" align="center">没有搜索到符合条件的记录，请重新搜索！</td>
				</tr>
			</s:else>
            </tbody>
        </table>
        <!-- 分页 [页数为1页时也显示] -->
		<s:if test="pagination.pageCount > 0">
		<div align="right">
			<s:include value="/pages/admin/common/pagination.jsp"></s:include>
		</div>
        </s:if>
    </div>
</div>
</form>
<form id="delForm" name="delForm" action="<s:url value="/admin/systemUserDelete.do" includeParams='none'/>" method="post">
	<input type="hidden" id="id" name="systemUserInfo.id"/>
</form>
<!-- /page tabs --> 

<!-- Footer -->
<s:include value="/pages/admin/common/footer.jsp"></s:include>
<!-- /Footer -->
</body>
<script language=javascript>
	$(function(){
		var message = "<s:property value='message'/>";
		if(message != null && message != ""){
			$("#memberId").val("");
			top.dialog_alert(message);
		}
	});

	function updateSystemUser(userId){
		window.location="<s:url value='/admin/systemUserUpdatePage.do' />?systemUserInfo.id=" + userId;
	}
	
	function delSystemUser(userId){
		top.dialog_confirm("您确认删除该用户吗？", 
			function(){
			var param = {"id":userId};
			var act = "<s:url value='/admin/systemUserDelete.do' includeParams='none'/>";
		    $.ajax({
				type:"post",
				url:act,
				data:param,
				cache:false,
				success: function(msg) {
					if (msg == "success"){
						location.href='<s:url value="/admin/systemUserList.do" includeParams="none"/>';
		        	} else {
		        		top.dialog_alert(msg);
		        	}
		        }
			});
		});
	}
</script>
</html>