using System;
using System.Data.SqlClient;
using System.Data;
using System.Configuration;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.IO;

namespace GroupAss
{
    public partial class viewforum : System.Web.UI.Page
    {
        SqlConnection conn = new SqlConnection(ConfigurationManager.ConnectionStrings["SwimmClubCon"].ConnectionString);
        protected void Page_Load(object sender, EventArgs e)
        {
            HttpCookie cookieUserInfo = Request.Cookies["UserInfo"];
            if (cookieUserInfo != null)
            {
                Session["Username"] = cookieUserInfo["Username"];
                Session["Password"] = cookieUserInfo["Password"];
                Session["isAdmin"] = cookieUserInfo["isAdmin"];
            }
            if (Session["Username"] == null)
            {
                Response.Redirect("~/login.aspx");
            }
            if (Request.QueryString["ForumID"]==null)
            {
                Response.Redirect("~/communication.aspx");
            }
            else
            {
                if (!IsPostBack)
                {
                    BindGridForumInfo();
                    BindGridReplies();
                }
                else {
                    BindGridReplies();
                }
            }
            
        }

        protected void lbDownload_Click(object sender, EventArgs e)
        {

            string filePath = (sender as LinkButton).CommandArgument;
            Response.ContentType = ContentType;
            Response.AppendHeader("Content-Disposition", "attachment; filename=" + Path.GetFileName(filePath));
            Response.WriteFile(filePath);
            Response.End();
        }

        protected void btnReply_Click(object sender, EventArgs e)
        {
            divforumReply.Visible = true;
        }

        protected void btnEnter_Click(object sender, EventArgs e)
        {
            if (conn.State == ConnectionState.Closed)
            {
                conn.Open();
                string User = Session["Username"].ToString();
                string ForID = Request.QueryString["ForumID"];
                SqlCommand cmd = new SqlCommand("INSERT INTO [FORUMREPLY] (Username,ForumReplyText,ForumReplyDate,ForumReplyTime,ForumID) values ('" + User + "',@content,@date,@time,'" + ForID + "')", conn);
                cmd.Parameters.AddWithValue("@content", txtReply.Text);
                var time24 = DateTime.Now.ToString("HH:mm:ss");
                string today = DateTime.Now.ToString("d/M/yyyy");
                cmd.Parameters.AddWithValue("@date", today);
                cmd.Parameters.AddWithValue("@time", time24);
                cmd.ExecuteNonQuery();
                conn.Close();
                clear();
                btnCancel_Click(sender, e);
                Page_Load(sender, e);
            }

        }

        protected void BindGridReplies()
        {
           
            conn.Open();
            string ForID = Request.QueryString["ForumID"];
            SqlCommand cmd = new SqlCommand("SELECT * FROM [FORUMREPLY] WHERE ForumID='" + ForID + "'", conn);
            SqlDataAdapter sda = new SqlDataAdapter();
            {
                cmd.Connection = conn;
                sda.SelectCommand = cmd;
                using (DataTable dt = new DataTable())
                {
                    sda.Fill(dt);
                    dlReplies.DataSource = dt;
                    dlReplies.DataBind();
                }

                conn.Close();
            }
        }


        protected void BindGridForumInfo()
        {
            conn.Open();
            string ForID = Request.QueryString["ForumID"];
            SqlCommand cmd = new SqlCommand("SELECT * FROM [Forum] WHERE ForumID='" + ForID + "'", conn);
            SqlDataAdapter sda = new SqlDataAdapter();
            {
                cmd.Connection = conn;
                sda.SelectCommand = cmd;
                using (DataTable dt = new DataTable())
                {
                    sda.Fill(dt);
                    dlViewForum.DataSource = dt;
                    dlViewForum.DataBind();
                    foreach(DataListItem item in dlViewForum.Items)
                    {
                        LinkButton lbDownload = (LinkButton)item.FindControl("lbDownload");
                        Label lblisHaveFile = (Label)item.FindControl("lblisHaveFile");
                        Label lblFilename = (Label)item.FindControl("lblFilename");
                        if(lblFilename.Text=="")
                        {
                            lblFilename.Visible = false;
                            lblisHaveFile.Visible = true;
                            lbDownload.Visible = false;
                        }
                    }
                }
                
                conn.Close();
            }
        }
        private void clear()
        {
            txtReply.Text = "";
        }

        protected void btnCancel_Click(object sender, EventArgs e)
        {
            clear();
            divforumReply.Visible = false;
        }
    }
}