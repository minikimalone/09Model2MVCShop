<%@ page contentType="text/html; charset=euc-kr" %>
<%@ page pageEncoding="EUC-KR"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<!DOCTYPE html>
<html>
<head>
<title>구매 목록조회</title>

<link rel="stylesheet" href="/css/admin.css" type="text/css">


<!-- CDN(Content Delivery Network) 호스트 사용 -->
	<script src="http://code.jquery.com/jquery-2.1.4.min.js"></script>
	<script type="text/javascript">
	

 
	function fncGetList(currentPage) {
		
		$("#currentPage").val(currentPage)
		$("form").attr("method" , "POST").attr("action" , "/purchase/listPurchase?menu=${param.menu}").submit();
	
	}
	 $(function() {

		 $( ".ct_list_pop td:nth-child(1)" ).on("click" , function() {
			
				self.location ="/purchase/getPurchase?tranNo="+$(this).children("#tranNoj").text().trim();
				
		});
		 
		 $( ".ct_list_pop td:nth-child(3)" ).on("click" , function() {
				
				self.location ="/user/getUser?userId="+$(this).text().trim();
			});
		 
		 
		 $( ".ct_list_pop td:nth-child(1)" ).css("color" , "red");
		 $( ".ct_list_pop td:nth-child(3)" ).css("color" , "red");
		 $("h7").css("color" , "red");
		 $(".ct_list_pop:nth-child(4n+6)" ).css("background-color" , "whitesmoke");	
			
 });	
 
	

</script>
</head>

<body bgcolor="#ffffff" text="#000000">

<div style="width: 98%; margin-left: 10px;">

<form name="detailForm" >

<table width="100%" height="37" border="0" cellpadding="0"	cellspacing="0">
	<tr>
		<td width="15" height="37"><img src="/images/ct_ttl_img01.gif"width="15" height="37"></td>
		<td background="/images/ct_ttl_img02.gif" width="100%" style="padding-left: 10px;">
			<table width="100%" border="0" cellspacing="0" cellpadding="0">
				<tr>
					<td width="93%" class="ct_ttl01">구매 목록조회</td>
				</tr>
			</table>
		</td>
		<td width="12" height="37"><img src="/images/ct_ttl_img03.gif"	width="12" height="37"></td>
	</tr>
</table>

<table width="100%" border="0" cellspacing="0" cellpadding="0"	style="margin-top: 10px;">
	<tr>
		<td colspan="11" >전체 ${resultPage.totalCount} 건수, 현재 ${resultPage.currentPage} 페이지</td>
	</tr>
	<tr>
		<td class="ct_list_b" width="100">No<br>
			<h7 >(no click:구매상세정보)</h7>
			
		</td>
		
		
		<td class="ct_line02"></td>
		<td class="ct_list_b" width="150">회원ID
		<br>
			<h7 >(id click:회원상세정보)</h7>
		</td>
		<td class="ct_line02"></td>
		<td class="ct_list_b" width="150">수령자명</td>
		<td class="ct_line02"></td>
		<td class="ct_list_b">물품명</td>
		<td class="ct_line02"></td>
		<td class="ct_list_b">구매일</td>
		<td class="ct_line02"></td>
		<td class="ct_list_b">배송현황</td>
		<td class="ct_line02"></td>
		<td class="ct_list_b">상태</td>
	</tr>
	<tr>
		<td colspan="11" bgcolor="808285" height="1"></td>
	</tr>
	
	<c:set var="i" value="0" />
	<c:forEach var="purchase" items="${list}">
		<c:set var="i" value="${ i+1 }" />
	
	
	<tr class="ct_list_pop">
		<td align="center">
			${ i }<div id=tranNoj style="display:none">${purchase.tranNo}</div>
		</td>
		<td></td>
		<td align="left">
			${purchase.buyer.userId}
		</td>
		<td></td>
		<td align="left">${purchase.receiverName}</td>
		<td></td>
		<td align="left">${purchase.purchaseProd.prodName}</td>
		<td></td>
		<td align="left">${purchase.orderDate}</td>
		<td></td>
		<td align="left">
		<c:if test="${! empty purchase.tranCode && (purchase.tranCode eq '0  ')}">
		판매중
		</c:if>
		<c:if test="${! empty purchase.tranCode && (purchase.tranCode eq '1  ')}">
		구매완료 
		</c:if>
		<c:if test="${! empty purchase.tranCode && (purchase.tranCode eq '2  ')}">
		배송중 
		</c:if>
		<c:if test="${! empty purchase.tranCode && (purchase.tranCode eq '3  ')}">
		배송완료  
		</c:if>
		</td>
		<td></td>
		
		<td align="left">
				
		<c:if test="${! empty purchase.tranCode && (purchase.tranCode eq '2  ')}">
		<a href= "/purchase/updateTranCodeListPurchase?tranNo=${purchase.tranNo}&tranCode=3">물건 도착</a>
		</c:if>
		<c:if test="${! empty purchase.tranCode && !(purchase.tranCode eq '2  ')}">
			 
		</c:if>
		
		</td>
		
	</tr>
	<tr>
		<td colspan="11" bgcolor="808285" height="1"></td>
	</tr>
	</c:forEach>
	
	
</table>

<table width="100%" border="0" cellspacing="0" cellpadding="0" style="margin-top: 10px;">
	<tr>
		<td align="center">
		   <input type="hidden" id="currentPage" name="currentPage" value=""/>
		   
			<jsp:include page="../common/pageNavigator.jsp"/>	
			
    	</td>
	</tr>
</table>

<!--  페이지 Navigator 끝 -->
</form>

</div>

</body>
</html>