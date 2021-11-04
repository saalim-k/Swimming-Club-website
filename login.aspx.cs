using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data;
using System.Data.SqlClient;
using System.Configuration;
using System.Diagnostics;

namespace GroupAss
{
    public partial class login : System.Web.UI.Page
    {
        SqlConnection conn = new SqlConnection(ConfigurationManager.ConnectionStrings["SwimmClubCon"].ConnectionString);
        protected void Page_Load(object sender, EventArgs e)
        {
            HttpCookie UserInfo = Request.Cookies["UserInfo"];
            if(UserInfo != null)
            {
                Debug.WriteLine("Cookie is not null");
                Session["Username"] = UserInfo["Username"];
                Session["Password"] = UserInfo["Password"];
                Session["isAdmin"] = UserInfo["isAdmin"];

            }
            if(Session["Username"]!=null && Session["Password"]!=null && Session["isAdmin"]!=null)
            {
                Debug.WriteLine("Session exists");
                try
                {
                    conn.Open();
                    SqlCommand cmd = new SqlCommand("SELECT * FROM [Account] WHERE Username=@username and Password=@password ", conn);
                    cmd.Parameters.AddWithValue("@username", Session["Username"].ToString());
                    cmd.Parameters.AddWithValue("@password", Session["Password"].ToString());
                    SqlDataReader dr = cmd.ExecuteReader();
                    if (dr.HasRows)
                    {
                        while(dr.Read())
                        {
                            Debug.WriteLine("Has Rows");
                            if (Convert.ToInt32(dr["isBlocked"]) == 1)
                            {
                                if (UserInfo != null)
                                {
                                    UserInfo.Expires.AddDays(-1);
                                }
                                Session.Clear();
                                conn.Close();
                                throw new Exception("Your Account is blocked!!");
                            }
                            else
                            {
                                if (Convert.ToInt32(dr["isAdmin"]) == 0)
                                {
                                    conn.Close();
                                    Response.Redirect("~/news.aspx",false);
                                }
                                else
                                {
                                    conn.Close();
                                    Response.Redirect("~/maintenance.aspx",false);
                                }
                            }
                        }
                        
                    }
                    conn.Close();
                }
                catch(Exception ex)
                {
                    lblErrorMessage.Text = "Error" + ex.ToString();
                }
            }
            
        }

        protected void btnLogin_Click(object sender, EventArgs e)
        {
            try
            {
                conn.Open();
                SqlCommand cmd = new SqlCommand("SELECT * FROM [Account] WHERE Username=@username and Password=@password ", conn);
                cmd.Parameters.AddWithValue("@username", Username.Text);
                cmd.Parameters.AddWithValue("@password", Password.Text);
                SqlDataReader dr = cmd.ExecuteReader();
                if (dr.HasRows)
                {
                    Debug.WriteLine("has record");
                    while (dr.Read())
                    {
                        Debug.WriteLine("While has executed");
                        if (Convert.ToInt32(dr["isBlocked"]) == 1)
                        {
                            throw new Exception("You cannot login since you are blocked!!");
                        }
                        else
                        {
                            if(RememberMe.Checked==true)
                            {
                                HttpCookie cookieUserInfo = new HttpCookie("UserInfo");
                                cookieUserInfo["Username"] = dr["Username"].ToString();
                                cookieUserInfo["Password"] = dr["Password"].ToString();
                                cookieUserInfo["isAdmin"] = dr["isAdmin"].ToString();
                                Response.Cookies.Add(cookieUserInfo);
                                cookieUserInfo.Expires = DateTime.Now.AddDays(30);
                                Debug.WriteLine(cookieUserInfo["Username"]);
                                Debug.WriteLine(cookieUserInfo["Password"]);
                                Debug.WriteLine(cookieUserInfo["isAdmin"]);
                                Session["Username"] = dr["Username"].ToString();
                                Session["Password"] = dr["Password"].ToString();
                                Session["isAdmin"] = dr["isAdmin"].ToString();
                            }
                            else
                            {
                                Session["Username"] = dr["Username"].ToString();
                                Session["Password"] = dr["Password"].ToString();
                                Session["isAdmin"] = dr["isAdmin"].ToString();
                            }
                            conn.Close();
                            if (Convert.ToInt32(Session["isAdmin"])==0)
                            {
                                Response.Redirect("~/news.aspx",false);
                            }
                            else
                            {
                                Response.Redirect("~/maintenance.aspx",false);
                            }
                        }
                    }
                    conn.Close();
                }
                else
                {
                    lblErrorMessage.Text = "Username and password dont match";
                }
            }
            catch(Exception ex)
            {
                lblErrorMessage.Text = "Error" + ex.ToString();
            }
        }

        protected void btnNext1_Click(object sender, EventArgs e)
        {
            logForgPage.ActiveViewIndex = 1;
        }

        protected void btnNextShowQuestions_Click(object sender, EventArgs e)
        {
            lblSecQuest.Visible = true;
            DataList1.Visible = true;
            lblsecAns.Visible = true;
            Sec_Ans.Visible = true;
            btnSubmitSecAns.Visible = true;
        }

        protected void btnSubmitSecAns_Click(object sender, EventArgs e)
        {
            conn.Open();
            SqlCommand cmd = new SqlCommand("SELECT * FROM [Account] WHERE Username=@username and Sec_Ans=@ans ", conn);
            cmd.Parameters.AddWithValue("@username", txtUsername.Text);
            cmd.Parameters.AddWithValue("@ans", Sec_Ans.Text);
            SqlDataReader dr = cmd.ExecuteReader();
            bool recordfound = dr.Read();
            if (recordfound)
            {
                logForgPage.ActiveViewIndex = 2;
                lblYourUsername.Text = dr["Username"].ToString();
                conn.Close();
                txtUsername.Text = "";
                lblSecQuest.Visible = false;
                DataList1.Visible = false;
                lblsecAns.Visible = false;
                Sec_Ans.Visible = false;
                btnSubmitSecAns.Visible = false;
                lblErrSecAns.Text = "";
            }
            else
            {
                lblErrSecAns.Text = "Answer does not match or incorrect username";
                
            }
        }

        protected void btnConfirm_Click(object sender, EventArgs e)
        {
            try
            {
                conn.Open();
                SqlCommand cmd = new SqlCommand("Update Account SET Password=@pass WHERE Username=@un ", conn);
                cmd.Parameters.AddWithValue("@un", lblYourUsername.Text);
                cmd.Parameters.AddWithValue("@pass", TextBox1.Text);
                cmd.ExecuteNonQuery();
                conn.Close();
                lblYourUsername.Text = "";
                Sec_Ans.Text = "";
                Response.Write("<script>alert('Password was successfully changed');</script>");
                logForgPage.ActiveViewIndex = 0;
                
            }
            catch(Exception ex)
            {
                lblErrUpdatePass.Text = "Error" + ex.ToString();
            }
        }

        protected void btnCancelNGobacktoLogin_Click(object sender, EventArgs e)
        {
            txtUsername.Text = "";
            Sec_Ans.Text = "";
            lblSecQuest.Visible = false;
            DataList1.Visible = false;
            lblsecAns.Visible = false;
            Sec_Ans.Visible = false;
            btnSubmitSecAns.Visible = false;
            lblYourUsername.Text = "";
            logForgPage.ActiveViewIndex = 0;
        }
    }
    
}