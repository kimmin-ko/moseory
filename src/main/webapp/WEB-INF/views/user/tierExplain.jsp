<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>  
			
			<script type="text/javascript">
				$(document).ready(function() {
					var memberJson = ${memberJson};
					var levelJson = ${levelJson};
					
					$("#memName").text(memberJson.name);
					
					$("#tier").text(levelJson.grade);
					
					$("#saving").text(levelJson.saving + '%');
					
					$("#discount").text(levelJson.discount + '%');
				});
			</script>
		  
			<div class="col-md-12 header-tier">
				<div class="col-md-1">
					<img id="tier-logo" src="/images/tier_1.jpg">
				</div>
				<div class="col-md-11 text-left">
					<p>
						저희 쇼핑몰을 이용해 주셔서 감사합니다. 
						<span id="memName"></span> 님은 
						[<span id="tier"></span>] 회원입니다.
						<br>
						상품 구매시 <span id="saving"></span>의 추가적립과 
						<span id="discount"></span>의 추가 할인을 받으실 수 있습니다.
					</p>
				</div>
			</div>
