<%@ Page Language="C#" AutoEventWireup="true" CodeFile="manage.aspx.cs" Inherits="manage" %>

<!DOCTYPE html>
<link rel="stylesheet"type="text/css"href="exes.css"/>

<html>

<head>

  <meta charset="UTF-8">

  <title>LeeSung管理系统</title>

  <link rel="stylesheet" href="css/reset.css">
    <link rel="stylesheet" href="css/style.css" media="screen" type="text/css" />

    <style type="text/css">
        #TA1 {
            height: 54px;
            width: 247px;
        }
    </style>

</head>
    <script lang="ja" type="text/ecmascript" src="Scripts/bootstrap-table.js"></script>
    <script lang="ja" type="text/ecmascript" src="Scripts/jquery-1.8.2.js">
        </script>
    <script lang="ja" type="text/javascript">
        var idTmr;
        function getExplorer() {
            var explorer = window.navigator.userAgent;
            if (explorer.indexOf("MSIE") >= 0 || (explorer.indexOf("Windows NT 6.1;") >= 0 && explorer.indexOf("Trident/7.0;") >= 0)) {
                return 'ie';   //ie  
            }
            else if (explorer.indexOf("Firefox") >= 0) {
                return 'Firefox';  //firefox  
            }
            else if (explorer.indexOf("Chrome") >= 0) {
                return 'Chrome'; //Chrome  
            }
            else if (explorer.indexOf("Opera") >= 0) {
                return 'Opera';  //Opera  
            }
            else if (explorer.indexOf("Safari") >= 0) {
                return 'Safari';   //Safari  
            }
        }

        //此方法为ie导出之后,可以保留table格式的方法
        function getIEsink(tableid) {
            var curTbl = document.getElementById(tableid);
            if (curTbl == null || curTbl == "") {
                alert("没有数据");
                return false;
            }
            var oXL;
            try {
                oXL = new ActiveXObject("Excel.Application"); //创建AX对象excel  
            } catch (e) {
                alert("无法启动Excel!\n\n如果您确信您的电脑中已经安装了Excel，" + "那么请调整IE的安全级别。\n\n具体操作：\n\n" + "工具 → Internet选项 → 安全 → 自定义级别 → 对没有标记为安全的ActiveX进行初始化和脚本运行 → 启用");
                return false;
            }

            var oWB = oXL.Workbooks.Add();
            var oSheet = oWB.ActiveSheet;
            var sel = document.body.createTextRange();
            sel.moveToElementText(curTbl);
            sel.select();
            sel.execCommand("Copy");
            oSheet.Paste();
            oXL.Visible = true;
        }

        //此方法为ie导出之后,不保留table格式的方法
        function getIEnotsink(tableid) {
            var curTbl = document.getElementById(tableid);
            if (curTbl == null || curTbl == "") {
                alert("没有数据");
                return false;
            }
            var oXL;
            try {
                oXL = new ActiveXObject("Excel.Application"); //创建AX对象excel  
            } catch (e) {
                alert("无法启动Excel!\n\n如果您确信您的电脑中已经安装了Excel，" + "那么请调整IE的安全级别。\n\n具体操作：\n\n" + "工具 → Internet选项 → 安全 → 自定义级别 → 对没有标记为安全的ActiveX进行初始化和脚本运行 → 启用");
                return false;
            }

            var oWB = oXL.Workbooks.Add();
            var oSheet = oWB.ActiveSheet;
            var Lenr = curTbl.rows.length;
            for (i = 0; i < Lenr; i++) {
                var Lenc = curTbl.rows(i).cells.length;
                for (j = 0; j < Lenc; j++) {
                    oSheet.Cells(i + 1, j + 1).value = curTbl.rows(i).cells(j).innerText;
                }
            }
            oXL.Visible = true;
        }
        function getImport(tableid) {
            if (getExplorer() == 'ie') {
                getIEnotsink(tableid);
            }
            else {
                tableToExcel(tableid);
            }
        }
        function Cleanup() {
            window.clearInterval(idTmr);
            CollectGarbage();
        }
        var tableToExcel = (function () {
            var uri = 'data:application/vnd.ms-excel;base64,',
                      template = '<html><head><meta charset="UTF-8"></head><body><table border="1">{table}</table></body></html>',
                    base64 = function (s) { return window.btoa(unescape(encodeURIComponent(s))) },
                   format = function (s, c) {
                       return s.replace(/{(\w+)}/g,
                            function (m, p) { return c[p]; })
                   }
            return function (table, name) {
                if (!table.nodeType) table = document.getElementById(table)
                var ctx = { worksheet: name || 'Worksheet', table: table.innerHTML }
                window.location.href = uri + base64(format(template, ctx))
            }
        })()
