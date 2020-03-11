using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class managelkt : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
        string condi = Request["key"].Trim();
        Class1 myc = new Class1();
        string sa = myc.lookthrough(condi);
        Response.Write(sa);
        Response.End();
    }
}