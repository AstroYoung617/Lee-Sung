using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data;
using System.Data.Sql;
using System.Data.SqlClient;

public partial class kqbackon : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
        string rq = Request["日期"].Trim();
        string gh = Request["工号"].Trim();
        string sj = Request["时间"].Trim();
        string xm = Request["姓名"].Trim();
        string sql = "select count(*) from 考勤表 where left(时间,10)='" + rq + "'and 工号='" + gh +"'";
        Class1 myc = new Class1();
        DataTable t = myc.gettable(sql);
        if (t.Rows[0][0].ToString() == "1")
        {
            Response.Write("您今天已经签到过了！");
            Response.End();
        }
        else if (t.Rows[0][0].ToString() == "0")
        {
            string sqm = "insert into 考勤表 values('" + sj + "','" + gh + "','" + xm + "')";
            Class1 myc1 = new Class1();
            myc1.noquery(sqm);
            Response.Write("签到成功");
            Response.End();
        }
    }
}