<%@ Page Language="C#" AutoEventWireup="true" CodeFile="regist.aspx.cs" Inherits="regist" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml" style="width:1360px">
<head runat="server">
<meta http-equiv="Content-Type" content="text/html; charset=utf-8"/>
    <title>LeeSung酒店</title>
    <script type="text/javascript">
        </script>
    <link rel="stylesheet"type="text/css"href="exes.css"/>
</head>
    <script lang="ja" type="text/javascript" src="Scripts/jquery-1.8.2.js">
        </script>

    <script>
        $(function () {
            $(document).keydown(function (event) {
                if (event.keyCode == 13) {
                    $("#Button1").click();
                }
            })
            $("#Button1").click(function () {
                var n1 = $("#Text1").val();
                var n2 = $("#Password1").val();
                var n3 = $("#Password2").val();
                var n5 = $("#Text4").val();
                var n6 = $("#Text5").val();
                var xb1 = $("#Radio1:Checked").val();
                var xb2 = $("#Radio2:Checked").val();
                var xb;

                if (n1.length > 6)
                {
                    alert("姓名不能超过6位");
                }
                if (n2 != n3)
                {
                    alert("密码与确认密码不一致！");
                    $("Password1").val()="";
                    $("Password2").val()="";
                }
                if (xb1 == "on") {
                    xb = "男";
                }
                if (xb2 = "on") {
                    xb = "女";
                }
                if (n1.trim() == "" || n2.trim() == "" || n3.trim() == "" || n6.trim() == "")
                {
                    alert("信息不能为空");
                }
                else {
                    $.ajax({
                        type: "post",
                        url: "login.aspx",
                        datatype: "text",
                        data: "key='" + n1 + "','" + n2 + "','" + xb + "','" + n5 + "','" + n6 + "'",
                        success: function (result) {
                            alert(result);
                            window.location.href = "log.aspx";

                        }
                    })
                }
            })

        })
        </script>

<body >
    
    <form id="form1" runat="server" style="padding-left:20px;padding-right:20px">
        <div id="page1">
        <div id="Top" class="T" >
    <div id="TurnLog" class="TL">
        
        &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; <img src="Images/orderedList1.png" id="img1"/> <a href="log.aspx" style="font-family:微软雅黑" >登录到LeeSung</a>
    </div>
            </div>
            <div id="Formal" style=" background-image:url(Images/back.jpg); background-repeat:no-repeat;height:1000px; width: 1304px;" >
           
                            <div id="Reform" style="background-color:#ebe6e6;border-style:hidden; border-color: inherit; width:300px; float:right; height: 615px; right:5px;padding:6px;opacity:.68; margin-right:2%; margin-top:2%; ">
                                <br/>
                                &nbsp;&nbsp; <strong><span>即刻加入<a href="login.aspx">LeeSung<sup>TM</sup></a>享受绝佳住宿体验，为您带来五星级酒店服务的同时，让您爱上<a href="login.aspx">LeeSung<sup>TM</sup></a>。</span></strong>
                                <p class="pf"><b class="bf">&nbsp;&nbsp; *</b>昵称:&nbsp;<br/><input id="Text1" type="text" autofocus="autofocus" placeholder="请输入2-5位汉字，若重复则加上数字！"/><br/> </p>
                              
                                <p class="pf"><b class="bf">&nbsp;&nbsp; *</b>密码:&nbsp;<br/><input id="Password1" type="password" style="background-color:#999999" placeholder="请输入16位以下字符或数字"/><br/> </p>
                                
                                <p class="pf"><b class="bf">*</b>确认密码:<br/><input id="Password2" type="password" placeholder="请再次输入密码！"/><br/></p>
                               
                                <p class="pf"> &nbsp; 性别:<br/>
                                    &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
                                    <input id="Radio1" type="radio" name="xb" checked="checked"/> 男&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; <input id="Radio2" type="radio" name="xb"/> 女</p>
                               
                                <p class="pf">&nbsp; 联系方式:
                                <input id="Text4" type="tel" style="background-color:#999999"/><br/>
                                </p>
                               
                                <p class="pf"><b class="bf">*</b>身份证号:
                                <input id="Text5" type="text" /><br/></p>
                                <p style="text-align:center">
                                    <input class="but" id="Button1" type="button" value="立即加入" style="border: 2px solid;" onmouseover="this.style.color='yellow'" onmouseout="this.style.color='blue'"/>
                                </p>

                                                                       
                </div>
                </div>

        </div>
    </form>
</body>
</html>
