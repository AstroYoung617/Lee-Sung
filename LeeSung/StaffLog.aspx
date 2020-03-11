<%@ Page Language="C#" AutoEventWireup="true" CodeFile="StaffLog.aspx.cs" Inherits="StaffLog" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head id="Head1" runat="server">
<meta http-equiv="Content-Type" content="text/html; charset=utf-8"/>
    <title>LeeSung员工登陆</title>
</head>
     <script lang="ja" type="text/javascript" src="Scripts/jquery-1.8.2.js">

        </script>
    <script>
            $(function(){
                $(document).keydown(function(event){
                    if(event.keyCode==13){
                        $("#Button1").click();
                    }
                })

            $("#Text1").insertBefore(function () {
                if ($("#Text1").val().trim().length() == "")
                    alert("请输入工号！");
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
                var sf1 = $("#Radio1:Checked").val();
                var sf2 = $("#Radio2:Checked").val();
                var sf;
                if (sf1 == "on") {
                    sf = "管理员表";
                }
                if (sf2 == "on") {
                    sf = "员工表";
                }
                $.ajax({
                    type: "post",
                    url: "StaffLogon.aspx",
                    datatype: "text",
                    data: "工号=" + name + "&密码=" + psw+"&表类型="+sf,
                    success: function (result) {
                        if (result == 1) {
                            alert("登录成功！");
                            var s = document.getElementById("Text1");
                            window.location.href = "manage.aspx?"+"txt="+encodeURI(s.value)}
                        else
                            alert("姓名或密码错误！");
                    }

                })
            })
        })
        </script>
    <link rel="stylesheet"type="text/css"href="exes.css"/>
<body style="background-image:url(Images/bullet.png)" >
    <form id="form1" runat="server">
        <div class="T">
       <p class="pf"> &nbsp;&nbsp; 选择您的身份：<a href="log.aspx"style="font-family:微软雅黑">客户</a>&nbsp; <a href="StaffLog.aspx"style="font-family:微软雅黑">员工</a></p>
        </div>
       <div style="background-image:url('Images/backlog.jpg');background-repeat:no-repeat;background-size:cover; height: 918px; width: 1300px;">
       <div id="enroll"style="text-align:center;margin-right:38% ;margin-top:10%"class="aa">
           <h2>员工登录</h2>
           <p class="pf">工号：</p>
           <p class="pf">&nbsp;<input id="Text1" type="text" autofocus="autofocus" placeholder="请输入工号！"/></p>
           <p class="pf">密码：</p>
           <p class="pf">&nbsp;<input id="Pa1" type="password" placeholder="请输入密码！"/></p>
           <p class="pf">身份：</p>
           <p class="pf" style="text-align:center">&nbsp;<input id="Radio1" type="radio" name="xb" checked="checked"/>管理员&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; <input id="Radio2" type="radio" name="xb"/>员工</p>
           <p >
               <input class="but" id="Button1" type="button" value="登录"  onmouseover="this.style.color='yellow'" onmouseout="this.style.color='blue'"/></p>
       </div>
           </div>
    </form>
</body>
</html>