</script><%--导出--%>
    <script>
        $(function () {
            var loc = location.href;
            var n1 = loc.length;
            var n2 = loc.indexOf("=");
            var id = decodeURI(loc.substr(n2 + 1, n1 - n2));
            if (id.substring(0, 2) != "00") {
                $("#a1").css("display", "none");
                $("#a2").css("display", "none");
                $("#a3").css("display", "none");
                $("#a4").css("display", "none");
                $("#a5").css("display", "none");
                var x = id;

                $.ajax({//取得员工的姓名用在考勤表中
                    type: "post",
                    url: "ygchange.aspx",
                    datatype: "text",
                    data: "key=select 工号,部门号,密码,姓名,性别,身份证号码,联系方式,家庭住址 from 员工表 where 工号='" + x + "'",
                    success: function (result) {
                        var data1 = new Array();
                        data1 = result.split('|');
                        var data2 = data1[1].split(',');
                        $("#fq").val(data2[3]);
                    }
                })

            }
            $(document).ready(function () {
                if (id.substring(0, 2) == "00")
                {
                    $("#ax").css("background", "rgba(128,128,128,0.8)");
                }
                $("#logoex").append("欢迎您，员工：" + id);
                $.ajax({
                    type: "post",
                    url: "ygxgsc.aspx",
                    datatype: "text",//先清空入住历史表再将数据导入
                    data: "mas=delete from 入住历史表  insert into 入住历史表 select * from 入住信息表",
                    success: function (result) {
                        alert("入住信息已同步至历史！");
                    }
                })
            })
            $("#Button3").click(function () {//客户信息查看
                if (id.substring(0, 2) == "00") {
                    $.ajax({
                        type: "post",
                        url: "manageon1.aspx",
                        datatype: "text",
                        data: "key=",
                        success: function (result) {
                            var data1 = new Array();
                            data1 = result.split('|');
                            $("#div1").empty();
                            $("#div1").css("display", "block");
                            var title = $("<p font-size='xx-large' font-family='华文隶书' id='p1' >客户信息表</p>");
                            var table1 = $("<table id='table1' border='2px' width='100%' text-align='center' data-pagination='true' data-site-pagination='client' data-page-size='10'>");
                            var but = $("<input type='button' id='daochu' value='导出' onclick=\"getImport('table1')\">")

                            $("#div1").append(title);
                            $("#div1").append(table1);
                            $("#div1").append(but);


                            for (var i = 0; i < data1.length ; i++) {

                                var data2 = data1[i].split(',');
                                var tr = $("<tr>");
                                var trend = $("</tr>");
                                tr.appendTo(table1);
                                for (var j = 0; j < 5; j++) {
                                    var td = $("<td>" + data2[j] + "</td>");
                                    td.appendTo(tr);

                                }

                                trend.append(table1);
                                $("#div1").append("</table>");
                            }
                        }
                    })
                }
                else {
                    alert("对不起！您没有访问权限！")
                }
            })
            $("#Button4").click(function () {//管理员信息查看
                if (id.substring(0, 2) == "00") {
                    $.ajax({
                        type: "post",
                        url: "manageon2.aspx",
                        datatype: "text",
                        data: "key=",
                        success: function (result) {
                            var data1 = new Array();
                            data1 = result.split('|');
                            $("#div1").empty();
                            $("#div1").css("display", "block");
                            var title = $("<p font-size='xx-large' font-family='华文隶书' id='p2'>管理员信息表</p>");
                            var table1 = $("<table id='table1' border='2px' width='100%' text-align='center'>");
                            var but = $("<input type='button' id='daochu' value='导出' onclick=\"getImport('table1')\">")

                            $("#div1").append(title);
                            $("#div1").append(table1);
                            $("#div1").append(but);

                            for (var i = 0; i < data1.length ; i++) {

                                var data2 = data1[i].split(',');
                                var tr = $("<tr>");
                                var trend = $("</tr>");
                                tr.appendTo(table1);
                                for (var j = 0; j < 9; j++) {
                                    var td = $("<td>" + data2[j] + "</td>");
                                    td.appendTo(tr);

                                }

                                trend.append(table1);
                                $("#div1").append("</table>");
                            }
                        }
                    })
                }
                else {
                    alert("对不起！您没有访问权限！")
                }
            })
            $("#Button5").click(function () {//员工信息查看
                if (id.substring(0, 2)=="00") {
                    $.ajax({
                        type: "post",
                        url: "manageon3.aspx",
                        datatype: "text",
                        data: "key=",
                        success: function (result) {
                            var data1 = new Array();
                            data1 = result.split('|');
                            $("#div1").empty();
                            $("#div1").css("display", "block");
                            var title = $("<p font-size='xx-large' font-family='华文隶书' id='p3'>员工信息表</p>");
                            var table1 = $("<table id='table1' border='2px' width='100%' text-align='center'>");
                            var but = $("<input type='button' id='daochu' value='导出' onclick=\"getImport('table1')\">")

                            $("#div1").append(title);
                            $("#div1").append(table1);
                            $("#div1").append(but);

                            for (var i = 0; i < data1.length ; i++) {

                                var data2 = data1[i].split(',');
                                var tr = $("<tr>");
                                var trend = $("</tr>");
                                tr.appendTo(table1);
                                for (var j = 0; j < 9; j++) {
                                    var td = $("<td>" + data2[j] + "</td>");
                                    td.appendTo(tr);

                                }

                                trend.append(table1);
                                $("#div1").append("</table>");
                            }
                        }
                    })
                }
                else {
                    alert("对不起！您没有访问权限！")
                }
            })
            $("#Button6").click(function () {
                $("#div1").css("display", "none");
                $("#div2").css("display", "none");
                $("#div3").css("display", "none");
                $("#div4").css("display", "none");
            })
            $("#Button7").click(function () {
                $("#div1").css("display", "none");
                $("#div2").css("display", "block");
                $("#div3").css("display", "none");
                $("#div4").css("display", "none");
            })
            $("#chaxun").click(function () {//客户信息查询
                if(id.substring(0,2)=="00")
                    {
                var x = $("#Text1").val();
                $.ajax({
                    type: "post",
                    url: "kehuchange.aspx",
                    datatype: "text",
                    data: "key=姓名='" + x + "'",
                    success: function (result) {
                        if (result == "查无此人！") {
                            alert("查无此人！");
                        }
                        var data1 = new Array();
                        data1 = result.split('|');
                        var data2 = data1[1].split(',');
                        $("#Text1").val(data2[0]);
                        $("#Text2").val(data2[1]);
                        $("#Text3").val(data2[2]);
                        $("#Text4").val(data2[3]);
                        $("#Text5").val(data2[4]);
                    }
                })
            }
            else {
                    alert("对不起！您没有访问权限！")
        }
            })
            $("#xiugai").click(function () {//客户信息修改
                if (id.substring(0, 2) == "00") {
                    var n1 = $("#Text1").val();//姓名
                    var n2 = $("#Text2").val();//密码
                    var n3 = $("#Text3").val();//性别
                    var n4 = $("#Text4").val();//联系方式
                    var n5 = $("#Text5").val();//身份证号码
                    $("#menu").css("display", "block");
                    $.ajax({
                        type: "post",
                        url: "kehuxg.aspx",
                        datatype: "text",
                        data: "mas=密码='" + n2 + "',性别='" + n3 + "',联系方式='" + n4 + "',身份证号码='" + n5 + "'where 姓名='" + n1 + "'",
                        success: function (result) {
                            alert("修改成功！");
                        }
                    })
                }
                else {
                    alert("对不起！您没有访问权限！")
                }
            })
            $("#shanchu").click(function () {//客户信息删除
                if (id.substring(0, 2) == "00") {
                var x = $("#Text1").val();
                if (confirm("是否删除客户:" + x + "?")) {
                    $.ajax({
                        type: "post",
                        url: "kehushac.aspx",
                        datatype: "text",
                        data: "key=delete from 客户表 where 姓名='" + x + "'",
                        success: function (result) {
                            alert("删除成功！");
                            $("#Text1").val("");
                            $("#Text2").val("");
                            $("#Text3").val("");
                            $("#Text4").val("");
                            $("#Text5").val("");
                        }
                    })
                }
                }
                else {
                    alert("对不起！您没有访问权限！")
                }
            })
            $("#Button8").click(function () {//显示员工信息
                $("#div1").css("display", "none");
                $("#div2").css("display", "none");
                $("#div3").css("display", "block");
                $("#div4").css("display", "none");
            })
            $("#ygcx").click(function () {//查询员工信息
                
                if (id.substring(0, 2) != "00") {//当登陆者为员工的时候
                    $("#Text6").val(id);
                    document.getElementById("Text6").setAttribute("readOnly", "true");
                    $("#Text6").css("background-color", "#999999");
                    document.getElementById("Text7").setAttribute("readOnly", "true");
                    $("#Text7").css("background-color", "#999999");
                    document.getElementById("Text9").setAttribute("readOnly", "true");
                    $("#Text9").css("background-color", "#999999");
                    document.getElementById("Text11").setAttribute("readOnly", "true");
                    $("#Text11").css("background-color", "#999999");
                }
                    var x = $("#Text6").val();
                $.ajax({
                    type: "post",
                    url: "ygchange.aspx",
                    datatype: "text",
                    data: "key=select 工号,部门号,密码,姓名,性别,身份证号码,联系方式,家庭住址 from 员工表 where 工号='" + x + "'",
                    success: function (result) {
                        if (result == "工号,部门号,密码,姓名,性别,身份证号码,联系方式,家庭住址")
                        {
                            alert("查无此人!");
                        }
                        var data1 = new Array();
                        data1 = result.split('|');
                        var data2 = data1[1].split(',');
                        $("#Text6").val(data2[0]);
                        $("#Text7").val(data2[1]);
                        $("#Text8").val(data2[2]);
                        $("#Text9").val(data2[3]);
                        $("#Text10").val(data2[4]);
                        $("#Text11").val(data2[5]);
                        $("#Text12").val(data2[6]);
                        $("#Text13").val(data2[7]);
                    }
                })
            })
            $("#ygxg").click(function () {//员工信息修改
                var n1 = $("#Text6").val();
                var n2 = $("#Text7").val();
                var n3 = $("#Text8").val();
                var n4 = $("#Text9").val();
                var n5 = $("#Text10").val();
                var n6 = $("#Text11").val();
                var n7 = $("#Text12").val();
                var n8 = $("#Text13").val();

                $.ajax({
                    type: "post",
                    url: "ygxgsc.aspx",
                    datatype: "text",
                    data: "mas=update 员工表 set 工号='" + n1 + "',部门号='" + n2 + "',密码='" + n3 + "',姓名='" + n4 + "',性别='"+n5+"',身份证号码='"+n6+"',联系方式='"+n7+"',家庭住址='"+n8+"'where 工号='" + n1 + "'",
                    success: function (result) {
                        alert("修改成功！");
                    }
                })
            })
            $("#ygsc").click(function () {//员工信息删除
                if (id.substring(0, 2) == "00") {
                    var x = $("#Text6").val();
                    if (confirm("是否删除员工:" + x + "?")) {
                        $.ajax({
                            type: "post",
                            url: "ygxgsc.aspx",
                            datatype: "text",
                            data: "mas=delete from 员工表 where 工号='" + x + "'",
                            success: function (result) {
                                alert("删除成功！");
                                $("#Text6").val("");
                                $("#Text7").val("");
                                $("#Text8").val("");
                                $("#Text9").val("");
                                $("#Text10").val("");
                                $("#Text11").val("");
                                $("#Text12").val("");
                                $("#Text13").val("");
                            }
                        })
                    }
                }
                else {
                    alert("对不起！您没有访问权限！")
                }
            })
            $("#ygtj").click(function () {//员工添加
                if (id.substring(0, 2) == "00"){
                var n1 = $("#Text6").val();
                var n2 = $("#Text7").val();
                var n3 = $("#Text8").val();
                var n4 = $("#Text9").val();
                var n5 = $("#Text10").val();
                var n6 = $("#Text11").val();
                var n7 = $("#Text12").val();
                var n8 = $("#Text13").val();
                $.ajax({
                    type: "post",
                    url: "ygxgsc.aspx",//与员工修改删除使用同一个后台
                    datatype: "text",
                    data: "mas=insert into 员工表 values('" + n1 + "','" + n2 + "','" + n3 + "','" + n4 + "','" + n5 + "','" + n6 + "','" + n7 + "','"+null+"','" + n8+ "')",
                    success: function (result) {
                        alert("添加成功！");
                    }
                })
            }
            else {
                    alert("对不起！您没有访问权限！")
        }
            })
            $("#Button9").click(function () {//显示管理员信息
                $("#div1").css("display", "none");
                $("#div2").css("display", "none");
                $("#div3").css("display", "none");
                $("#div4").css("display", "block");
            })
            $("#glycx").click(function () {
                if (id.substring(0, 2) == "00"){
                var x = $("#Text14").val();
                $.ajax({
                    type: "post",
                    url: "glychange.aspx",
                    datatype: "text",
                    data: "key=select 工号,密码,姓名,性别,出生日期,身份证号码,联系方式,家庭住址 from 管理员表 where 工号='" + x + "'",
                    success: function (result) {
                        if (result == "工号,密码,姓名,性别,出生日期,身份证号码,联系方式,家庭住址") {
                            alert("查无此人!");
                        }
                        var data1 = new Array();
                        data1 = result.split('|');
                        var data2 = data1[1].split(',');
                        $("#Text14").val(data2[0]);
                        $("#Text15").val(data2[1]);
                        $("#Text16").val(data2[2]);
                        $("#Text17").val(data2[3]);
                        $("#Text18").val(data2[4]);
                        $("#Text19").val(data2[5]);
                        $("#Text20").val(data2[6]);
                        $("#Text21").val(data2[7]);
                    }
                })
                }
                else {
                    alert("对不起！您没有访问权限！")
                }
            })
            $("#glyxg").click(function () {
                if (id.substring(0, 2) == "00"){
                var n1 = $("#Text14").val();
                var n2 = $("#Text15").val();
                var n3 = $("#Text16").val();
                var n4 = $("#Text17").val();
                var n5 = $("#Text18").val();
                var n6 = $("#Text19").val();
                var n7 = $("#Text20").val();
                var n8 = $("#Text21").val();
                $.ajax({
                    type: "post",
                    url: "ygxgsc.aspx",//与员工修改删除使用同一个后台
                    datatype: "text",
                    data: "mas=update 管理员表 set 工号='" + n1 + "',密码='" + n2 + "',姓名='" + n3 + "',性别='" + n4 + "',出生日期='" + n5 + "',身份证号码='" + n6 + "',联系方式='" + n7 + "',家庭住址='" + n8 + "'where 工号='" + n1 + "'",
                    success: function (result) {
                        alert("修改成功！");
                    }
                })
                }
                else {
                    alert("对不起！您没有访问权限！")
                }
            })
            $("#glysc").click(function () {//管理员信息删除
                if (id.substring(0, 2) == "00"){
                var x = $("#Text14").val();
                if (confirm("是否删除管理员:" + x + "?")) {
                    $.ajax({
                        type: "post",
                        url: "ygxgsc.aspx",
                        datatype: "text",
                        data: "mas=delete from 管理员表 where 工号='" + x + "'",
                        success: function (result) {
                            alert("删除成功！");
                            $("#Text14").val("");
                            $("#Text15").val("");
                            $("#Text16").val("");
                            $("#Text17").val("");
                            $("#Text18").val("");
                            $("#Text19").val("");
                            $("#Text20").val("");
                            $("#Text21").val("");
                        }
                    })
                }
                }
                else {
                    alert("对不起！您没有访问权限！")
                }
            })
            $("#glytj").click(function () {//管理员添加
                if (id.substring(0, 2) == "00"){
                var n1 = $("#Text14").val();
                var n2 = $("#Text15").val();
                var n3 = $("#Text16").val();
                var n4 = $("#Text17").val();
                var n5 = $("#Text18").val();
                var n6 = $("#Text19").val();
                var n7 = $("#Text20").val();
                var n8 = $("#Text21").val();
                $.ajax({
                    type: "post",
                    url: "ygxgsc.aspx",//与员工修改删除使用同一个后台
                    datatype: "text",
                    data: "mas=insert into 管理员表 values('" + n1 + "','" + n2 + "','" + n3 + "','" + n4 + "','" + n5 + "','" + n6 + "','" + n7 + "','" + null + "','" + n8 + "')",
                    success: function (result) {

                        alert("添加成功！");
                    }
                })
                }
                else {
                    alert("对不起！您没有访问权限！")
                }
            })
            $("#Button11").click(function () {//部门信息查看
                if (id.substring(0, 2) == "00"){
                $.ajax({
                    type: "post",
                    url: "managelkt.aspx",
                    datatype: "text",
                    data: "key=select * from 部门表",
                    success: function (result) {
                        var data1 = new Array();
                        data1 = result.split('|');
                        $("#div1").empty();
                        $("#div1").css("display", "block");
                        var title = $("<p font-size='xx-large' font-family='华文隶书' height='25px' >部门信息表</p>");
                        var table1 = $("<table id='table1' border='2px' width='100%' text-align='center'><tr><td>部门号</td><td>部门名称</td><td>部门人数</td><td>简介</td></tr>");
                        var but = $("<input type='button' id='daochu' value='导出' onclick=\"getImport('table1')\">")

                        $("#div1").append(title);
                        $("#div1").append(table1);
                        $("#div1").append(but);
                        for (var i = 0; i < data1.length-1 ; i++) {

                            var data2 = data1[i].split(',');
                            var tr = $("<tr>");
                            var trend = $("</tr>");
                            tr.appendTo(table1);
                            for (var j = 0; j < 4; j++) {
                                var td = $("<td>" + data2[j] + "</td>");
                                td.appendTo(tr);

                            }

                            trend.append(table1);
                            $("#div1").append("</table>");
                        }
                    }
                })
                }
                else {
                    alert("对不起！您没有访问权限！")
                }
            })
            $("#Button16").click(function () {//显示部门div
                $("#div5").css("display", "block");
                $("#div6").css("display", "none");
                $("#div7").css("display", "none");
                $("#div8").css("display", "none");
            })
            $("#bmcx").click(function () {//部门信息查询
                if (id.substring(0, 2) == "00"){
                var x = $("#Text22").val();
                    $.ajax({
                        type: "post",
                        url: "managelkt.aspx",
                        datatype: "text",
                        data: "key=select * from 部门表 where 部门号='" + x + "'",
                        success: function (result) {
                            if (result == "") {
                                alert("没有找到该部门!");
                            }
                            var data1 = new Array();
                            data1 = result.split('|');
                            var data2 = data1[0].split(',');
                            $("#Text22").val(data2[0]);
                            $("#Text23").val(data2[1]);
                            $("#Text24").val(data2[2]);
                            $("#TA1").val(data2[3]);
                        }
                    })
                }
                else {
                    alert("对不起！您没有访问权限！")
                }
            })
            $("#bmsc").click(function () {//部门信息删除
                if (id.substring(0, 2) == "00"){
                var x = $("#Text22").val();
                if (confirm("是否删除该部门？部门号:" + x )) {
                    $.ajax({
                        type: "post",
                        url: "ygxgsc.aspx",
                        datatype: "text",
                        data: "mas=delete from 部门表 where 部门号='" + x + "'",
                        success: function (result) {
                            alert("删除成功！");
                            $("#Text22").val("");
                            $("#Text23").val("");
                            $("#Text24").val("");
                            $("#TA1").val("");
                        }
                    })
                }
                }
                else {
                    alert("对不起！您没有访问权限！")
                }
            })
            $("#bmxg").click(function () {//部门修改
                if (id.substring(0, 2) == "00"){
                var n1 = $("#Text22").val();
                var n2 = $("#Text23").val();
                var n3 = $("#Text24").val();
                var n4 = $("#TA1").val();
                $.ajax({
                    type: "post",
                    url: "ygxgsc.aspx",//与员工修改删除使用同一个后台
                    datatype: "text",
                    data: "mas=update 部门表 set 部门号='" + n1 + "',部门名称='" + n2 + "',部门人数='" + n3 + "',简介='" + n4 + "'where 部门号='" + n1 + "'",
                    success: function (result) {
                        alert("修改成功！");
                    }
                })
                }
                else {
                    alert("对不起！您没有访问权限！")
                }
            })
            $("#bmtj").click(function () {//部门添加
                if (id.substring(0, 2) == "00"){
                var n1 = $("#Text22").val();
                var n2 = $("#Text23").val();
                var n3 = $("#Text24").val();
                var n4 = $("#TA1").val();
                $.ajax({
                    type: "post",
                    url: "ygxgsc.aspx",//与员工修改删除使用同一个后台
                    datatype: "text",
                    data: "mas=insert into 部门表 values('"+n1+"','"+n2+"','"+n3+"','"+n4+"')",
                    success: function (result) {
                        alert("添加成功！");
                    }
                })
                }
                else {
                    alert("对不起！您没有访问权限！")
                }
            })
            $("#Button12").click(function () {//考勤信息查看
                if (id.substring(0, 2) == "00"){
                $.ajax({
                    type: "post",
                    url: "managelkt.aspx",
                    datatype: "text",
                    data: "key=select * from 考勤表",
                    success: function (result) {
                        var data1 = new Array();
                        data1 = result.split('|');
                        $("#div1").empty();
                        $("#div1").css("display", "block");
                        var title = $("<p font-size='xx-large' font-family='华文隶书' height='25px' >考勤信息表</p>");
                        var table1 = $("<table id='table1' border='2px' width='100%' text-align='center'><tr><td>时间</td><td>工号</td><td>姓名</td></tr>");
                        var but = $("<input type='button' id='daochu' value='导出' onclick=\"getImport('table1')\">")

                        $("#div1").append(title);
                        $("#div1").append(table1);
                        $("#div1").append(but);

                        for (var i = 0; i < data1.length-1 ; i++) {

                            var data2 = data1[i].split(',');
                            var tr = $("<tr>");
                            var trend = $("</tr>");
                            tr.appendTo(table1);
                            for (var j = 0; j < 3; j++) {
                                var td = $("<td>" + data2[j] + "</td>");
                                td.appendTo(tr);

                            }

                            trend.append(table1);
                            $("#div1").append("</table>");
                        }
                    }
                })
                }
                else {
                    alert("对不起！您没有访问权限！")
                }
            })
            $("#Button17").click(function () {//显示考勤div
                $("#div5").css("display", "none");
                $("#div6").css("display", "block");
                $("#div7").css("display", "none");
                $("#div8").css("display", "none");
            })
            $("#kqcx").click(function () {//考勤信息查询
                if (id.substring(0, 2) == "00"){
                var x = $("#Text25").val();
                $.ajax({
                    type: "post",
                    url: "managelkt.aspx",
                    datatype: "text",
                    data: "key=select * from 考勤表 where 工号='" + x + "'",
                    success: function (result) {
                        if (result == "") {
                            alert("没有找到该员工考勤信息!");
                        }
                        var data1 = new Array();
                        data1 = result.split('|');
                        var data2 = data1[0].split(',');
                        $("#Text25").val(data2[1]);
                        $("#Text26").val(data2[0]);
                        $("#Text27").val(data2[2]);
                    }
                })
                }
                else {
                    alert("对不起！您没有访问权限！")
                }
            })
            $("#kqsc").click(function () {//考勤信息删除
                if (id.substring(0, 2) == "00"){
                var x = $("#Text25").val();
                if (confirm("是否删除该工号考勤信息:" + x + "?")) {
                    $.ajax({
                        type: "post",
                        url: "ygxgsc.aspx",
                        datatype: "text",
                        data: "mas=delete from 考勤表 where 工号='" + x + "'",
                        success: function (result) {
                            alert("删除成功！");
                            $("#Text25").val("");
                            $("#Text26").val("");
                            $("#Text27").val("");
                        }
                    })
                }
                }
                else {
                    alert("对不起！您没有访问权限！")
                }
            })
            $("#kqxg").click(function () {//考勤修改
                if (id.substring(0, 2) == "00"){
                var n1 = $("#Text25").val();
                var n2 = $("#Text26").val();
                var n3 = $("#Text27").val();
                $.ajax({
                    type: "post",
                    url: "ygxgsc.aspx",//与员工修改删除使用同一个后台
                    datatype: "text",
                    data: "mas=update 考勤表 set 时间='" + n2 + "',工号='" + n1 + "',姓名='" + n3 + "'where 工号='" + n1 + "'",
                    success: function (result) {
                        alert("修改成功！");
                    }
                })
                }
                else {
                    alert("对不起！您没有访问权限！")
                }
            })
            $("#kqtj").click(function () {//考勤添加
                if (id.substring(0, 2) == "00"){
                var n1 = $("#Text25").val();
                var n2 = $("#Text26").val();
                var n3 = $("#Text27").val();
                $.ajax({
                    type: "post",
                    url: "ygxgsc.aspx",//与员工修改删除使用同一个后台
                    datatype: "text",
                    data: "mas=insert into 考勤表 values('" + n2 + "','" + n1 + "','" + n3 + "')",
                    success: function (result) {
                        alert("添加成功！");
                    }
                })
                }
                else {
                    alert("对不起！您没有访问权限！")
                }
            })
            $("#Button13").click(function () {//入住信息查看
                if (id.substring(0, 2) == "00"){
                $.ajax({
                    type: "post",
                    url: "managelkt.aspx",
                    datatype: "text",
                    data: "key=select * from 入住数据表",
                    success: function (result) {
                        var data1 = new Array();
                        data1 = result.split('|');
                        $("#div1").empty();
                        $("#div1").css("display", "block");
                        var title = $("<p font-size='xx-large' font-family='华文隶书' height='25px' >入住信息表</p>");
                        var table1 = $("<table id='table1' border='2px' width='100%' text-align='center'><tr><td>房号</td><td>日期</td><td>入住人姓名</td><td>入住人数</td><td>是否入住</td></tr>");
                        var but = $("<input type='button' id='daochu' value='导出' onclick=\"getImport('table1')\">")

                        $("#div1").append(title);
                        $("#div1").append(table1);
                        $("#div1").append(but);

                        for (var i = 0; i < data1.length - 1 ; i++) {

                            var data2 = data1[i].split(',');
                            var tr = $("<tr>");
                            var trend = $("</tr>");
                            tr.appendTo(table1);
                            for (var j = 0; j < 5; j++) {
                                var td = $("<td>" + data2[j] + "</td>");
                                td.appendTo(tr);

                            }

                            trend.append(table1);
                            $("#div1").append("</table>");
                        }
                    }
                })
                }
                else {
                    alert("对不起！您没有访问权限！")
                }
            })
            $("#Button18").click(function () {//显示入住div
                $("#div5").css("display", "none");
                $("#div6").css("display", "none");
                $("#div7").css("display", "block");
                $("#div8").css("display", "none");
            })
            $("#rzcx").click(function () {//入住信息查询
                if (id.substring(0, 2) == "00"){
                var x = $("#Text29").val();
                $.ajax({
                    type: "post",
                    url: "managelkt.aspx",
                    datatype: "text",
                    data: "key=select * from 入住数据表 where 房号='" + x + "'",
                    success: function (result) {
                        if (result == "") {
                            alert("没有找到该房间信息!");
                        }
                        var data1 = new Array();
                        data1 = result.split('|');
                        var data2 = data1[0].split(',');
                        $("#Text29").val(data2[0]);
                        $("#Text30").val(data2[1]);
                        $("#Text31").val(data2[2]);
                        $("#Text32").val(data2[3]);
                        $("#Text33").val(data2[4]);
                    }
                })
                }
                else {
                    alert("对不起！您没有访问权限！")
                }
            })
            $("#rzsc").click(function () {//入住信息删除
                if (id.substring(0, 2) == "00"){
                var x = $("#Text29").val();
                if (confirm("是否删除该房号信息:" + x + "?")) {
                    $.ajax({
                        type: "post",
                        url: "ygxgsc.aspx",
                        datatype: "text",
                        data: "mas=delete from 入住数据表 where 房号='" + x + "'",
                        success: function (result) {
                            alert("删除成功！");
                            $("#Text29").val("");
                            $("#Text30").val("");
                            $("#Text31").val("");
                            $("#Text32").val("");
                            $("#Text33").val("");
                        }
                    })
                }
                }
                else {
                    alert("对不起！您没有访问权限！")
                }
            })
            $("#rzxg").click(function () {//入住修改
                if (id.substring(0, 2) == "00"){
                var n1 = $("#Text29").val();
                var n2 = $("#Text30").val();
                var n3 = $("#Text31").val();
                var n4 = $("#Text32").val();
                var n5 = $("#Text33").val();
                $.ajax({
                    type: "post",
                    url: "ygxgsc.aspx",//与员工修改删除使用同一个后台
                    datatype: "text",
                    data: "mas=update 入住数据表 set 房号='" + n1 + "',日期='" + n2 + "',入住人姓名='" + n3 + "',入住人数='" + n4 + "',是否入住='" + n5 + "'where 房号='" + n1 + "'",
                    success: function (result) {
                        alert("修改成功！");
                    }
                })
                }
                else {
                    alert("对不起！您没有访问权限！")
                }
            })
            $("#rztj").click(function () {//入住添加
                if (id.substring(0, 2) == "00"){
                var n1 = $("#Text29").val();
                var n2 = $("#Text30").val();
                var n3 = $("#Text31").val();
                var n4 = $("#Text32").val();
                var n5 = $("#Text33").val();
                $.ajax({
                    type: "post",
                    url: "ygxgsc.aspx",//与员工修改删除使用同一个后台
                    datatype: "text",
                    data: "mas=insert into 入住数据表 values('" + n1 + "','" + n2 + "','" + n3 + "','" + n4 + "','" + n5 + "')",
                    success: function (result) {
                        alert("添加成功！");
                    }
                })
                }
                else {
                    alert("对不起！您没有访问权限！")
                }
            })
            $("#Button14").click(function () {//后勤信息查看
                if (id.substring(0, 2) == "00"){
                $.ajax({
                    type: "post",
                    url: "managelkt.aspx",
                    datatype: "text",
                    data: "key=select * from 后勤数据表",
                    success: function (result) {
                        var data1 = new Array();
                        data1 = result.split('|');
                        $("#div1").empty();
                        $("#div1").css("display", "block");
                        var title = $("<p font-size='xx-large' font-family='华文隶书' height='25px' >后勤数据表</p>");
                        var table1 = $("<table id='table1' border='2px' width='100%' text-align='center'><tr><td>日期</td><td>洗发露</td><td>沐浴露</td><td>牙膏</td><td>洁厕剂</td></tr>");
                        var but = $("<input type='button' id='daochu' value='导出' onclick=\"getImport('table1')\">")

                        $("#div1").append(title);
                        $("#div1").append(table1);
                        $("#div1").append(but);
                        for (var i = 0; i < data1.length - 1 ; i++) {

                            var data2 = data1[i].split(',');
                            var tr = $("<tr>");
                            var trend = $("</tr>");
                            tr.appendTo(table1);
                            for (var j = 0; j < 5; j++) {
                                var td = $("<td>" + data2[j] + "</td>");
                                td.appendTo(tr);

                            }

                            trend.append(table1);
                            $("#div1").append("</table>");
                        }
                    }
                })
                }
                else {
                    alert("对不起！您没有访问权限！")
                }
            })
            $("#Button19").click(function () {
                $("#div5").css("display", "none");
                $("#div6").css("display", "none");
                $("#div7").css("display", "none");
                $("#div8").css("display", "block");
            })
            $("#hqcx").click(function () {//后勤信息查询
                if (id.substring(0, 2) == "00") {
                    var x = $("#Text34").val();
                    $.ajax({
                        type: "post",
                        url: "managelkt.aspx",
                        datatype: "text",
                        data: "key=select * from 后勤数据表 where 日期='" + x + "'",
                        success: function (result) {
                            if (result == "") {
                                alert("没有找到该日期信息!");
                            }
                            var data1 = new Array();
                            data1 = result.split('|');
                            var data2 = data1[0].split(',');
                            $("#Text34").val(data2[0]);
                            $("#Text35").val(data2[1]);
                            $("#Text36").val(data2[2]);
                            $("#Text37").val(data2[3]);
                            $("#Text38").val(data2[4]);
                        }
                    })
                }
                else {
                    alert("对不起！您没有访问权限！")
                }
            })
            $("#hqsc").click(function () {//后勤信息删除
                if (id.substring(0, 2) == "00") {
                var x = $("#Text34").val();
                if (confirm("是否删除该后勤信息:" + x + "?")) {
                    $.ajax({
                        type: "post",
                        url: "ygxgsc.aspx",
                        datatype: "text",
                        data: "mas=delete from 后勤数据表 where 日期='" + x + "'",
                        success: function (result) {
                            alert("删除成功！");
                            $("#Text34").val("");
                            $("#Text35").val("");
                            $("#Text36").val("");
                            $("#Text37").val("");
                            $("#Text38").val("");
                        }
                    })
                }
                }
                else {
                    alert("对不起！您没有访问权限！")
                }
            })
            $("#hqxg").click(function () {//后勤修改
                if (id.substring(0, 2) == "00") {
                var n1 = $("#Text34").val();
                var n2 = $("#Text35").val();
                var n3 = $("#Text36").val();
                var n4 = $("#Text37").val();
                var n5 = $("#Text38").val();
                $.ajax({
                    type: "post",
                    url: "ygxgsc.aspx",//与员工修改删除使用同一个后台
                    datatype: "text",
                    data: "mas=update 后勤数据表 set 日期='" + n1 + "',洗发露='" + n2 + "',沐浴露='" + n3 + "',牙膏='" + n4 + "',洁厕剂='" + n5 + "'where 日期='" + n1 + "'",
                    success: function (result) {
                        alert("修改成功！");
                    }
                })
                }
                else {
                    alert("对不起！您没有访问权限！")
                }
            })
            $("#hqtj").click(function () {//后勤添加
                if (id.substring(0, 2) == "00") {
                var n1 = $("#Text34").val();
                var n2 = $("#Text35").val();
                var n3 = $("#Text36").val();
                var n4 = $("#Text37").val();
                var n5 = $("#Text38").val();
                $.ajax({
                    type: "post",
                    url: "ygxgsc.aspx",//与员工修改删除使用同一个后台
                    datatype: "text",
                    data: "mas=insert into 后勤数据表 values('" + n1 + "','" + n2 + "','" + n3 + "','" + n4 + "','" + n5 + "')",
                    success: function (result) {
                        alert(n1);
                        alert("添加成功！");
                    }
                })
                }
                else {
                    alert("对不起！您没有访问权限！")
                }
            })
            $("#Button2").click(function () {     //以下用于控制div的隐藏与显示
                $("#div1").css("display", "none");
            })
            $("#Button6").click(function () {
                $("#div2").css("display", "none");
                $("#div3").css("display", "none");
                $("#div4").css("display", "none");
            })
            $("#Button10").click(function () {
                $("#div1").css("display", "none");
            })
            $("#Button15").click(function () {
                $("#div5").css("display", "none");
                $("#div6").css("display", "none");
                $("#div7").css("display", "none");
                $("#div8").css("display", "none");
            })
            $("#Button20").click(function () {//员工考勤
                if (id.substring(0, 2) == "00") {
                    alert("考勤功能仅供员工使用！")
                }
                else {
                    var date = new Date();
                    var day = date.getDate();
                    var month = date.getMonth() + 1;
                    var year = date.getFullYear();
                    var hour = date.getHours();
                    var minute = date.getMinutes();
                    var xm = month + " " + day + " " + year;
                    var dm = year + "-" + month + "-" + day + " " + hour + ":" + minute;
                    var n2 = id;
                    var n3 = $("#fq").val();
                    $.ajax({
                        type: "post",
                        url: "kqbackon.aspx",
                        datatype: "text",
                        data: "日期=" + xm + "&工号=" + n2 + "&时间=" + dm + "&姓名=" + n3,
                        success: function (result) {
                            alert(result);
                        }
                    })
                }
                })

        })
        </script>
