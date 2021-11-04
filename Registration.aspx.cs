using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data;
using System.Data.SqlClient;
using System.Configuration;
namespace GroupAss
{
    public partial class Registration : System.Web.UI.Page
    {
        SqlConnection conn = new SqlConnection(ConfigurationManager.ConnectionStrings["SwimmClubCon"].ConnectionString);

        protected void Page_Load(object sender, EventArgs e)
        {

        }
        private void BindGrid()
        {
            try
            {
                conn.Open();
                SqlCommand cmd = new SqlCommand("Insert INTO Account (Username, Password, Sec_Ques, Sec_Ans,isAdmin,isBlocked) Values (@Username, @Password, @Sec_Ques, @Sec_Ans,0,0)", conn);
                SqlCommand amd = new SqlCommand("Insert INTO AccountInfo (Username, Fname, Lname, Dob, ContactNo, Email, Gender, Address) Values (@Username, @Fname, @Lname, @Dob, @ContactNo, @Email, @Gender, @Address)", conn);
                {
                    cmd.Parameters.AddWithValue("@Username", txtUsername.Text);
                    cmd.Parameters.AddWithValue("@Password", Password.Text);
                    string Sec_Ques = ddlSec_Ques.SelectedValue.ToString();
                    cmd.Parameters.AddWithValue("@Sec_Ques", Sec_Ques);
                    cmd.Parameters.AddWithValue("@Sec_Ans", Sec_Ans.Text);
                    cmd.ExecuteNonQuery();
                    conn.Close();
                    conn.Open();
                    amd.Parameters.AddWithValue("@Username", txtUsername.Text);
                    amd.Parameters.AddWithValue("@Fname", Fname.Text);
                    amd.Parameters.AddWithValue("@Lname", Lname.Text);
                    string datOB = Dob.Text.Replace("-","/");
                    amd.Parameters.AddWithValue("@Dob", datOB);
                    amd.Parameters.AddWithValue("@ContactNo", ContactNo.Text);
                    amd.Parameters.AddWithValue("@Email", Email.Text);
                    string Gender = rblGender.SelectedValue.ToString();
                    amd.Parameters.AddWithValue("@Gender", Gender);
                    amd.Parameters.AddWithValue("@Address", Address.Text);
                    Response.Write("<script>alert('Your Account has been Registred! Go to the login Page to login');</script>");
                    amd.ExecuteNonQuery();
                    conn.Close();
                    Clear();
                }
            }
            catch (Exception ex)
            {
                lblRegError.Text = "Error" + ex.ToString();
            }


        }

        protected void CreateUser_Click(object sender, EventArgs e)
        {
            BindGrid();
        }
        private void Clear()
        {
            txtUsername.Text = "";
            Fname.Text = "";
            Lname.Text = "";
            Dob.Text = "";
            ContactNo.Text = "";
            Email.Text = "";
            rblGender.SelectedIndex = -1;
            Address.Text = "";
            lblRegError.Text = "";
        }
    }
}