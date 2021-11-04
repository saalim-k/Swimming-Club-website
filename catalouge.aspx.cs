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

namespace GroupAss
{
    public partial class catalouge : System.Web.UI.Page
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
            if (!IsPostBack)
            {
                string CatID = Request.QueryString["CategoryID"];
                if (CatID == null)
                {
                    conn.Open();
                    SqlCommand cmd = new SqlCommand("SELECT * FROM [Product]", conn);
                    SqlDataAdapter sda = new SqlDataAdapter();
                    {
                        cmd.Connection = conn;
                        sda.SelectCommand = cmd;
                        using (DataTable dt = new DataTable())
                        {
                            sda.Fill(dt);
                            dlProduct.DataSource = dt;
                            dlProduct.DataBind();
                        }

                    conn.Close();
                    }
                }
                else 
                {
                    conn.Open();
                    SqlCommand cmd = new SqlCommand("SELECT * FROM [Product] WHERE ProductCategoryID = '" + CatID + "'", conn);
                    SqlDataAdapter sda = new SqlDataAdapter();
                    {
                        cmd.Connection = conn;
                        sda.SelectCommand = cmd;
                            using (DataTable dt = new DataTable())
                            {
                                sda.Fill(dt);
                                dlProduct.DataSource = dt;
                                dlProduct.DataBind();
                            }
                    conn.Close();
                    }
                }
                conn.Open();
                SqlCommand catcmd = new SqlCommand("SELECT * FROM [Category]", conn);
                SqlDataAdapter catsda = new SqlDataAdapter();
                {
                    catcmd.Connection = conn;
                    catsda.SelectCommand = catcmd;
                    using (DataTable catdt = new DataTable())
                    {
                        catsda.Fill(catdt);
                        dlCategory.DataSource = catdt;
                        dlCategory.DataBind();
                    }
                conn.Close();
                }                
            }
        }

        private void SearchByProduct()
        {
            string search = txtSearchBar.Text.ToString();
            conn.Open();
            SqlCommand cmd = new SqlCommand("SELECT * FROM [Product] WHERE ProductName LIKE '%'+@search+'%'",conn);
            cmd.Parameters.AddWithValue("@search", search);
                SqlDataAdapter da = new SqlDataAdapter();
                {
                   // cmd.Connection = conn;
                    da.SelectCommand = cmd;
                    using (DataTable dt = new DataTable())
                    {
                        da.Fill(dt);
                        dlProduct.DataSource = dt;
                        dlProduct.DataBind();
                    }
                    conn.Close();
                }
        }
        protected void dlProduct_ItemCommand(object source, DataListCommandEventArgs e)
        {
            if (e.CommandName == "AddCart") 
            {
                int index = e.Item.ItemIndex;
                TextBox txtQuantity = (TextBox)dlProduct.Items[index].FindControl("txtQuantity");
                Label lblProdID = (Label)dlProduct.Items[index].FindControl("lblProdID");
                string prodid = lblProdID.Text.ToString();
                try
                {
                    SqlCommand get = new SqlCommand("SELECT * FROM [Product] WHERE ProductCategoryID = '" + prodid + "'", conn);

                    int quantity = Int32.Parse(txtQuantity.Text);
                    if (quantity <= 0) 
                    {
                        Response.Write("<script>alert('Please enter a valid quantity!');</script>");
                    }
                    else
                    {
                        string User = Session["Username"].ToString();
                        conn.Open();
                        string CheckCart = "SELECT * FROM [CART] WHERE Username='" + User + "' AND ProductID='" + prodid + "'";
                        SqlCommand check = new SqlCommand(CheckCart, conn);
                        SqlDataReader dr = check.ExecuteReader();
                        if (dr.Read())
                        {
                            string ProductID = dr["ProductID"].ToString();
                            int Quantity = Convert.ToInt32(dr["Quantity"]);
                            Debug.WriteLine(Quantity);
                            string newquant = (Quantity + quantity).ToString();
                            conn.Close();
                            Debug.WriteLine(ProductID);

                            conn.Open();
                            SqlCommand update = new SqlCommand("UPDATE [CART] SET Quantity=@newquantity WHERE Username='" + User + "' AND ProductID='" + prodid + "'", conn);
                            update.Parameters.AddWithValue("@newquantity", newquant);
                            Debug.WriteLine(newquant);
                            update.ExecuteNonQuery();
                            Response.Write("<script>alert('Product Added!');</script>");
                            txtQuantity.Text = "1";
                            conn.Close();
                        }
                        else
                        {
                            conn.Close();
                            conn.Open();
                            string InsertToCart = "INSERT INTO [CART] (Username,ProductID,Quantity) VALUES (@username,@prodid,@quantity)";
                            SqlCommand cmd = new SqlCommand(InsertToCart, conn);
                            cmd.Parameters.AddWithValue("@username", User);
                            cmd.Parameters.AddWithValue("@prodid", lblProdID.Text);
                            cmd.Parameters.AddWithValue("@quantity", txtQuantity.Text);
                            cmd.ExecuteNonQuery();
                            Response.Write("<script>alert('Product Added!');</script>");
                            txtQuantity.Text = "1";
                            conn.Close();
                        }
                    }
                }
                catch (Exception ex)
                {
                    Debug.WriteLine(ex.ToString());
                    Response.Write("<script>alert('Error Adding Product to Cart!');</script>");
                }
            }

        }

        protected void btnSearch_Click(object sender, EventArgs e)
        {        
            SearchByProduct();
        }

        protected void clear()
        {
            txtSearchBar.Text = "";
        }
    }
}
