using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class bookliston2 : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
        string condition = Request["mas"].Trim();
        string sa = new Class1().ajaxupper(condition);
        Response.Write(condition);
        Response.End();
    }
}