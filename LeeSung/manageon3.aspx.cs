using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class manageon3 : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
        string sa= new Class1().manageygck();
        Response.Write(sa);
        Response.End();
    }
}