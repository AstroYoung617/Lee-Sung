using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class bookliston3 : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
        string com = Request["mo"].Trim();
        string sam = new Class1().ajaxreturn2(com);
        Response.Write(sam);
        Response.End();
    }
}