<body>
<div style="text-align:center;clear:both">
<script src="/gg_bd_ad_720x90.js" type="text/javascript"></script>
<script src="/follow.js" type="text/javascript"></script>
</div>
    
    <div id="page1"style="background-image:url(Images/back3.jpg);background-size:cover">
                <div id="Top" class="T" style="margin:0 auto">
    <div id="TurnLog" class="TL" >
        &nbsp;&nbsp;
        <a href="StaffLog.aspx"><b>返回登录界面</b></a>
        </div>
                    <div id="logoax" class="TR" style="float:right">
                        <b id="logoex"></b>
                         </div>
            </div>
        <div style="background-color:#646060;height:85px;margin:0 auto" class="T">
           
                <div style="width:187px; height: 30px;">
                <img src="Images/标题.png" style="height:85px; width: 195px;"/>&nbsp;&nbsp;
                    </div>
           </div>
  <div class="radmenu" id="menu"><a href="#" class="show" >
    <input id="Button1" type="button" value="管理信息" style="background-color:transparent ;width:136px;height:120px;border:hidden;cursor:pointer"/></a>
  <ul>
    <li>
      <a href="#" id="a1"><input style="background-color:transparent ;border:hidden;cursor:pointer;width:136px;height:120px;" id="Button2" type="button" value="酒店人员查看" /></a>
      <ul>
        <li><a href="#"><input style="background-color:transparent ;border:hidden;cursor:pointer;width:136px;height:120px;" id="Button3" type="button" value="查看注册客户"/></a></li>
        <li><a href="#"><input style="background-color:transparent ;border:hidden;cursor:pointer;width:136px;height:120px;" id="Button4" type="button" value="查看管理员" /></a></li>
        <li><a href="#"><input style="background-color:transparent ;border:hidden;cursor:pointer;width:136px;height:120px;" id="Button5" type="button" value="查看员工" /></a></li>
      </ul>
    </li>
    <li>
      <a href="#"><input style="background-color:transparent ;border:hidden;cursor:pointer;width:136px;height:120px;" id="Button6" type="button" value="酒店人员修改及删除"/></a>
      <ul>
        <li><a href="#" id="a2"><input style="background-color:transparent ;border:hidden;cursor:pointer;width:136px;height:120px;" id="Button7" type="button" value="客户信息"/></a></li>
        <li><a href="#"><input style="background-color:transparent ;border:hidden;cursor:pointer;width:136px;height:120px;" id="Button8" type="button" value="员工信息"/></a></li>
        <li><a href="#" id="a3"><input style="background-color:transparent ;border:hidden;cursor:pointer;width:136px;height:120px;" id="Button9" type="button" value="管理员信息"/></a></li>
      </ul>
    </li>
    <li>
      <a href="#" id="a4"><input style="background-color:transparent ;border:hidden;cursor:pointer;width:136px;height:120px;" id="Button10" type="button" value="酒店信息查看"/></a>
      <ul>
        <li><a href="#"><input style="background-color:transparent ;border:hidden;cursor:pointer;width:136px;height:120px;" id="Button11" type="button" value="部门信息"/></a></li>
        <li><a href="#"><input style="background-color:transparent ;border:hidden;cursor:pointer;width:136px;height:120px;" id="Button12" type="button" value="考勤信息"/></a></li>
        <li><a href="#"><input style="background-color:transparent ;border:hidden;cursor:pointer;width:136px;height:120px;" id="Button13" type="button" value="入住信息"/></a></li>
        <li><a href="#"><input style="background-color:transparent ;border:hidden;cursor:pointer;width:136px;height:120px;" id="Button14" type="button" value="后勤信息"/></a></li>
      </ul>
    </li>
    <li>
      <a href="#" id="a5"><input style="background-color:transparent ;border:hidden;cursor:pointer;width:136px;height:120px;" id="Button15" type="button" value="酒店信息修改及删除"/></a>
      <ul>
        <li><a href="#"><input style="background-color:transparent ;border:hidden;cursor:pointer;width:136px;height:120px;" id="Button16" type="button" value="部门信息"/></a></li>
        <li><a href="#"><input style="background-color:transparent ;border:hidden;cursor:pointer;width:136px;height:120px;" id="Button17" type="button" value="考勤信息"/></a></li>
        <li><a href="#"><input style="background-color:transparent ;border:hidden;cursor:pointer;width:136px;height:120px;" id="Button18" type="button" value="入住信息"/></a></li>
        <li><a href="#"><input style="background-color:transparent ;border:hidden;cursor:pointer;width:136px;height:120px;" id="Button19" type="button" value="后勤信息"/></a></li>
      </ul>
    </li>
     <li>
      <a href="#" id="ax"><input style="background-color:transparent ;border:hidden;cursor:pointer;width:136px;height:120px;" id="Button20" type="button" value="员工考勤"/></a>
    </li>
  </ul>
