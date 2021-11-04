using System;
using System.Data.SqlClient;
using System.Data;
using System.Configuration;
using System.Web.UI;
using System.Text.RegularExpressions;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI.WebControls;

namespace GroupAss
{
    public partial class member : System.Web.UI.MasterPage
    {
        SqlConnection conn = new SqlConnection(ConfigurationManager.ConnectionStrings["SwimmClubCon"].ConnectionString);
        protected void Page_Load(object sender, EventArgs e)
        {
            if (Session["Username"] == null)
            {
               
                login.Visible = true;
                register.Visible = true;

            }
            else if((Session["Username"] !=null) && (Convert.ToInt32(Session["isAdmin"])==0))
            {
                profile.Visible = true;
                news.Visible = true;
                catalouge.Visible = true;
                cart.Visible = true;
                support.Visible = true;
                lbLogout.Visible = true;
                forum.Visible = true;
            }
            else if((Session["Username"] != null) && (Convert.ToInt32(Session["isAdmin"])==1))
            {
                profile.Visible = true;
                maintenance.Visible = true;
                forum.Visible = true;
                lbLogout.Visible = true;

            }
        }

        protected void lbLogout_Click(object sender, EventArgs e)
        {
            Session.Clear();
            if(Response.Cookies["UserInfo"] != null)
            {
                HttpCookie cookie = Request.Cookies["UserInfo"];
                cookie.Expires = DateTime.Now.AddDays(-1);
                Response.Cookies.Add(cookie);
            }
            
            Response.Redirect("~/Default.aspx",false);
        }
    }
}