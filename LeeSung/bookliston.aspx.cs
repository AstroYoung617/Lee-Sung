using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class bookliston : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
        string condi = Request["key"].Trim();
        string res = new Class1().ajaxreturn(condi);
        Response.Write(res);
        Response.End();
    }
}