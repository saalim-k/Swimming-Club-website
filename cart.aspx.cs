using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data;
using System.Data.SqlClient;
using System.Diagnostics;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace GroupAss
{
    public partial class cart : System.Web.UI.Page
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
            if (Session["Username"]==null || Convert.ToInt32(Session["isAdmin"])==1)
            {
                Response.Redirect("~/login.aspx");
            }
            if(!this.IsPostBack)
            {
                BindCartGrid();
            }
        }
        private void BindCartGrid()
        {
            string Username = Session["Username"].ToString();
            conn.Open();
            SqlCommand cmd = new SqlCommand("SELECT Cart.*,Product.ProductDescription,Product.ProductPrice,Product.ProductName,Product.ProductImage,Product.ProductPrice*Cart.Quantity AS total FROM [Cart],[Product] WHERE Cart.Username=@Un AND Cart.ProductID=Product.ProductID", conn);
            SqlDataAdapter sda = new SqlDataAdapter();
            {
                cmd.Parameters.AddWithValue("@Un", Username);
                sda.SelectCommand = cmd;
                using (DataTable dt = new DataTable())
                {
                    sda.Fill(dt);
                    gvMyCart.DataSource = dt;
                    gvMyCart.DataBind();
                }
                conn.Close();
                Decimal totalCost = 0;
                for(int i=0;i<gvMyCart.Rows.Count;i++)
                {
                    Label lblTotal = (Label)gvMyCart.Rows[i].FindControl("lblTotal");
                    Debug.WriteLine(lblTotal.Text);
                    Decimal singleItemCost = Convert.ToDecimal(lblTotal.Text.Substring(2));
                    totalCost += singleItemCost;
                    Debug.WriteLine(totalCost.ToString());
                }
                if(totalCost==0)
                {
                    lblCostofAllitemsincart.Text = "No items in Cart";
                    btnBuyAll.Visible = false;
                    btnRemoveAll.Visible = false;
                }
                else
                {
                    lblCostofAllitemsincart.Text ="$"+ totalCost.ToString();
                    btnBuyAll.Visible = true;
                    btnRemoveAll.Visible = true;
                }
                
            }
        }

        protected void gvMyCart_RowCancelingEdit(object sender, GridViewCancelEditEventArgs e)
        {
            gvMyCart.EditIndex = -1;
            BindCartGrid();
        }

        protected void gvMyCart_RowUpdating(object sender, GridViewUpdateEventArgs e)
        {
            try
            {
                string Username = Session["Username"].ToString();
                Label lblProductID = gvMyCart.Rows[e.RowIndex].FindControl("lblProductID") as Label;
                TextBox txtQuantity = gvMyCart.Rows[e.RowIndex].FindControl("txtQuantity") as TextBox;
                conn.Open();
                SqlCommand cmd = new SqlCommand("UPDATE [Cart] SET Quantity=@quant WHERE ProductID=@Pid AND Username=@Un", conn);
                cmd.Parameters.AddWithValue("@Un", Username);
                cmd.Parameters.AddWithValue("@quant", txtQuantity.Text);
                cmd.Parameters.AddWithValue("@Pid", lblProductID.Text);
                cmd.ExecuteNonQuery();
                conn.Close();
                gvMyCart.EditIndex = -1;
                BindCartGrid();
            }
            catch (Exception ex)
            {
                lblErrUpdating.Text = "Error" + ex.ToString();
            }
        }

        protected void gvMyCart_RowDeleting(object sender, GridViewDeleteEventArgs e)
        {
            try
            {
                string Username = Session["Username"].ToString();
                Label lblProductID = gvMyCart.Rows[e.RowIndex].FindControl("lblProductID") as Label;
                conn.Open();
                SqlCommand cmd = new SqlCommand("DELETE FROM [Cart] WHERE ProductID=@Pid AND Username=@Un", conn);
                cmd.Parameters.AddWithValue("@Pid", lblProductID.Text);
                cmd.Parameters.AddWithValue("@Un", Username);
                cmd.ExecuteNonQuery();
                conn.Close();
                gvMyCart.EditIndex = -1;
                BindCartGrid();

            }
            catch (Exception ex)
            {
                lblErrUpdating.Text = "Error" + ex.ToString();
            }
        }

        protected void gvMyCart_PageIndexChanging(object sender, GridViewPageEventArgs e)
        {
            gvMyCart.PageIndex = e.NewPageIndex;
            BindCartGrid();
        }

        protected void gvMyCart_RowEditing(object sender, GridViewEditEventArgs e)
        {
            gvMyCart.EditIndex = e.NewEditIndex;
            BindCartGrid();
        }

        protected void btnBuyAll_Click(object sender, EventArgs e)
        {

        }

        protected void btnRemoveAll_Click(object sender, EventArgs e)
        {

        }
    }
}