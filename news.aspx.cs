using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data;
using System.Data.SqlClient;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace GroupAss
{
    public partial class NewsAnnouncements : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            HttpCookie cookieUserInfo = Request.Cookies["UserInfo"];
            if (cookieUserInfo != null)
            {
                Session["Username"] = cookieUserInfo["Username"];
                Session["Password"] = cookieUserInfo["Password"];
                Session["isAdmin"] = cookieUserInfo["isAdmin"];
            }
            if (Session["Username"] == null || (Convert.ToInt32(Session["isAdmin"]) == 1))
            {
                Response.Redirect("~/login.aspx");
            }
            if (!this.IsPostBack)
            {
                this.BindGrid();
            }
        }
        private void BindGrid()
        {
            string constr = ConfigurationManager.ConnectionStrings["SwimmClubCon"].ConnectionString;
            using(SqlConnection conn= new SqlConnection(constr))
            {
                using(SqlCommand cmd= new SqlCommand("SELECT NewsID, NewsImage,NewsDesc,NewsDate,NewsTime FROM [News]"))
                {
                    using(SqlDataAdapter sda= new SqlDataAdapter())
                    {
                        cmd.Connection = conn;
                        sda.SelectCommand = cmd;
                        using(DataTable dt=new DataTable())
                        {
                            sda.Fill(dt);
                            GridViewNews.DataSource = dt;
                            GridViewNews.DataBind();
                        }
                    }

                }
            }
        }
        protected void GridViewNews_PageIndexChanging(object sender,GridViewPageEventArgs e)
        {
            GridViewNews.PageIndex = e.NewPageIndex;
            BindGrid();
        }
    }
}