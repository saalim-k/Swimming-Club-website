using System;
using System.Data.SqlClient;
using System.Data;
using System.Configuration;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Diagnostics;
using System.IO;

namespace GroupAss
{
    public partial class profile : System.Web.UI.Page
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
            if (!IsPostBack)
            {
                BindGridGetUserAccount();

                if (mvProfile.ActiveViewIndex == 0)
                {
                    BindGridDisplayUserInfo();
                }
                else if (mvProfile.ActiveViewIndex == 1)
                {
                    BindGridGetUserAccount();
                }
            }

        }

        protected void btnSaveChanges_Click(object sender, EventArgs e)
        {
            if (imageBrowse.HasFile)
            {
                try
                {
                    if (imageBrowse.PostedFile.ContentType == "image/jpeg")
                    {
                        if (imageBrowse.PostedFile.ContentLength < 1000000)
                        {
                            string filename = Path.GetFileName(imageBrowse.FileName);
                            imageBrowse.SaveAs(Server.MapPath("~/Images/ProfilePic/") + filename);
                            lblStatus.Text = "File uploaded!";
                            lblStatus.ForeColor = System.Drawing.Color.Green;
                            conn.Open();
                            string User = Session["Username"].ToString();
                            SqlDataAdapter da = new SqlDataAdapter();
                            SqlCommand cmd = new SqlCommand("UPDATE [AccountInfo] SET ProfileImage= '" + filename + "', Fname=@fname, Lname=@lname, Email=@email, ContactNo=@contact, Address=@address, Gender=@gender, Dob=@DOB WHERE Username= '" + User + "'", conn);
                            {                              
                                cmd.Parameters.AddWithValue("@fname", txtFirstName.Text);
                                cmd.Parameters.AddWithValue("@lname", txtLastName.Text);
                                cmd.Parameters.AddWithValue("@email", txtEmail.Text);
                                cmd.Parameters.AddWithValue("@address", txtAddress.Text);
                                cmd.Parameters.AddWithValue("@contact", txtContact.Text);
                                cmd.Parameters.AddWithValue("@DOB",txtDOB.Text);
                                string gender = rblGender.SelectedValue.ToString();
                                if (gender == "F")
                                {
                                    cmd.Parameters.AddWithValue("@gender", gender);
                                    txtGender.Text = "Female";
                                }
                                else if (gender == "M")
                                {
                                    cmd.Parameters.AddWithValue("@gender", gender);
                                    txtGender.Text = "Male";
                                }

                                da.UpdateCommand = cmd;
                                da.UpdateCommand.ExecuteNonQuery();
                            }
                            Response.Write("<script>alert('Profile Updated Successfully!');</script>");
                            cmd.Dispose();
                            conn.Close();
                            Response.AppendHeader("Refresh", "0;url=profile.aspx");
                        }
                        else
                        {
                            Response.Write("<script>alert('Image to Large!');</script>");
                        }

                    }
                    else
                    {
                        Response.Write("<script>alert('Image has to be in JPG/JPEG format!');</script>");
                       

                    }


                }

                catch (Exception ex)
                {
                    lblStatus.Text = "Upload Unsuccessful! The following error occurred" + ex.Message;
                    lblStatus.ForeColor = System.Drawing.Color.Red;
                }
            }
            else {
                try
                {
                    conn.Open();
                    string User = Session["Username"].ToString();
                    SqlCommand cmd = new SqlCommand("UPDATE [AccountInfo] SET Fname=@fname, Lname=@lname, Email=@email, ContactNo=@contact, Address=@address, Dob=@DOB, Gender=@gender WHERE Username= '" + User + "'", conn);
                    {
                        Debug.WriteLine(txtFirstName.Text);
                        cmd.Parameters.AddWithValue("@fname", txtFirstName.Text);
                        cmd.Parameters.AddWithValue("@lname", txtLastName.Text);
                        cmd.Parameters.AddWithValue("@email", txtEmail.Text);
                        cmd.Parameters.AddWithValue("@address", txtAddress.Text);
                        cmd.Parameters.AddWithValue("@contact", txtContact.Text);
                        cmd.Parameters.AddWithValue("@DOB", txtDOB.Text);
                        string gender = rblGender.SelectedValue.ToString();
                        if (gender == "F")
                        {
                            cmd.Parameters.AddWithValue("@gender", gender);
                            txtGender.Text = "Female";
                        }
                        else if (gender == "M")
                        {
                            cmd.Parameters.AddWithValue("@gender", gender);
                            txtGender.Text = "Male";
                        }
                        else
                        {

                            cmd.Parameters.AddWithValue("@gender", txtGender.Text.Substring(0, 1));
                        }
                        cmd.ExecuteNonQuery();
                    }
                    Response.Write("<script>alert('Profile Updated Successfully!');</script>");
                    cmd.Dispose();
                    conn.Close();
                }
                catch(Exception ex)
                {
                    lblStatus.Text = ex.ToString();
                }
                
            }
                
        }

        protected void BindGridDisplayUserInfo()
        {
            string User = Session["Username"].ToString();
            conn.Open();
            SqlCommand cmd = new SqlCommand("SELECT * FROM [AccountInfo] WHERE Username= '" + User + "'", conn);
            SqlDataReader dr = cmd.ExecuteReader();
            bool recordFound = dr.Read();
            if (recordFound)
            {
                txtUsername.Text = dr["Username"].ToString();
                txtFirstName.Text = dr["Fname"].ToString();
                txtLastName.Text = dr["Lname"].ToString();
                txtEmail.Text = dr["Email"].ToString();
                txtAddress.Text = dr["Address"].ToString();
                txtContact.Text = dr["ContactNo"].ToString();
                txtDOB.Text = dr["Dob"].ToString();
                string gender = dr["Gender"].ToString();
                Debug.WriteLine(".." + gender + "..");
                if (gender == "F")
                {
                    txtGender.Text = "Female";
                    rblGender.SelectedValue = "F";
                }
                else
                {
                    txtGender.Text = "Male";
                    rblGender.SelectedValue = "M";
                }
                imgProd.ImageUrl = "~/Images/ProfilePic/" + dr["ProfileImage"].ToString();
                Debug.WriteLine(imgProd.ImageUrl);
                conn.Close();
            }
        }

        protected void BindGridGetUserAccount()
        {
            string User = Session["Username"].ToString();
            conn.Open();
            SqlCommand cmd = new SqlCommand("SELECT * FROM [Account] WHERE Username= '" + User + "'", conn);
            SqlDataReader dr = cmd.ExecuteReader();
            bool recordFound = dr.Read();
            if (recordFound)
            {
                txtSecurityQ.Text = dr["Sec_Ques"].ToString();
                lblStatusSec.Visible = false;
            }
            conn.Close();
        }

        protected void getSecurityQ()
        {
            string User = Session["Username"].ToString();
            conn.Open();
            SqlCommand cmd = new SqlCommand("SELECT * FROM [Account] WHERE Username= '" + User + "'", conn);
            SqlDataReader dr = cmd.ExecuteReader();
            bool recordFound = dr.Read();
            if (recordFound)
            {
                txtSecurityQ.Text = dr["Sec_Ques"].ToString();
                if (txtSecurityA.Text == dr["Sec_Ans"].ToString())
                {
                    divPassword.Visible = true;
                    lblStatusSec.Visible = false;
                }
                else
                {
                    lblStatusSec.Visible = true;
                    lblStatusSec.ForeColor = System.Drawing.Color.Red;
                }
            }
            conn.Close();
        }

        protected void btnCalendar_Click(object sender, EventArgs e)
        {
            if (calendar.Visible == false) 
            {
                calendar.Visible = true;
            }
            else
            {
                calendar.Visible = false;
            }
        }

        protected void calendar_SelectionChanged(object sender, EventArgs e)
        {
            txtDOB.Text = calendar.SelectedDate.Day + "/" + calendar.SelectedDate.Month + "/" + calendar.SelectedDate.Year;
            
            calendar.Visible = false;
        }

        protected void btnSubmit_Click(object sender, EventArgs e)
        {
            getSecurityQ();
        }

        protected void Clear()
        {
            txtCurrentPass.Text = "";
            txtNewPass.Text = "";
            txtSecurityA.Text = "";
        }

        protected void btnChange_Click(object sender, EventArgs e)
        {
            string User = Session["Username"].ToString();
            string currentPass = Session["Password"].ToString();
            if (txtCurrentPass.Text == currentPass)
            {
                conn.Open();
                string UpdatePass = "UPDATE [Account] SET Password=@newPass WHERE Username='" + User + "'";
                SqlCommand update = new SqlCommand(UpdatePass, conn);
                update.Parameters.AddWithValue("@newPass", txtNewPass.Text);
                update.ExecuteNonQuery();
                Session["Password"] = txtNewPass.Text;
                HttpCookie cookie = Response.Cookies["Username"];
                if (cookie["Username"] != null)
                {
                    cookie["Username"] = Session["Username"].ToString();
                    cookie["Password"] = txtNewPass.Text;
                    cookie["isAdmin"] = Session["isAdmin"].ToString();
                    Response.Cookies.Add(cookie);
                }
                Response.Write("<script>alert('Change Password Successful!');</script>");
                divPassword.Visible = false;
                mvProfile.ActiveViewIndex = 0;
                Clear();
                conn.Close();
            }
            else
            {
                Response.Write("<script>alert('Change Password Unsuccessful!');</script>");
                Clear();
                divPassword.Visible = false;
            }
        }

        protected void btnBack_Click(object sender, EventArgs e)
        {
            Clear();
            divPassword.Visible = false;
            mvProfile.ActiveViewIndex = 0;
        }

        protected void calendar_DayRender(object sender, DayRenderEventArgs e)
        {
                if (e.Day.Date > DateTime.Today)
                {
                    e.Day.IsSelectable = false;

                }
        }
    }
}