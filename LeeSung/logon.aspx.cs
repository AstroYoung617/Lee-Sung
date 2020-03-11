using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data;
using System.Data.Sql;
using System.Data.SqlClient;
public partial class logon : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
        string name = Request["姓名"].Trim();
        string psw = Request["密码"].Trim();
        string sql = "select count(*) from 客户表 where 姓名='" + name + "'and 密码='" + psw + "'";
        Class1 myc = new Class1();
        DataTable t = myc.gettable(sql);
        if (t.Rows[0][0].ToString() == "0")
        {
            Response.Write("0");
            Response.End();
        }
        else
        {
            Response.Write("1");
            Response.End();
        }
    }
}