</div>
            <div id="div1" style="text-align:center;opacity:0.7;width:50%;margin-left:42%;margin-top:5%;display:none; background-color:#7decf7" >

            </div>
        <div id="div2" style="text-align:center;width:45%;margin-left:42%;margin-top:5%;display:none; background-color:rgba(140, 174, 122, 0.4);border-radius: 120px;">
            <%--客户信息修改删除--%>
            <p style="font-size:xx-large">&nbsp;<p style="font-size:xx-large"><strong>客户信息</strong><p style="font-size:xx-large">&nbsp;<p><b>姓名：&nbsp;&nbsp;&nbsp; </b><input id="Text1" type="text" />
            </p>
                <p><b>密码：&nbsp;&nbsp;&nbsp; </b><input id="Text2" type="text" /></p>
                <p><b>性别：&nbsp;&nbsp;&nbsp; </b><input id="Text3" type="text"/>
                <p><b>联系方式：</b><input id="Text4" type="tel" /></p>
                <p><b>身份证号码</b><input id="Text5" type="text"/></p>
            <p>&nbsp;</p>
            <input id="chaxun" type="button" value="查询"/>
                <input id="xiugai" type="button" value="修改信息" />
                <input id="shanchu" type="button" value="删除信息" />
            </div>
        <div id="div3" style="text-align:center;width:45%;margin-left:42%;margin-top:5%;border-radius: 120px;display:none ; background-color:rgba(140, 174, 122, 0.4)">
            <%--员工信息修改删除--%>
            <p style="font-size:xx-large">&nbsp;<p style="font-size:xx-large"><strong>员工信息</strong><p style="font-size:xx-large">&nbsp;<p><b>工号：&nbsp;&nbsp;&nbsp; </b><input id="Text6" type="text" /> </p>
                <p><b>部门号：&nbsp; </b><input id="Text7" type="text" /></p>
                <p><b>密码：&nbsp;&nbsp;&nbsp; </b><input id="Text8" type="text"/>
                <p><b>姓名：&nbsp;&nbsp;&nbsp; </b><input id="Text9" type="text"  /></p>
                <p><b>性别：&nbsp;&nbsp;&nbsp; </b><input id="Text10" type="text" />
           
                <p><b>身份证号码</b><input id="Text11" type="text" />
                <p><b>联系方式：</b><input id="Text12" type="tel"/>
           
                <p><b>家庭住址：</b><input id="Text13" type="text"/></p>
            <p>&nbsp;</p>
            <input id="ygcx" type="button" value="查询" />
                <input id="ygxg" type="button" value="修改信息" />
                <input id="ygsc" type="button" value="删除信息" />
                <input id="ygtj" type="button" value="添加信息" />

               
        </div>
         <div id="div4" style="text-align:center;width:45%;border-radius: 120px;margin-left:42%;margin-top:5%;display:none ; background-color:rgba(140, 174, 122, 0.4)">
            <%-- 管理员信息修改删除--%>
             <p style="font-size:xx-large">&nbsp;<p style="font-size:xx-large"><strong>管理员信息</strong><p style="font-size:xx-large">&nbsp;<p><b>工号：&nbsp;&nbsp;&nbsp; </b><input id="Text14" type="text"/> </p>
                <p><b>密码：&nbsp;&nbsp;&nbsp; </b><input id="Text15" type="text"/></p>
                <p><b>姓名：&nbsp;&nbsp;&nbsp; </b><input id="Text16" type="text"/>
                <p><b>性别：&nbsp;&nbsp;&nbsp; </b><input id="Text17" type="text" /></p>
                <p><b>出生日期：</b><input id="Text18" type="text"/>
                <p><b>身份证号码</b><input id="Text19" type="text"/>
                <p><b>联系方式：</b><input id="Text20" type="tel"/>
                <p><b>家庭住址：</b><input id="Text21" type="text"/></p>
             <p>&nbsp;</p>
            <input id="glycx" type="button" value="查询" />
                <input id="glyxg" type="button" value="修改信息" />
                <input id="glysc" type="button" value="删除信息" />
                <input id="glytj" type="button" value="添加信息" />
         </div>
         <div id="div5" style="text-align:center;width:45%;margin-left:42%;border-radius: 120px;margin-top:5%;display:none ; background-color:rgba(140, 174, 122, 0.4)">
             <%--部门信息修改删除--%>
             <p style="font-size:xx-large">&nbsp;<p style="font-size:xx-large"><strong>部门信息</strong><p style="font-size:xx-large">&nbsp;<p><b>部门号：&nbsp;&nbsp; </b><input id="Text22" type="text"/>
            </p>
                <p><b>部门名称：</b><input id="Text23" type="text"/></p>
                <p><b>部门人数：</b><input id="Text24" type="text"/>
                <p><b>简介：</b><textarea id="TA1"></textarea></p>
             <p>&nbsp;</p>
            <input id="bmcx" type="button" value="查询" />
                <input id="bmxg" type="button" value="修改信息" />
                <input id="bmsc" type="button" value="删除信息" />
                <input id="bmtj" type="button" value="添加信息" />
         </div>
         <div id="div6" style="text-align:center;width:45%;margin-left:42%;border-radius: 120px;margin-top:5%;display:none; background-color:rgba(140, 174, 122, 0.4)">
             <%--考勤信息修改删除--%>
             <p style="font-size:xx-large">&nbsp;<p style="font-size:xx-large"><strong>考勤信息</strong><p style="font-size:xx-large">&nbsp;<p><b>工号：</b><input id="Text25" type="text"/>
            </p>
                <p><b>时间：</b><input id="Text26" type="text"/></p>
                <p><b>姓名：</b><input id="Text27" type="text"/></p>
             <p>&nbsp;</p>
            <input id="kqcx" type="button" value="查询" />
                <input id="kqxg" type="button" value="修改信息" />
                <input id="kqsc" type="button" value="删除信息" />
                <input id="kqtj" type="button" value="添加信息" />
         </div>
         <div id="div7" style="text-align:center;width:45%;margin-left:42%;border-radius: 120px;margin-top:5%;display:none; background-color:rgba(140, 174, 122, 0.4)">
             <%--入住信息修改删除--%>
             <p style="font-size:xx-large">&nbsp;<p style="font-size:xx-large"><strong>入住信息</strong><p style="font-size:xx-large">&nbsp;<p><b>房号：&nbsp;&nbsp;&nbsp; </b><input id="Text29" type="text"/>
            </p>
                <p><b>日期：&nbsp;&nbsp;&nbsp; </b><input id="Text30" type="text"/></p>
                <p><b>入住人姓名</b><input id="Text31" type="text"/>
                <p><b>入住人数：</b><input id="Text32" type="text" /></p>
                <p><b>是否入住：</b><input id="Text33" type="text" /></p>
             <p>&nbsp;</p>
            <input id="rzcx" type="button" value="查询" />
                <input id="rzxg" type="button" value="修改信息" />
                <input id="rzsc" type="button" value="删除信息" />
                <input id="rztj" type="button" value="添加信息" />
         </div>
         <div id="div8" style="text-align:center;width:45%;margin-left:42%;margin-top:5%;border-radius: 120px;display:none; background-color:rgba(140, 174, 122, 0.4)">
             <%--后勤信息修改删除--%>
              <p style="font-size:xx-large">&nbsp;<p style="font-size:xx-large"><strong>后勤信息</strong><p style="font-size:xx-large">&nbsp;<p><b>日期：&nbsp;&nbsp; </b><input id="Text34" type="text"/>
            </p>
                <p><b>洗发露：</b><input id="Text35" type="text"/></p>
                <p><b>沐浴露：</b><input id="Text36" type="text"/>
                <p><b>牙膏：&nbsp;&nbsp; </b><input id="Text37" type="text" /></p>
                <p><b>洁厕剂：</b><input id="Text38" type="text" /></p>
             <p>&nbsp;</p>
            <input id="hqcx" type="button" value="查询" />
                <input id="hqxg" type="button" value="修改信息" />
                <input id="hqsc" type="button" value="删除信息" />
                <input id="hqtj" type="button" value="添加信息" />
         </div>
        <%--用于装员工姓名--%>
        <input id="fq" type="text" style="display:none"/>
        </div>
  <script src="js/index.js"></script>

</body>

</html>