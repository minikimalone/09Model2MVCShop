<%@ page contentType="text/html; charset=euc-kr" %>
<%@ page pageEncoding="EUC-KR"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<!DOCTYPE html>
<html>
<head>
<title>상품 목록조회</title>

<link rel="stylesheet" href="/css/admin.css" type="text/css">


<!-- CDN(Content Delivery Network) 호스트 사용 -->
	<script src="http://code.jquery.com/jquery-2.1.4.min.js"></script>
	<script type="text/javascript">
	

 
	function fncGetList(currentPage) {
		
		$("#currentPage").val(currentPage)
		$("form").attr("method" , "POST").attr("action" , "/product/listProduct?menu=${param.menu}").submit();
	}
	
	 $(function() {
		 
			 $( "td.ct_btn01:contains('검색')" ).on("click" , function() {
				fncGetList(1);
			});
			 
			 $( ".ct_list_pop td:nth-child(3)" ).css("color" , "red");
			 $("h7").css("color" , "red");
			 $(".ct_list_pop:nth-child(4n+6)" ).css("background-color" , "whitesmoke");		
			 
		
	 });	
	 
	 
	 
	 
	 
	 
</script>
</head>

<body bgcolor="#ffffff" text="#000000">

<div style="width:98%; margin-left:10px;">

<form name="detailForm">

<table width="100%" height="37" border="0" cellpadding="0"	cellspacing="0">
	<tr>
		<td width="15" height="37">
			<img src="/images/ct_ttl_img01.gif" width="15" height="37"/>
		</td>
		<td background="/images/ct_ttl_img02.gif" width="100%" style="padding-left:10px;">
			<table width="100%" border="0" cellspacing="0" cellpadding="0">
				
				
				<tr>
					<td width="93%" class="ct_ttl01">
					
							${param.menu.equals("manage")?"상품 관리":"상품 목록 조회"}
					
					</td>
				</tr>
				
				
			</table>
		</td>
		<td width="12" height="37">
			<img src="/images/ct_ttl_img03.gif" width="12" height="37"/>
		</td>
	</tr>
</table>
<table width="100%" border="0" cellspacing="0" cellpadding="0" style="margin-top:10px;">
	<tr>

		<td align="right">
			
			<select name="searchCondition" class="ct_input_g" style="width:80px">
				<option value="0" ${! empty search.searchCondition&&search.searchCondition.equals('0') ? 'selected' : ''}>상품번호</option>
				<option value="1" ${! empty search.searchCondition&&search.searchCondition.equals('1') ? 'selected' : ''}>상품명</option>
				<option value="2" ${! empty search.searchCondition&&search.searchCondition.equals('2') ? 'selected' : ''}>가격 </option>
			</select>
		
			<input 	type="text" name="searchKeyword" value="${! empty search.searchKeyword ? search.searchKeyword : ''}"
			  class="ct_input_g" style="width:200px; height:20px" >
		</td>
		<td align="right" width="70">
			<table border="0" cellspacing="0" cellpadding="0">
				<tr>
					<td width="17" height="23"><img src="/images/ct_btnbg01.gif" width="17" height="23"/>
				
					<td background="/images/ct_btnbg02.gif" class="ct_btn01" style="padding-top:3px;">
						검색
					</td>
					<td width="14" height="23"><img src="/images/ct_btnbg03.gif" width="14" height="23"/>
					</td>
				</tr>
			</table>
		</td>
	</tr>
</table>


<table width="100%" border="0" cellspacing="0" cellpadding="0" style="margin-top:10px;">
	<tr>
		<td colspan="11" >전체 ${resultPage.totalCount} 건수, 현재 ${resultPage.currentPage} 페이지
		</td>
	</tr>
	<tr>
		<td class="ct_list_b" width="100">No</td>
		

		<td class="ct_line02"></td>
	
		<td class="ct_list_b" width="150">
			상품명<br>
			<h7 >(상품명 click:상세정보)</h7>
		</td>
		<td class="ct_list_b" width="150">가격</td>

	
		<c:choose>
		<c:when test="${param.menu eq 'manage'}">
		<td class="ct_list_b">등록일</td>	
		</c:when>
		<c:when test="${param.menu eq 'search'}">
		<td class="ct_list_b">상품 상세정보</td>	
		</c:when>
		</c:choose>
		
		<td class="ct_list_b">현재상태</td>	
	</tr>
	<tr>
		<td colspan="11" bgcolor="808285" height="1"></td>
	</tr>
		
		
		
	<c:set var="i" value="0" />
	<c:forEach var="product" items="${list}">
		<c:set var="i" value="${ i+1 }" />
		<tr class="ct_list_pop">
			<td align="center">${ i }</td>
			<td></td>
			
		
	
	
		<c:if test="${param.menu eq 'manage'}">
		
		<td align="left"><a href="/product/updateProductView?prodNo=${product.prodNo}&menu=${param.menu}">${product.prodName}</a></td>

		</c:if>
		<c:if test="${param.menu eq 'search'}">
		
		<td align="left"><a href="/product/getProduct?prodNo=${product.prodNo}&menu=${param.menu}">${product.prodName}</a></td>
		</c:if>	
		
		
		
		<td align="left">${product.price}</td>
	
	
	
		<c:if test="${param.menu eq 'search'}">
		<td align="left">${product.prodDetail}</td></c:if>	
		
		<c:if test="${param.menu eq 'manage'}">
		<td align="left">${product.regDate}</td>	
		</c:if>
		
		
		<td align="left">
		
		<c:if test="${!param.menu.equals('manage')}">
			
				판매중
			
			</c:if>
	
	
	
		<c:if test="${param.menu.equals('manage')}">			
		<c:choose>	
			<c:when test="${product.prodTranCode.equals('0')}">
				판매중
			</c:when>
			<c:when test="${product.prodTranCode eq '1  '}">
				구매완료 <a href= "/purchase/updateTranCodeListProduct?tranNo=${product.prodTranNo}&tranCode=2">배송하기</a>
			</c:when>
			<c:when test="${product.prodTranCode eq '2  '}">
				배송중
			</c:when>
			<c:when test="${product.prodTranCode eq '3  '}">
				배송완료
			</c:when>
	
		</c:choose>
		</c:if>
		</td>	
	</tr>	
	<tr>
		<td colspan="11" bgcolor="D6D7D6" height="1"></td>
	</tr>
	</c:forEach>

	</table>
	
<!--  페이지 Navigator 시작 -->
<table width="100%" border="0" cellspacing="0" cellpadding="0" style="margin-top:10px;">
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
	
