<%@ Page Language="C#" AutoEventWireup="true" CodeFile="worker.aspx.cs" Inherits="worker" %>

<!DOCTYPE html>

<html lang="en" class="no-js"><head>
<meta charset="UTF-8">
<meta http-equiv="X-UA-Compatible" content="IE=edge"> 
<title></title>
    <link rel="stylesheet" href="css/bootstrap-table.css">
    <script type="text/javascript" src="Scripts/bootstrap-table.js"></script>
    <script type="text/javascript" src="Scripts/jquery-1.8.2.min.js"></script>
    <script>
        $(document).ready(function () {
            $("#table1").bootstrapTable({
                columns: [{
                    field: 'xm',
                    title: '姓名',
                }, {
                    field: 'mm',
                    title: '密码'
                }, {
                    field: 'xb',
                    title: '性别'
                }, {
                    field: 'lxfs',
                    title: '联系方式'
                }, {
                    field: 'sfzhm',
                    title: '身份证号码'
                }, ]
            });
        });
        </script>
</head>
<body>
    <table id="table1" data-pagination="true" data-side-pagination="client" data-page-size="3"><tr><td>姓名</td><td>密码</td><td>性别</td><td>联系方式</td><td>身份证号码</td></tr><tr><td>阿斯顿马丁</td><td>6545614</td><td>男</td><td>11354984655</td><td>1231654984894654</td></tr><tr><td>阿仲小龙</td><td>123456789</td><td>女</td><td>18465165132</td><td>561565498415615</td></tr><tr><td>滴答</td><td>kjljkl</td><td>男</td><td>1325645641</td><td>32135154641321</td></tr><tr><td>高手</td><td>123456</td><td>男</td><td>23156464894</td><td>3156156456489</td></tr><tr><td>龚大方</td><td>123456</td><td>男</td><td>23156465465</td><td>32165489456456</td></tr><tr><td>狗蛋</td><td>123456789</td><td>男</td><td>18156123156</td><td>561654561321322</td></tr><tr><td>韩栋</td><td>123456</td><td>男</td><td>18456465461</td><td>231564894651323</td></tr><tr><td>黄瓜</td><td>123456</td><td>男</td><td>15816351335</td><td>354984894156152</td></tr><tr><td>李大方</td><td>123456</td><td>女</td><td>18516546212</td><td>561651561561234</td></tr><tr><td>李杰</td><td>123456</td><td>女</td><td>18561231325</td><td>456165156156415</td></tr><tr><td>李萌萌</td><td>123456</td><td>女</td><td>18200565120</td><td>510781199707205008</td></tr><tr><td>李阳</td><td>1354654</td><td>男</td><td>5649843151</td><td>5346548945313</td></tr><tr><td>刘三刀</td><td>4564456</td><td>男</td><td>546545133</td><td>213546845456451</td></tr><tr><td>秦桧</td><td>123456</td><td>男</td><td>15548946542</td><td>231564658413212</td></tr><tr><td>十大</td><td>5212</td><td>男</td><td>322</td><td>545</td></tr><tr><td>小强</td><td>123456</td><td>女</td><td>11845645312</td><td>1564564864541453</td></tr><tr><td>杨大哥</td><td>123456</td><td>女</td><td>18200564512</td><td>561658132135456413</td></tr><tr><td>杨宇航</td><td>51354864</td><td>男</td><td>18256519846</td><td>65168451516846</td></tr><tr><td>杨玉环</td><td>123456</td><td>男</td><td>18200564548</td><td>2316549845612354</td></tr><tr><td>张大千</td><td>1654564651</td><td>女</td><td>15648465151</td><td>531531351313512</td></tr><tr><td>张东方</td><td>123456</td><td>男</td><td>18200565531</td><td>21365468465454</td></tr><tr><td>张芳</td><td>123456</td><td>女</td><td>18521564156</td><td>231564561321232</td></tr><tr><td>张桂芳</td><td>123456</td><td>女</td><td>18165132121</td><td>5105620651651958</td></tr><tr><td>张飒</td><td>123456</td><td>男</td><td>18564684768</td><td>231651464984655</td></tr><tr><td>张稀哲</td><td>123456789</td><td>女</td><td>18542313542</td><td>543213548643515</td></tr><tr><td>张云仲</td><td>123456</td><td>女</td><td>18281561500</td><td>513215684984561</td></tr><tr><td>彰武</td><td>135454</td><td>男</td><td>23165498456</td><td>321651654654564564</td></tr><tr><td>朱飞</td><td>123456</td><td>男</td><td>18426551215</td><td>12564586654545</td></tr><tr><td>猪猪</td><td>123456</td><td>男</td><td>18521265456</td><td>216541654865454</td></tr></table>
</body></html>