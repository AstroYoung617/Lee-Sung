using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class kehushac : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
        string sql = Request["key"];
        Class1 myc = new Class1();
        myc.noquery(sql);
        Response.End();
    }
}