<%@ Page Language="C#" AutoEventWireup="true" CodeFile="log.aspx.cs" Inherits="log" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
<meta http-equiv="Content-Type" content="text/html; charset=utf-8"/>
    <title>欢迎登录到LeeSung</title>
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
            $("#sd").click(function () {
                alert("123");
                window.location.href = "regist.aspx"
            })
            $("#Text1").insertBefore(function () {
                if ($("#Text1").val().trim().length() == "")
                    alert("请输入昵称！");
                $("#Text1").val() = "";
            })
            $("#Pa1").insertBefore(function () {
                if ($("#Pa1").val().trim().length() == "")
                    alert("请输入密码！");
                $("#Pa1").val() = "";
            })
            $("#Button1").click(function () {
                var name = $("#Text1").val();
                var psw = $("#Pa1").val();
                $.ajax({
                    type: "post",
                    url:"logon.aspx",
                    datatype: "text",
                    data: "姓名=" + name + "&密码=" + psw,
                    success: function (result) {
                        $("#Text3").val(result);
                        
                        if (result == 1)
                        {
                            alert("登录成功！");
                            var s = document.getElementById("Text1");
                            window.location.href = "booklist.aspx?"+"txt="+encodeURI(s.value)}
                        else
                            alert("姓名或密码错误！");
                    }

                })
            })
        })
        </script>
    <link rel="stylesheet"type="text/css"href="exes.css"/>
<body style="background-image:url(Images/bullet.png)">
    <form id="form1" runat="server">
   <div>
        <div class="T">
       <p class="pf"> 选择您的身份：<a href="log.aspx"style="font-family:微软雅黑">客户</a>&nbsp; <a href="StaffLog.aspx"style="font-family:微软雅黑">员工</a></p>
            <a href="regist.aspx" style="position:absolute; top: 20px; left: 1225px;">退出登录</a>
        </div>
       <div style="background-image:url('Images/33.jpg'); background-repeat:no-repeat; height: 918px; width: 1300px;">
       <div id="enroll" style="text-align:center;margin-right:38% ;margin-top:10%;height:300px"class="aa" >
           <h2>用户登录</h2>
           <p class="pf"><b class="bf">*</b>昵称：</p>
           <p class="pf">&nbsp;<input id="Text1" type="text" autofocus="autofocus" placeholder="请输入昵称！"/></p>
           <p class="pf"><b class="bf">*</b>密码：</p>
           <p class="pf">&nbsp;<input id="Pa1" type="password" placeholder="请输入密码！"/>
           </p>
           <p >
               <input class="but" id="Button1" type="button" value="登录" style="background-color:#606cf3" onmouseover="this.style.color='yellow'" onmouseout="this.style.color='blue'"/></p>
       </div>
       </div>
       </div>
    </form>
</body>
</html>
