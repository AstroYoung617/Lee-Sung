<%@ Page Language="C#" AutoEventWireup="true" CodeFile="booklist.aspx.cs" Inherits="booklist" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
<meta http-equiv="Content-Type" content="text/html; charset=utf-8"/>
<link rel="stylesheet"type="text/css"href="exes.css"/>
    <title>欢迎来到LeeSung</title>
    <link rel="stylesheet" href="css/reset.css">

    <link rel="stylesheet" href="css/style.css" media="screen" type="text/css" />
</head>
    
    <script src="Scripts/index.js">
        </script>
    <script lang="ja" type="text/javascript" src="Scripts/jquery-1.8.2.js">

        </script><%--应用jq--%>
    <script lang="ja" type="text/ecmascript"><%--导出--%>
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
</script>
    <script>
        var loc = location.href;
        var n1 = loc.length;
        var n2 = loc.indexOf("=");
        var id = decodeURI(loc.substr(n2 + 1, n1 - n2));
        $(document).ready(function () {


            var x = "否";
            $.ajax({
                type: "post",
                url: "bookliston.aspx",
                datatype: "text",
                data: "key='" + x + "'",
                success: function (result) {
                    var data1 = new Array();
                    data1 = result.split('|');
                    $("#div1").empty();
                    $("#div4").css("display", "none");
                    $("#div3").css("display", "none");
                    $("#div2").css("display", "none");
                    $("#div1").css("display", "block");
                    var title = $("<p font-size='xx-large' font-family='华文隶书' >剩余房间表</p>");
                    var table1 = $("<table id='table1' border='1px' width='100%' text-align='center'>");
                    $("#div1").append(title);
                    $("#div1").append(table1);

                    for (var i = 0; i < data1.length ; i++) {

                        var data2 = data1[i].split(',');
                        var tr = $("<tr>");
                        var trend = $("</tr>");
                        tr.appendTo(table1);
                        for (var j = 0; j < 2; j++) {
                            var td = $("<td>" + data2[j] + "</td>");
                            td.appendTo(tr);

                        }

                        trend.append(table1);
                        $("#div1").append("</table>");
                    }

                    var select1 = $("<select id='Select1' >")
                    $("#px").empty();
                    $("#px").append(select1);
                    for (var i = 1; i < data1.length; i++) {
                        var data2 = data1[i].split(',');
                        var op = $("<option>" + data2[0] + "</option>");
                        op.appendTo(select1);
                    }

                    $("#px").append("</select>");

                    //$("#Select1").css("width", "80px");
                    //$("#Select1").css("height", "35px");

                }
            })


            $.ajax({
                type: "post",
                url: "bookliston4.aspx",
                datatype: "text",
                data: "key=入住人姓名='" + id + "'",
                success: function (result) {
                    var data1 = new Array();
                    data1 = result.split('|');
                    $("#div1").empty();
                    $("#div1").css("display", "block");
                    var title = $("<p font-size='xx-large' font-family='华文隶书' >您的订房信息</p>");
                    var table1 = $("<table id='table1' border='1px' width='100%' text-align='center'>");
                    $("#div1").append(title);
                    $("#div1").append(table1);
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
                    var select1 = $("<select id='Select2' >")
                    $("#py").empty();
                    $("#py").append(select1);
                    for (var i = 1; i < data1.length; i++) {
                        var data2 = data1[i].split(',');
                        var op = $("<option>" + data2[0] + "</option>");
                        op.appendTo(select1);
                    }

                    $("#py").append("</select>");
                }
            })
            $("#Text3").val(id);
                $("#logoex").append("欢迎您，用户：" + id);
           
        })
        $(function () {
            $("#Button1").click(function () {//个人主页
                $("#div1").css("display", "none");
                $("#div2").css("display", "none");
                $("#div3").css("display", "block");
                $("#div4").css("display", "none");
                $.ajax({
                    type: "post",
                    url: "kehuchange.aspx",
                    datatype: "text",
                    data: "key=姓名='"+id+"'",
                    success: function (result) {
                        var data1 = new Array();
                        data1 = result.split('|');
                        var data2 = data1[1].split(',');
                        $("#div2").css("display", "none");
                        $("#Text5").val(data2[0]);
                        $("#Text6").val(data2[1]);
                        $("#Text8").val(data2[2]);
                        $("#Text7").val(data2[3]);
                        $("#Text9").val(data2[4]);
                    }
                })

            })
            $("#geren").click(function () {
                $.ajax({
                    type: "post",
                    url: "bookliston3.aspx",
                    datatype: "text",
                    data: "mo=入住人姓名='" + id + "'",
                    success: function (result) {
                        var data1 = new Array();
                        data1 = result.split('|');
                        $("#div1").empty();
                        $("#div1").css("display", "block");
                        var title = $("<p font-size='xx-large' font-family='华文隶书' >您的订房信息</p>");
                        var table1 = $("<table id='table1' border='1px' width='100%' text-align='center'>");
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
            })
            $("#Button2").click(function () {//修改客户信息
                var n1 = $("#Text5").val();//姓名
                var n2 = $("#Text6").val();//密码
                var n3 = $("#Text8").val();//性别
                var n4 = $("#Text7").val();//联系方式
                var n5 = $("#Text9").val();//身份证号码
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
            })
            $("#Bu3").click(function () {//查看剩余房间
                var x = "否";
                $.ajax({
                    type: "post",
                    url: "bookliston.aspx",
                    datatype: "text",
                    data: "key='"+x+"'",
                    success: function (result) {
                        var data1 = new Array();
                        data1 = result.split('|');
                        $("#div1").empty();
                        $("#div4").css("display", "none");
                        $("#div3").css("display", "none");
                        $("#div2").css("display", "none");
                        $("#div1").css("display", "block");
                        var title = $("<p font-size='xx-large' font-family='华文隶书' >剩余房间表</p>");
                        var table1 = $("<table id='table1' border='1px' width='100%' text-align='center'>");
                        var but = $("<input type='button' id='daochu' value='导出' onclick=\"getImport('table1')\">")
                        $("#div1").append(title);
                        $("#div1").append(table1);
                        $("#div1").append(but);
                        for (var i = 0; i < data1.length ; i++) {

                            var data2 = data1[i].split(',');
                            var tr = $("<tr>");
                            var trend = $("</tr>");
                            tr.appendTo(table1);
                            for (var j = 0; j < 2; j++) {
                                var td = $("<td>" + data2[j] + "</td>");
                                td.appendTo(tr);

                            }

                            trend.append(table1);
                            $("#div1").append("</table>");
                        }
                        
                        var select1 = $("<select id='Select1' >")
                        $("#px").empty();
                        $("#px").append(select1);
                        for (var i = 1; i < data1.length; i++)
                        {
                            var data2 = data1[i].split(',');
                            var op = $("<option>" + data2[0] + "</option>");
                            op.appendTo(select1);
                        }

                        $("#px").append("</select>");

                        //$("#Select1").css("width", "80px");
                        //$("#Select1").css("height", "35px");
                        
                    }
                })
            })
            $("#Bu4").click(function () {
                $("#div1").css("display", "none");
                $("#div3").css("display", "none");
                $("#div2").css("display", "block");
                $("#div4").css("display", "none");
                

            })
            $("#Button4").click(function () {//预定房间
                var n1 = $("#Select1").val();
                var n2 = $("#Text2").val();
                var n3 = $("#Text3").val();
                var n4 = $("#Text4").val();
                var n5 = "是";
                $.ajax({

                    type: "post",
                    url: "bookliston2.aspx",
                    datatype: "text",
                    data: "mas=日期='" + n2 + "',入住人姓名='" + n3 + "',入住人数='" + n4 + "',是否入住='" + n5 + "'where 房号='" + n1 + "'",
                    success: function (result) {
                        alert("预订成功！");
                    }
                })
               
            })
            $("#Bu5").click(function () {
                $("#div3").css("display", "none");
                $("#div2").css("display", "none");
                $("#div1").css("display", "none");
                $("#div4").css("display", "block");
            })
            $("#Button3").click(function () {//退订房间
                var n1 = $("#Select2").val();
                var n2 = "否";
                $.ajax({
                    type: "post",
                    url: "ygxgsc.aspx",
                    datatype: "text",
                    data: "mas=update 入住数据表 set 日期=" +null+ ",入住人姓名=" +null+ ",入住人数=" +null+ ",是否入住='" +n2+ "'where 房号='" + n1 + "'",
                    success: function (result) {
                        alert("退订成功！");
                        //有问题
                    }
                })
            })
            $("#Button5").click(function () {
                var n1 = $("#Select2").val();
                $.ajax({
                    type: "post",
                    url: "managelkt.aspx",
                    datatype: "text",
                    data: "key=select * from 入住数据表 where 房号='" + n1 + "'",
                    success: function (result) {
                        var data1 = new Array();
                        data1 = result.split('|');
                        var data2 = data1[0].split(',');
                        $("#Text10").val(data2[1]);
                        $("#Text11").val(data2[2]);
                        $("#Text12").val(data2[3]);
                    }
                })
            })

            })
            

    </script><%--功能实现--%>
  

<body>
    <form id="form1" runat="server" style="padding-left:20px;padding-right:20px">
    <div id="page1" style="background-image:url(img/demo-2-bg.jpg);background-size:cover">
        <div id="Top" class="T" style="margin:0 auto">
    <div id="TurnLog" class="TL" >
        <a href="log.aspx"><b>返回登录界面</b></a>
        </div>
            <div id="name" style="float:right">
                
                       <div id="logoax"  style="float:right">
                        <b id="logoex"></b>
                         
                   <input style="font-family:黑体;background-color:transparent;border:hidden" id="Button1" type="button" value="个人主页" />
                           </div>
                </div>
            </div>
        <div style="background-color:#646060;height:85px;margin:0 auto" class="T">
           
               
                <img src="Images/标题.png" style="height:85px; width: 195px;"/>&nbsp;&nbsp;
                       <span style="width:1300px;text-align:right;font-family:黑体;font-size:2em;font-style:italic">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp&nbsp;&nbsp;&nbsp; 丽桑酒店竭诚为您服务！</span>

            </div>
                               <div class="radmenu" id="menu">
                           <a href="#" class="show" >
    <input id="Bu1" type="button" value="欢迎进入LeeSung" style="background-color:transparent ;border:hidden;cursor:pointer"/></a>
  <ul>
    <li>
      <a href="#" class=""><input id="Bu2" type="button" value="管理信息" style="background-color:transparent ;border:hidden;cursor:pointer;width:136px;height:120px;"/></a>
      <ul>
        <li><a href="#"><input id="Bu3" type="button" value="查看余房" style="background-color:transparent ;border:hidden;cursor:pointer;width:136px;height:120px;"/></a></li>
        <li><a href="#"><input id="Bu4" type="button" value="预定房间" style="background-color:transparent ;border:hidden;cursor:pointer;width:136px;height:120px;"/></a></li>
        <li><a href="#"><input id="Bu5" type="button" value="退订房间" style="background-color:transparent ;border:hidden;cursor:pointer;width:136px;height:120px;"/></a></li>
      </ul>
    </li>
  </ul>
</div>
            <div id="div1" style="text-align:center;opacity:0.7;width:50%;margin-left:42%;margin-top:5%;display:none; background-color:#7decf7">

            </div>
            <div style="text-align:center;width:32%;margin-left:42%;margin-top:5%;border-radius: 120px;display:none; background-color:rgba(140, 174, 122, 0.4)" id="div2">
                <p style="font-size:xx-large">&nbsp;<p style="font-size:xx-large"><strong>客房预订</strong></p></p><br/>
                <p><b >房号：</b><br /><br /><span id="px"></span></p>

                <p><b >日期：</b><br />
                <input id="Text2" type="text" /><br /></p>
                <p><b >入住人昵称：</b><br />
                <input id="Text3" type="text" readonly="true"style="background-color:#999999" /><br /></p>
                <p><b >入住人数：</b><br />
                <input id="Text4" type="text" /><br /></p>
<%--                <p><b class="bf">是否入住：</b><br />
                <input id="Text5" type="text" /><br /></p>--%>
                <br/>
                <input id="Button4" type="button" value="预定"/><br />
                <br/>
            </div>
            <div style="text-align:center;width:45%;margin-left:42%;margin-top:5%;border-radius: 120px;display:none; background-color:rgba(140, 174, 122, 0.4)" id="div3">
                <p style="font-size:xx-large">&nbsp;</p>
                <h2 style="font-size:x-large">个人信息</h2>
               <p style="font-size:xx-large">&nbsp;</p>
                <p><b>客户昵称：</b><input id="Text5" type="text" readonly="true"style="background-color:#999999" /></p>
                <p><b>客户密码：</b><input id="Text6" type="text" /></p>
                <p><b>客户性别：</b><input id="Text8" type="text"readonly="true"style="background-color:#999999"/>
                <p><b>联系方式：</b><input id="Text7" type="tel" /></p>
                <p><b>身份证号码</b><input id="Text9" type="text"readonly="true"style="background-color:#999999"/></p>
                <input id="geren" type="button" value="查看已定" />
                <input id="Button2" type="button" value="修改信息" />
            </div>
            <div style="text-align:center;width:32%;margin-left:42%;margin-top:5%;border-radius: 120px;display:none; background-color:rgba(140, 174, 122, 0.4)" id="div4">
                  <p style="font-size:xx-large">&nbsp;<p style="font-size:xx-large"><strong>客房退订</strong></p></p><br/>
                <p><b >房号：</b><br /><br /><span id="py"></span></p>
                <br/>
                <input id="Button5" type="button" value="查询" />

                <p><b >日期：</b><br />
                <input id="Text10" type="text" readonly="true" style="background-color:#999999" /><br /></p>
                <p><b >入住人昵称：</b><br />
                <input id="Text11" type="text" readonly="true" style="background-color:#999999" /><br /></p>
                <p><b >入住人数：</b><br />
                <input id="Text12" type="text" readonly="true" style="background-color:#999999" /><br /></p>
<%--                <p><b class="bf">是否入住：</b><br />
                <input id="Text5" type="text" /><br /></p>--%>
                <br/>
                <input id="Button3" type="button" value="退订"/><br />

            </div>
    </div>
    </form>
      <script src="js/index.js"></script>
</body>
</html>
