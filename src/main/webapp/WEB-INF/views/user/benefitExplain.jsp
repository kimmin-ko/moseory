<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    	<link rel="stylesheet" href="/css/benefit.css">
    
        <div class="col-md-10 col-md-offset-1 div-benefit-info">
        	<table class="table table-bordered tbl-benefit-info">
        		<tr>
        			<td class="head-td" rowspan="2">혜택정보</td>
        			<td class="body-td">
        				<span id="memName"></span> 님은 
						[<span id="tier"></span>] 회원입니다.
						<br>
						상품 구매시 <span id="saving"></span>의 추가 적립과 
						<span id="discount"></span>의 추가 할인을 받으실 수 있습니다.
        			</td>
        		</tr>
        		<tr>
        			<td class="body-td">
						<span class="p-o-name">가용 적립금 : </span>
						<span id="point"></span>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
						<span class="p-o-name">총 구매금액 : </span>
						<span id="order"></span>
					</td>
        		</tr>
        	</table>
        </div>
        
        <script type="text/javascript">
    	// #,### formatNumber
    	Number.prototype.format = function(){
    	    if(this==0) return 0;
    	 
    	    var reg = /(^[+-]?\d+)(\d{3})/;
    	    var n = (this + '');
    	 
    	    while (reg.test(n)) n = n.replace(reg, '$1' + ',' + '$2');
    	 
    	    return n;
    	};
    	
    	String.prototype.format = function(){
    	    var num = parseFloat(this);
    	    if( isNaN(num) ) return "0";
    	 
    	    return num.format();
    	};
    	
        $(document).ready(function() {
        	var memberJson = ${memberJson};
         	var levelJson = ${levelJson};
         	
         	$("#memName").text(memberJson.name);
         	
         	$("#tier").text(levelJson.grade);
         	
         	$("#saving").text(levelJson.saving + '%');
         	
         	$("#discount").text(levelJson.discount + '%');
         	
         	$("#point").text(memberJson.point.format() + '원');
         	
         	$("#order").text(memberJson.total.format() + '원');
        });
        </script>