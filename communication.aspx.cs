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
using System.Text;

namespace GroupAss
{
    public partial class communication : System.Web.UI.Page
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
            if (Session["Username"] == null )
            {
                Response.Redirect("~/login.aspx");
            }
            BindForum();
        }
        private void BindForum()
        {
            conn.Open();

            SqlCommand cmd = new SqlCommand("SELECT * FROM [Forum]", conn);
            SqlDataAdapter sda = new SqlDataAdapter();
            {
                cmd.Connection = conn;
                sda.SelectCommand = cmd;
                using (DataTable dt = new DataTable())
                {
                    sda.Fill(dt);
                    dlForum.DataSource = dt;
                }
                dlForum.DataBind();
                conn.Close();
            }
        }
        protected void Clear() 
        {
            txtTitle.Text = "";
            txtContent.Text = "";
        }

        protected void btnSave_Click(object sender, EventArgs e)
        {
            if (FileUploadForum.HasFile)
            {
                try
                {
                    string filename = Path.GetFileName(FileUploadForum.PostedFile.FileName);
                    FileUploadForum.PostedFile.SaveAs(Server.MapPath("~/Files/") + filename);
                    conn.Open();
                    string User = Session["Username"].ToString();
                    SqlCommand cmd = new SqlCommand("INSERT INTO [FORUM] (Username,ForumTitle,ForumText,ForumFile,ForumDate,ForumTime) values ('" + User + "',@title,@content,@filename,@date,@time)", conn);
                    {
                        cmd.Parameters.AddWithValue("@title", txtTitle.Text);
                        cmd.Parameters.AddWithValue("@content", txtContent.Text);
                        var time24 = DateTime.Now.ToString("HH:mm:ss");
                        string today = DateTime.Now.ToString("d/M/yyyy");
                        cmd.Parameters.AddWithValue("@date", today);
                        cmd.Parameters.AddWithValue("@time", time24);
                        cmd.Parameters.AddWithValue("@filename", "Files/" + filename);
                        cmd.ExecuteNonQuery();
                    }
                    Response.Write("<script>alert('Profile Updated Successfully!');</script>");
                    Clear();
                    conn.Close();
                }
                catch (Exception ex)
                {
                    lblStatus.Text = "Unsuccessful update! The following error occurred" + ex.Message;
                    lblStatus.ForeColor = System.Drawing.Color.Red;
                }
            }
            else
            {
                if (conn.State == ConnectionState.Closed)
                {
                    conn.Open();
                    string User = Session["Username"].ToString();
                    SqlCommand cmd = new SqlCommand("INSERT INTO [FORUM] (Username,ForumTitle,ForumFile,ForumText,ForumDate,ForumTime) values ('" + User + "',@title,@file,@content,@date,@time)", conn);
                    cmd.Parameters.AddWithValue("@file", "");
                    cmd.Parameters.AddWithValue("@title", txtTitle.Text);
                    cmd.Parameters.AddWithValue("@content", txtContent.Text);
                    var time24 = DateTime.Now.ToString("HH:mm:ss");
                    string today=DateTime.Now.ToString("d/M/yyyy");
                    cmd.Parameters.AddWithValue("@date", today);
                    cmd.Parameters.AddWithValue("@time", time24);
                    cmd.ExecuteNonQuery();
                    Clear();
                    Response.Write("<script>alert('Forum Added Successfully!');</script>");
                }
                conn.Close();
            }
        }

        protected void btnClear_Click(object sender, EventArgs e)
        {
            Clear();
        }
    }
}

