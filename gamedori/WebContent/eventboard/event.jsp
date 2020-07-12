<!DOCTYPE html>
<html>
<head>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<script src="prototype001.js"></script>

<script language="JavaScript">

<!--

	

	function test01(){

		alert('오늘은 날씨가 좋습니다');

	}



	function test02(){

	  var bytes = string_to_utf8_bytes('오늘은 날씨가 좋습니다');

	  alert(eval(bytes));

	}



	function test03(){

	  var bytes = string_to_utf8_bytes('오늘은 날씨가 좋습니다');

	  alert(bytes_to_hex_string(bytes));

	}



	function test04(){

	  var bytes1 = string_to_utf8_bytes('오늘은 날씨가 좋습니다');

	  var hex_str1 = bytes_to_hex_string(bytes1);

	  var bytes2 = hex_string_to_bytes(hex_str1);

	  alert(eval(bytes2));

	  var str2 = utf8_bytes_to_string(bytes2);

	  alert(str2);

	}



	function test05(){

	  var hex_str1 = string_to_utf8_hex_string('오늘은 날씨가 좋습니다');

	  document.getElementById('hex_temp').innerHTML = hex_str1;

	  var str2 = utf8_hex_string_to_string(hex_str1);

	  alert(str2);

	}

//-->

</script>

</head>

<body>

<a href="#"  onClick="Javascript:test01();">試作ver001</a><br />

<a href="#"  onClick="Javascript:test02();">試作ver002</a><br />

<a href="#"  onClick="Javascript:test03();">試作ver003</a><br />

<a href="#"  onClick="Javascript:test04();">試作ver004</a><br />

<a href="#"  onClick="Javascript:test05();">試作ver005</a><br />

<br />

<span id="hex_temp"></span>

</body>

<html>
