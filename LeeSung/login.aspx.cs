using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data;
using System.Data.SqlClient;

public partial class login : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
        string condi = Request["key"].Trim();
        Class1 myc1=new Class1();
         string[] data;
        data=condi.Split(',');
        DataTable t = myc1.gettable("select count(*)  from 客户表 where 姓名="+data[0]);
        if (t.Rows[0][0].ToString() != "0")
        {
            Response.Write("姓名已存在！");
            Response.End();
        }
        else
        {
            Class1 myc = new Class1();
            string sql = "insert into 客户表(姓名,密码,性别,联系方式,身份证号码)values(" + condi + ")";
            myc.noquery(sql);
            Response.Write("注册成功！");
            Response.End();
        }
    }
}