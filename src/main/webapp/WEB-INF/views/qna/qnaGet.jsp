<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%
response.setHeader("Cache-Control","no-store");  
response.setHeader("Pragma","no-cache");  
response.setDateHeader("Expires",0);  
if (request.getProtocol().equals("HTTP/1.1"))
        response.setHeader("Cache-Control", "no-cache");
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>모서리</title>
<link rel="stylesheet" href="https://www.w3schools.com/w3css/4/w3.css">
<link rel="stylesheet" href="/css/bootstrap.css">
<link rel="stylesheet" href="/css/qnaGet.css">
</head>
<body>

	<%@ include file="../includes/sidebar.jsp"%>
	
	<script type="text/javascript">
		$(document).ready(function() {
			var content = '${qna.content}';
			
			$('.content').html(content);
			
			var operForm = $('#operForm');
			
			// 목록 버튼 클릭
			$('button[data-oper=list]').on('click', function() {
				operForm.find($('#no')).remove();
				operForm.attr('action', '/qna/qnaList');
				operForm.submit();
			});
			
			// 삭제 버튼 클릭
			$('button[data-oper=delete]').on('click', function() {
				var c = confirm('문의글을 삭제하시겠습니까?\n(※ 답글과 댓글이 모두 삭제됩니다.)');
				
				if(c) {
					operForm.attr('action', '/qna/qnaDelete');
					operForm.attr('method', 'post');
					operForm.submit();	
				} else {
					return false;
				}
			});
			
			// 수정 버튼 클릭
			$('button[data-oper=modify]').on('click', function() {
				operForm.attr('action', '/qna/qnaModify');
				operForm.submit();
			});
			
		});
	</script>
	
	<div class="container" style="margin-left: 22%;">
	
	    <!-- Qna Get Start -->
	    <div class="row" style="margin-top: 70px; margin-bottom: 150px;">
	
	        <div class="col-md-10 col-md-offset-1">
	            <table class="table table-bordered qnaView-table">
	                <tr>
	                    <td class="tbl_header">제목</td>
	                    <td colspan="3"><c:out value="${qna.title }" /></td>
	                </tr>
	                <tr>
	                    <td class="tbl_header">작성자</td>
	                    <td colspan="3"><c:out value="${fn:substring(qna.member_id, 0, 2).concat('*****') }" /></td>
	                </tr>
	                <tr>
	                    <td class="tbl_header">작성일</td>
	                    <td><c:out value="${qna.reg_date }" /></td>
	                    <td class="tbl_header">조회수</td>
	                    <td><c:out value="${qna.hit }" /></td>
	                </tr>
	                <tr>
	                    <td class="content" colspan="4">
	                    </td>
	                </tr>
	            </table>
			</div>
			
			<div class="col-md-10 col-md-offset-1 qna-btn-row">
				<div class="col-md-6">
		            <button type="button" data-oper="list" class="btn btn-default btn-sm" onclick="location.href='/qna/qnaList'">목록</button>
		        </div>
				<div class="col-md-6">
					<!-- 사용자가 회원일 경우 -->
					<c:if test="${user ne null }">
						<!-- 사용자와 작성자가 일치할 경우 -->
						<c:if test="${qna.member_id == user.id }">
				        	<button type="button" data-oper="delete" class="btn btn-default btn-sm">삭제</button>
				        	<button type="button" data-oper="modify" class="btn btn-default btn-sm">수정</button>
			        	</c:if>
		        		<button type="button" class="btn btn-default btn-sm">답변</button>
		        	</c:if>
		        </div>
	        </div>
	        
	        <script type="text/javascript">
	        	$(document).ready(function() {
        			var qna_no = '${qna.no}';
	        		
        			// 등록되어있는 댓글 불러옴
	        		getReply(qna_no);
	        		
	        		// 댓글 등록 버튼
	        		$('.reg_reply').on('click', function () {
	        			var member_id = '${user.id}';
	        			var content = $('#reply_content').val();

	        			var reply = {
	        				qna_no : qna_no,
	        				member_id : member_id,
	        				content : content
	        			};
	        			
	        			if(!content) {
	        				alert('내용을 입력해주세요.');
	        				$('#reply_content').focus();
	        				return false;
	        			}
	        			
	        			var c = confirm('댓글을 등록하시겠습니까?');
	        			
	        			if(c) {
	        				registAndGetReply(reply);
	        			} else {
	        				return false;
	        			}
	        			
	        		});
	        	}); // end document
	        	
	        	function dateFormat(date) {
	        		var year = date.year;
	        		
	        		var month = date.monthValue;
	        		if(String(month).length < 2)
	        			month = '0' + month;
	        		
	        		var day = date.dayOfMonth;
	        		if(String(day).length < 2)
	        			day = '0' + day;
	        		
	        		var hour = date.hour;
	        		if(String(hour).length < 2)
	        			hour = '0' + hour;
	        		
	        		var minute = date.minute;
	        		if(String(minute).length < 2)
	        			minute = '0' + minute;
	        		
	        		var second = date.second; 
	        		if(String(second).length < 2)
	        			second = '0' + second;
	        			
        			return [year, month, day].join('-') + ' ' + [hour, minute, second].join(':');
	        	} // end dateFormat
	        	
	        	function getReply(qna_no) {
	        		
	        		$.ajax({
	        			type : 'get',
	        			url : '/qna/replyGet/' + qna_no,
	        			async : false,
	        			success : function(reply) {
	        				addReplyHtml(reply);
	        			}
	        		});
	        		
	        	} // end getReply
	        	
	        	function registAndGetReply(reply) {
	        		
	        		$.ajax({
	        			type : 'post',
	        			url : '/qna/replyRegistAndGet',
	        			data : JSON.stringify(reply),
	        			contentType : 'application/json; charset=utf-8',
	        			async : false,
	        			success : function(reply) {
	        				addReplyHtml(reply);
							
							$('#reply_content').val('');
	        			}
	        		});
	        		
	        	} // registAndGetReply
	        	
	        	function deleteReply(no, qna_no) {
	        		
	        		var c = confirm("댓글을 삭제하시겠습니까?");

	        		if(c) {
	        		
		        		$.ajax({
		        			type : 'post',
		        			url : '/qna/replyDelete',
		        			data : JSON.stringify(no),
		        			contentType : 'application/json; charset=utf-8',
		        			async : false,
		        			success : function(result) {
		        				console.log(result);
		        				if(result == 'success') {
		        					alert("댓글이 삭제되었습니다.");
		        					getReply(qna_no);
		        				} else {
		        					alert("댓글 삭제 실패. 다시 시도해주세요.");
		        				}
		        			}
		        		});
		        		
	        		} else {
	        			return false;
	        		}
	        	} // end deleteReply
	        	
	        	// 테이블에 reply 추가
	        	function addReplyHtml(reply) {
	        		var member_id = '${user.id}';
	        		var replyHtml = '';
    				$('.get_reply_tbl tbody').html(replyHtml);
    				
					for(var i = 0; i < reply.length; i++) {
    					var reg_date = dateFormat(reply[i].reg_date);
    					
						replyHtml += '<tr>'
      							   + '	<td>' + String(reply[i].member_id).substring(0, 2).concat('*****') + '</td>'
      							   + '	<td>' + reg_date + '</td>'
      							   + '	<td class="delete_reply">';
      							   if(member_id == reply[i].member_id) {
      							   replyHtml += '		<button type="button" class="btn btn-default btn-sm" onclick="deleteReply(\'' + reply[i].no + '\', \'' + reply[i].qna_no + '\')">삭제</button>'
      							   }
      							   replyHtml += '	</td>'
      							   + '</tr>'
      							   + '<tr>'
      							   + '	<td colspan="3">' + reply[i].content + '</td>'
      							   + '</tr>';
					}
    							  
					$('.get_reply_tbl tbody').append(replyHtml);
	        	} // end addReplyHtml
	        </script>
	        
	        <!-- 댓글 작성 처리 -->
	        <div class="col-md-10 col-md-offset-1 reply_area">
	        	<table class="table table-bordered reg_reply_tbl">
	        	<c:if test="${user eq null }">
	        		<tr>
	        			<td>회원에게만 댓글 작성 권한이 있습니다.</td>
	        		</tr>
	        	</c:if>
	        	<c:if test="${user ne null }">
	        		<!-- 등록 부분 -->
					<tr>
						<td>댓글 달기</td>
					</tr>
					<tr>
						<td>
							<input type="text" id="reply_content" class="form-control" name="reply_content" autocomplete="off">
							<button type="button" class="btn btn-default btn-sm reg_reply">댓글 등록</button>
						</td>
					</tr>
	        	</c:if>
	        	</table>
	        	
	        	<table class="table get_reply_tbl">
	        		<colgroup>
	        			<col width="10%">
	        			<col width="30%">
	        			<col width="60%">
	        		</colgroup>
	        		<tbody>
	        		</tbody>
	        	</table>
	        </div>
	        
	    </div>
	    
	    <form id="operForm" action="/qna/qnaModify" method="get">
	    	<input type="hidden" id="no" name="no" value='<c:out value="${qna.no }" />'>
	    	<input type="hidden" name="pageNum" value='<c:out value="${cri.pageNum }" />'>
	    	<input type="hidden" name="amount" value='<c:out value="${cri.amount }" />'>
	    	<input type="hidden" name="type" value='<c:out value="${cri.type }" />'>
	    	<input type="hidden" name="keyword" value='<c:out value="${cri.keyword }" />'>
	    </form>
	    
	    <!-- Qna Get End -->
		
		<%@ include file="../includes/footer.jsp" %>
	
	</div>

</body>
</html>