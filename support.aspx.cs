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
    public partial class ServicesAndSupport : System.Web.UI.Page
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
            if (Session["Username"] == null || Convert.ToInt32(Session["isAdmin"]) == 1)
            {
                Response.Redirect("~/login.aspx");
            }
            if (!this.IsPostBack)
            {
                lblMsg.Visible = false;
                this.BindGrid();
                ddlFAQ.DataSource = SqlDataSourceFAQ;
                ddlFAQ.DataBind();

                ListItem myDefaultItem = new ListItem("Select a category", string.Empty);
                myDefaultItem.Selected = true;
                ddlFAQ.Items.Insert(0, myDefaultItem);
            }

        }
        private void BindGrid()
        {
            string constr = ConfigurationManager.ConnectionStrings["SwimmClubCon"].ConnectionString;
            
            using (SqlConnection conn = new SqlConnection(constr))
            {
                using (SqlCommand cmd = new SqlCommand("SELECT FeedbackDesc,Date,Time FROM [Feedback] WHERE Username=@username"))
                {
                    cmd.Parameters.AddWithValue("@username", Session["Username"].ToString());
                    using (SqlDataAdapter sda = new SqlDataAdapter())
                    {
                        cmd.Connection = conn;
                        sda.SelectCommand = cmd;
                        using (DataTable dt = new DataTable())
                        {
                            sda.Fill(dt);
                            GridViewFeed.DataSource = dt;
                            GridViewFeed.DataBind();
                        }
                    }

                }
            }
        }

        private void BindGrid2()
        {
            lblMsg.Visible = true;
            string constr = ConfigurationManager.ConnectionStrings["SwimmClubCon"].ConnectionString;
            using (SqlConnection conn = new SqlConnection(constr))
            {
                using (SqlCommand cmd = new SqlCommand("SELECT FaqQuestion,FaqAnswer FROM [FAQ] WHERE FaqSearchTerm=@faqsearchterm "))
                {
                    string search = ddlFAQ.SelectedValue.ToString();
                    cmd.Parameters.AddWithValue("@faqsearchterm", search);
                    using (SqlDataAdapter sda = new SqlDataAdapter())
                    {
                        cmd.Connection = conn;
                        sda.SelectCommand = cmd;
                        using (DataTable dt = new DataTable())
                        {
                            
                            sda.Fill(dt);
                            GridViewFAQ.DataSource = dt;
                            GridViewFAQ.DataBind();

                            if (dt.Rows.Count == 0)
                            {
                                lblMsg.Text = "No records found...";
                                lblMsg.ForeColor = System.Drawing.Color.Red;
                            }
                            else
                            {
                                lblMsg.Text = "Records found!";
                                lblMsg.ForeColor = System.Drawing.Color.Green;
                            }
                        }
                    }

                }
            }
        }

        protected void GridViewFeed_PageIndexChanging(object sender, GridViewPageEventArgs e)
        {
            GridViewFeed.PageIndex = e.NewPageIndex;
            BindGrid();
        }
        protected void mnFeatures_MenuItemClick(object sender, MenuEventArgs e)
        {
            int index = Int32.Parse(e.Item.Value);
            mvMenu.ActiveViewIndex = index;
        }

        protected void btnFeed_Click(object sender, EventArgs e)
        {
            try
            {
                if (conn.State == ConnectionState.Closed)
                {
                    conn.Open();
                    
                        string insert = "INSERT INTO Feedback(FeedbackDesc,Date,Time,Username)values(@desc,@date,@time,@username)";
                        SqlCommand com = new SqlCommand(insert, conn);
                        //@desc,@date,@time,@username

                        com.Parameters.AddWithValue("@desc", tbFeed.Text);
                        com.Parameters.AddWithValue("@date", DateTime.Now.ToString("MM/dd/yyyy"));
                        com.Parameters.AddWithValue("@time", DateTime.Now.ToString("h:mm tt"));
                        com.Parameters.AddWithValue("@username", Session["Username"].ToString());
                        com.ExecuteNonQuery();

                        Response.Write("<script>alert('Feedback added successfully!');</script>");
                        Response.AppendHeader("Refresh", "0;url=support.aspx");
                        conn.Close();
                   
                    }
                
            }
            catch (Exception ex)
            {
                lblResult.Text = "Error: " + ex.ToString();
                lblResult.ForeColor = System.Drawing.Color.Red;
            }

        }

        protected void ddlFAQ_SelectedIndexChanged(object sender, EventArgs e)
        {
            BindGrid2();
        }

        protected void btnFAQ_Click(object sender, EventArgs e)
        {
            lblMsg.Visible = true;
            
            string constr = ConfigurationManager.ConnectionStrings["SwimmClubCon"].ConnectionString;
            
            using (SqlConnection conn = new SqlConnection(constr))
            {
               
                    using (SqlCommand cmd = new SqlCommand("SELECT FaqQuestion,FaqAnswer FROM [FAQ] WHERE FaqQuestion LIKE '%'+@keyword+'%' "))
                {
                   
                    cmd.Parameters.AddWithValue("@keyword", tbFAQ.Text);
                    
                    using (SqlDataAdapter sda = new SqlDataAdapter())
                    {

                        cmd.Connection = conn;
                        sda.SelectCommand = cmd;
                        
                        using (DataTable dt = new DataTable())
                        {
                            
                            sda.Fill(dt);
                            GridViewFAQ.DataSource = dt;
                            GridViewFAQ.DataBind();
                            if (dt.Rows.Count == 0)
                            {
                                lblMsg.Text = "No records found...";
                                lblMsg.ForeColor = System.Drawing.Color.Red;
                            }
                            else
                            {
                                lblMsg.Text = "Records found!";
                                lblMsg.ForeColor = System.Drawing.Color.Green;
                            }
                        }
                        
                        
                    }
                    
                }
                conn.Close();
            }
            
        }

       
    }
}