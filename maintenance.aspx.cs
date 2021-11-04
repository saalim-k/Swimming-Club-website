using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data;
using System.Data.SqlClient;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Diagnostics;
using System.IO;

namespace GroupAss
{
    public partial class maintenance : System.Web.UI.Page
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
            if (Session["Username"] == null || Convert.ToInt32(Session["isAdmin"]) == 0)
            {
                Response.Redirect("~/login.aspx");
            }
            if (mvMaintenance.ActiveViewIndex==1)
            {
                if(ddlMaintainECat.SelectedIndex==1)
                {
                    this.BindCategoryDataGrid();
                        
                }
                else if(ddlMaintainECat.SelectedIndex == 2)
                {
                    this.BindProductListGrid();
                }
            }
            else if(mvMaintenance.ActiveViewIndex==2)
            {
                this.BindNewsGrid();
            }
            else if(mvMaintenance.ActiveViewIndex==3)
            {
                this.BindFaqGrid();
            }
        }
        private void BindGridSearch()
        {
            conn.Open();
            SqlCommand cmd = new SqlCommand("SELECT AccountInfo.*,Account.* FROM [AccountInfo],[Account] WHERE AccountInfo.Username=Account.Username AND AccountInfo.Username=@txtUsername", conn);
            string un = txtSearchUsers.Text;
            cmd.Parameters.AddWithValue("@txtUsername", un);
            SqlDataAdapter sda = new SqlDataAdapter();
            {
                cmd.Connection = conn;
                sda.SelectCommand = cmd;
                using (DataTable dt = new DataTable())
                {

                    sda.Fill(dt);
                    gvUsers.DataSource = dt;
                    gvUsers.DataBind();
                }
                for (int i = 0; i < gvUsers.Rows.Count; i++)
                {
                    Label isAdmin = (Label)gvUsers.Rows[i].FindControl("lblIsAdmin");
                    if (isAdmin.Text == "1")
                    {
                        Label yesAdmin = (Label)gvUsers.Rows[i].FindControl("lblYesAdmin");
                        yesAdmin.Visible = true;
                    }
                    else
                    {
                        Label yesMember = (Label)gvUsers.Rows[i].FindControl("lblYesMember");
                        yesMember.Visible = true;
                    }
                    Label isBlocked = (Label)gvUsers.Rows[i].FindControl("lblIsBlocked");
                    if (isBlocked.Text == "1")
                    {
                        Label yesBlocked = (Label)gvUsers.Rows[i].FindControl("lblBlocked");
                        yesBlocked.Visible = true;
                    }
                }
                conn.Close();
            }
        }
        private void BindGridAllUsers()
        {
            Debug.WriteLine("Bg All Users fired");
            conn.Open();
            SqlCommand cmd = new SqlCommand("SELECT AccountInfo.*,Account.* FROM [AccountInfo],[Account] WHERE AccountInfo.Username=Account.Username", conn);
            SqlDataAdapter sda = new SqlDataAdapter();
            cmd.Connection = conn;
            sda.SelectCommand = cmd;
            using (DataTable dt = new DataTable())
            {
                sda.Fill(dt);
                gvUsers.DataSource = dt;
                gvUsers.DataBind();
            }
            for (int i = 0; i < gvUsers.Rows.Count; i++)
            {
                Label isBlocked = (Label)gvUsers.Rows[i].FindControl("lblIsBlocked");
                if (isBlocked.Text == "1")
                {
                    Label yesBlocked = (Label)gvUsers.Rows[i].FindControl("lblBlocked");
                    yesBlocked.Visible = true;
                }
                else
                {
                    Label isAdmin = (Label)gvUsers.Rows[i].FindControl("lblIsAdmin");
                    if (isAdmin.Text == "1")
                    {
                        Label yesAdmin = (Label)gvUsers.Rows[i].FindControl("lblYesAdmin");
                        yesAdmin.Visible = true;
                    }
                    else
                    {
                        Label yesMember = (Label)gvUsers.Rows[i].FindControl("lblYesMember");
                        yesMember.Visible = true;
                    }
                }
                

            }
            conn.Close();
        }
        private void BindGridAdmins()
        {
            Debug.WriteLine("Bg Admins fired");
            conn.Open();
            SqlCommand cmd = new SqlCommand("SELECT AccountInfo.*,Account.* FROM [AccountInfo],[Account] WHERE AccountInfo.Username=Account.Username AND Account.isAdmin=1 AND Account.Username!=@currentUser", conn);
            SqlDataAdapter sda = new SqlDataAdapter();
            cmd.Parameters.AddWithValue("@currentUser", Session["Username"].ToString());
            sda.SelectCommand = cmd;
            using (DataTable dt = new DataTable())
            {
                if(gvUsers.Columns.Count!=10)
                {
                    ButtonField btnRemoveFromAdmin = new ButtonField();
                    btnRemoveFromAdmin.ButtonType = ButtonType.Button;
                    btnRemoveFromAdmin.CommandName = "removeAdmin";
                    btnRemoveFromAdmin.Text = "Remove Admin Powers";
                    gvUsers.Columns.Add(btnRemoveFromAdmin);
                }                
                sda.Fill(dt);
                gvUsers.DataSource = dt;
                gvUsers.DataBind();
            }
            for (int i = 0; i < gvUsers.Rows.Count; i++)
            {
                Label isAdmin = (Label)gvUsers.Rows[i].FindControl("lblIsAdmin");
                if (isAdmin.Text == "1")
                {
                    Label yesAdmin = (Label)gvUsers.Rows[i].FindControl("lblYesAdmin");
                    yesAdmin.Visible = true;
                }
                else
                {
                    Label yesMember = (Label)gvUsers.Rows[i].FindControl("lblYesMember");
                    yesMember.Visible = true;
                }
                Label isBlocked = (Label)gvUsers.Rows[i].FindControl("lblIsBlocked");
                if (isBlocked.Text == "1")
                {
                    Label yesBlocked = (Label)gvUsers.Rows[i].FindControl("lblBlocked");
                    yesBlocked.Visible = true;                    
                }
            }
            conn.Close();
        }
        private void BindGridMembers()
        {
            Debug.WriteLine("Bg members fired");
            conn.Open();
            SqlCommand cmd = new SqlCommand("SELECT AccountInfo.*,Account.* FROM [AccountInfo],[Account] WHERE AccountInfo.Username=Account.Username AND Account.isAdmin=0 AND Account.isBlocked=0", conn);
            string un = txtSearchUsers.Text;
            cmd.Parameters.AddWithValue("@txtUsername", un);
            SqlDataAdapter sda = new SqlDataAdapter();
            cmd.Connection = conn;
            sda.SelectCommand = cmd;
            using (DataTable dt = new DataTable())
            {
                if(gvUsers.Columns.Count!=11)
                {
                    ButtonField btnMakeAdmin = new ButtonField();
                    btnMakeAdmin.ButtonType = ButtonType.Button;
                    btnMakeAdmin.CommandName = "makeAdmin";
                    btnMakeAdmin.Text = "Change to Admin";
                    gvUsers.Columns.Add(btnMakeAdmin);
                    ButtonField btnBlock = new ButtonField();
                    btnBlock.ButtonType = ButtonType.Button;
                    btnBlock.CommandName = "blockUser";
                    btnBlock.Text = "Block";
                    gvUsers.Columns.Add(btnBlock);
                }
                sda.Fill(dt);
                gvUsers.DataSource = dt;
                gvUsers.DataBind();
            }
            for (int i = 0; i < gvUsers.Rows.Count; i++)
            {
                Label isAdmin = (Label)gvUsers.Rows[i].FindControl("lblIsAdmin");
                if (isAdmin.Text == "1")
                {
                    Label yesAdmin = (Label)gvUsers.Rows[i].FindControl("lblYesAdmin");
                    yesAdmin.Visible = true;
                }
                else
                {
                    Label yesMember = (Label)gvUsers.Rows[i].FindControl("lblYesMember");
                    yesMember.Visible = true;
                }
                Label isBlocked = (Label)gvUsers.Rows[i].FindControl("lblIsBlocked");
                if (isBlocked.Text == "1")
                {
                    Label yesBlocked = (Label)gvUsers.Rows[i].FindControl("lblBlocked");
                    yesBlocked.Visible = true;

                }
            }
            conn.Close();
        }
        private void BindGridBlocked()
        {
            Debug.WriteLine("Bg blocked fired");
            conn.Open();
            SqlCommand cmd = new SqlCommand("SELECT AccountInfo.*,Account.* FROM [AccountInfo],[Account] WHERE AccountInfo.Username=Account.Username AND Account.isBlocked=1", conn);
            string un = txtSearchUsers.Text;
            cmd.Parameters.AddWithValue("@txtUsername", un);
            SqlDataAdapter sda = new SqlDataAdapter();
            cmd.Connection = conn;
            sda.SelectCommand = cmd;
            using (DataTable dt = new DataTable())
            {
                if (gvUsers.Columns.Count != 10)
                {
                    ButtonField btnUnblock = new ButtonField();
                    btnUnblock.ButtonType = ButtonType.Button;
                    btnUnblock.CommandName = "unBlock";
                    btnUnblock.Text = "Unblock User";
                    gvUsers.Columns.Add(btnUnblock);
                }
                    
                sda.Fill(dt);
                gvUsers.DataSource = dt;
                gvUsers.DataBind();
            }
            for (int i = 0; i < gvUsers.Rows.Count; i++)
            {
                Label isAdmin = (Label)gvUsers.Rows[i].FindControl("lblIsAdmin");
                if (isAdmin.Text == "1")
                {
                    Label yesAdmin = (Label)gvUsers.Rows[i].FindControl("lblYesAdmin");
                    yesAdmin.Visible = true;
                }
                else
                {
                    Label yesMember = (Label)gvUsers.Rows[i].FindControl("lblYesMember");
                    yesMember.Visible = true;
                }
                Label isBlocked = (Label)gvUsers.Rows[i].FindControl("lblIsBlocked");
                if (isBlocked.Text == "1")
                {
                    Label yesBlocked = (Label)gvUsers.Rows[i].FindControl("lblBlocked");
                    yesBlocked.Visible = true;
                }
            }
            conn.Close();
        }

        protected void btnMaintainUsers_Click(object sender, EventArgs e)
        {
            mvMaintenance.EnableViewState = true;
            mvMaintenance.ActiveViewIndex = 0;
        }

        protected void btnMainEcat_Click(object sender, EventArgs e)
        {
            mvMaintenance.EnableViewState = true;
            mvMaintenance.ActiveViewIndex = 1;
        }

        protected void btnMainNews_Click(object sender, EventArgs e)
        {
            mvMaintenance.EnableViewState = true;
            mvMaintenance.ActiveViewIndex = 2;
            BindNewsGrid();
        }

        protected void btnMainFaq_Click(object sender, EventArgs e)
        {
            mvMaintenance.EnableViewState = true;
            mvMaintenance.ActiveViewIndex = 3;
            BindFaqGrid();
        }

        protected void btnViewMemFeedback_Click(object sender, EventArgs e)
        {
            mvMaintenance.EnableViewState = true;
            mvMaintenance.ActiveViewIndex = 4;
        }

        protected void btnSearchUsers_Click(object sender, EventArgs e)
        {
            BindGridSearch();
        }

        protected void ddlSortBy_SelectedIndexChanged(object sender, EventArgs e)
        {
            if(ddlSortBy.SelectedIndex==1)
            {
                if (btnSearchUsers.Visible == false && txtSearchUsers.Visible == false)
                {
                    btnSearchUsers.Visible = true;
                    txtSearchUsers.Visible = true;
                }
            }
            else if(ddlSortBy.SelectedIndex==2)
            {
                if (btnSearchUsers.Visible == true && txtSearchUsers.Visible==true)
                {
                    btnSearchUsers.Visible = false;
                    txtSearchUsers.Visible = false;
                }
                BindGridAllUsers();
            }
            else if(ddlSortBy.SelectedIndex==3)
            {
                if (btnSearchUsers.Visible == true && txtSearchUsers.Visible == true)
                {
                    btnSearchUsers.Visible = false;
                    txtSearchUsers.Visible = false;
                }
                BindGridAdmins();
            }
            else if(ddlSortBy.SelectedIndex==4)
            {
                if (btnSearchUsers.Visible == true && txtSearchUsers.Visible == true)
                {
                    btnSearchUsers.Visible = false;
                    txtSearchUsers.Visible = false;
                }
                BindGridMembers();
            }
            else if(ddlSortBy.SelectedIndex==5)
            {
                if (btnSearchUsers.Visible == true && txtSearchUsers.Visible == true)
                {
                    btnSearchUsers.Visible = false;
                    txtSearchUsers.Visible = false;
                }
                BindGridBlocked();
            }
            else
            {
                if (btnSearchUsers.Visible == true && txtSearchUsers.Visible == true)
                {
                    btnSearchUsers.Visible = false;
                    txtSearchUsers.Visible = false;
                }
                gvUsers.DataSource = null;
                gvUsers.DataBind();
            }
        }

        protected void gvUsers_RowCommand(object sender, GridViewCommandEventArgs e)
        {
            if(e.CommandName=="removeAdmin")
            {
                Debug.WriteLine("row cmd rma");
                conn.Open();
                int index = Convert.ToInt32(e.CommandArgument.ToString());
                GridViewRow row = gvUsers.Rows[index];
                Label lblSelectedUsername = new Label();
                lblSelectedUsername.Text = Server.HtmlDecode(row.Cells[0].Text);
                SqlCommand cmd = new SqlCommand("UPDATE [Account] SET isAdmin=0 WHERE Username='"+lblSelectedUsername.Text+"'", conn);
                cmd.ExecuteNonQuery();
                Response.Write("<script>alert('User is no longer an Admin!');</script>");
                conn.Close();
                ddlSortBy_SelectedIndexChanged(sender,e);
            }
            if (e.CommandName == "makeAdmin")
            {
                Debug.WriteLine("row cmd ma");
                conn.Open();
                int index = Convert.ToInt32(e.CommandArgument.ToString());
                GridViewRow row = gvUsers.Rows[index];
                Label lblSelectedUsername = new Label();
                lblSelectedUsername.Text = Server.HtmlDecode(row.Cells[0].Text);
                SqlCommand cmd = new SqlCommand("UPDATE [Account] SET isAdmin=1 WHERE Username='" + lblSelectedUsername.Text + "'", conn);
                cmd.ExecuteNonQuery();
                Response.Write("<script>alert('User is now an Admin!');</script>");
                conn.Close();
                ddlSortBy_SelectedIndexChanged(sender, e);
            }
            if (e.CommandName == "unBlock")
            {
                Debug.WriteLine("row cmd ub");
                conn.Open();
                int index = Convert.ToInt32(e.CommandArgument.ToString());
                GridViewRow row = gvUsers.Rows[index];
                Label lblSelectedUsername = new Label();
                lblSelectedUsername.Text = Server.HtmlDecode(row.Cells[0].Text);
                SqlCommand cmd = new SqlCommand("UPDATE [Account] SET isBlocked=0 WHERE Username='" + lblSelectedUsername.Text + "'", conn);
                cmd.ExecuteNonQuery();
                Response.Write("<script>alert('Userhas been unblocked!');</script>");
                conn.Close();
                ddlSortBy_SelectedIndexChanged(sender, e);
            }
            if (e.CommandName == "blockUser")
            {
                Debug.WriteLine("row cmd bu");
                conn.Open();
                int index = Convert.ToInt32(e.CommandArgument.ToString());
                GridViewRow row = gvUsers.Rows[index];
                Label lblSelectedUsername = new Label();
                lblSelectedUsername.Text = Server.HtmlDecode(row.Cells[0].Text);
                SqlCommand cmd = new SqlCommand("UPDATE [Account] SET isBlocked=1 WHERE Username='" + lblSelectedUsername.Text + "'", conn);
                cmd.ExecuteNonQuery();
                Response.Write("<script>alert('User has been blocked!');</script>");
                conn.Close();
                ddlSortBy_SelectedIndexChanged(sender, e);
            }
        }

        protected void gvUsers_PageIndexChanging(object sender, GridViewPageEventArgs e)
        {
            gvUsers.PageIndex = e.NewPageIndex;
            if (ddlSortBy.SelectedIndex == 2)
            {
                BindGridAllUsers();
            }
            else if (ddlSortBy.SelectedIndex == 3)
            {
                BindGridAdmins();
            }
            else if (ddlSortBy.SelectedIndex == 4)
            {
                BindGridMembers();
            }
            else if (ddlSortBy.SelectedIndex == 5)
            {
                BindGridBlocked();
            }
            
        }

        private void BindCategoryDataGrid()
        {
            conn.Open();
            SqlCommand cmd = new SqlCommand("SELECT [CategoryID],[CategoryShortDesc],[CategoryLongDesc] FROM Category", conn);
            SqlDataAdapter sda = new SqlDataAdapter();
            {
                cmd.Connection = conn;
                sda.SelectCommand = cmd;
                using (DataTable dt = new DataTable())
                {
                    sda.Fill(dt);
                    gvCategories.DataSource = dt;
                    gvCategories.DataBind();
                }
                conn.Close();
            }
        }
        protected void ddlMaintainECat_SelectedIndexChanged(object sender, EventArgs e)
        {
            if(ddlMaintainECat.SelectedIndex==1)
            {
                divMaintainProd.Visible = false;
                divMaintainCat.Visible = true;
            }
            if(ddlMaintainECat.SelectedIndex==2)
            {
                divMaintainProd.Visible = true;
                divMaintainCat.Visible = false;
            }
        }
        protected void gvCategories_RowCancelingEdit(object sender, GridViewCancelEditEventArgs e)
        {
            gvCategories.EditIndex = -1;
            BindCategoryDataGrid();
        }

        protected void gvCategories_RowEditing(object sender, GridViewEditEventArgs e)
        {
            gvCategories.EditIndex = e.NewEditIndex;
            BindCategoryDataGrid();
        }

        protected void gvCategories_RowUpdating(object sender, GridViewUpdateEventArgs e)
        {
            try
            {
                Label lblCatID = gvCategories.Rows[e.RowIndex].FindControl("lblCatID") as Label;
                TextBox txtCatShortDesc = gvCategories.Rows[e.RowIndex].FindControl("txtCatShortDesc") as TextBox;
                TextBox txtCatLongDesc = gvCategories.Rows[e.RowIndex].FindControl("txtCatLongDesc") as TextBox;
                conn.Open();
                SqlCommand cmd = new SqlCommand("Update Category SET CategoryShortDesc='" + txtCatShortDesc.Text + "',CategoryLongDesc='" + txtCatLongDesc.Text + "'WHERE CategoryID='" + lblCatID.Text+"'", conn);
                cmd.ExecuteNonQuery();
                conn.Close();
                gvCategories.EditIndex = -1;
                BindCategoryDataGrid();
            }
            catch(Exception ex)
            {
                lblEditCatError.Text = "Error" + ex.ToString();
            }
            
        }
        protected void gvCategories_RowDeleting(object sender, GridViewDeleteEventArgs e)
        {
            try
            {
                Label lblCatID = gvCategories.Rows[e.RowIndex].FindControl("lblCatID") as Label;
                conn.Open();
                SqlCommand cmd = new SqlCommand("DELETE FROM [Category] WHERE CategoryID=@catID", conn);
                cmd.Parameters.AddWithValue("@catID", lblCatID.Text);
                Debug.WriteLine(lblCatID.Text);
                cmd.ExecuteNonQuery();
                conn.Close();
                gvCategories.EditIndex = -1;
                BindCategoryDataGrid();
            }
            catch (Exception ex)
            {
                lblAddNewCatError.Text = "Error" + ex.ToString();
            }

        }
        protected void btnAddNewCat_Click(object sender, EventArgs e)
        {
            try
            {
                conn.Open();
                SqlCommand cmd = new SqlCommand("INSERT INTO [Category] (CategoryID, CategoryShortDesc,CategoryLongDesc) VALUES (@catID , @catShortDesc, @catLongDesc)", conn);
                cmd.Parameters.AddWithValue("@catID", txtNewCatID.Text);
                cmd.Parameters.AddWithValue("@catShortDesc", txtNewCatShortDesc.Text);
                cmd.Parameters.AddWithValue("@catLongDesc", txtNewCatLongDesc.Text);
                cmd.ExecuteNonQuery();
                Response.Write("<script>alert('Category added successfully!');</script>");
                conn.Close();
                btnClearNewCatFields_Click(sender,e);
                Page_Load(sender, e);
            }
            catch(Exception ex)
            {
                lblAddNewCatError.Text = "Error" + ex.ToString();
            }
        }

        protected void btnClearNewCatFields_Click(object sender, EventArgs e)
        {
            txtNewCatID.Text = "";
            txtNewCatLongDesc.Text = "";
            txtNewCatShortDesc.Text = "";
            lblAddNewCatError.Text = "";
        }

        protected void gvCategories_PageIndexChanging(object sender, GridViewPageEventArgs e)
        {
            gvCategories.PageIndex = e.NewPageIndex;
            BindCategoryDataGrid();
        }

        private void BindProductListGrid()
        {
            conn.Open();
            SqlCommand cmd = new SqlCommand("SELECT Product.*,Category.CategoryShortDesc FROM Product,Category WHERE ProductCategoryID=@catID AND Product.ProductCategoryID=Category.CategoryID", conn);
            string catID = ddlCategoryList.SelectedValue;
            cmd.Parameters.AddWithValue("@catID", catID);
            SqlDataAdapter sda = new SqlDataAdapter();
            {
                cmd.Connection = conn;
                sda.SelectCommand = cmd;
                using (DataTable dt = new DataTable())
                {

                    sda.Fill(dt);
                    gvProducts.DataSource = dt;
                    gvProducts.DataBind();
                }
                conn.Close();
            }
        }
        protected void btnViewSelectedCat_Click(object sender, EventArgs e)
        {
            BindProductListGrid();
        }
        protected void gvProducts_RowEditing(object sender, GridViewEditEventArgs e)
        {
            gvProducts.EditIndex = e.NewEditIndex;
            BindProductListGrid();
        }

        protected void gvProducts_RowCancelingEdit(object sender, GridViewCancelEditEventArgs e)
        {
            gvProducts.EditIndex = -1;
            BindProductListGrid();
        }

        protected void gvProducts_RowUpdating(object sender, GridViewUpdateEventArgs e)
        {
            Debug.WriteLine("gvProducts_RowUpdating Fired");
            try
            {
                Label lblProdID = gvProducts.Rows[e.RowIndex].FindControl("lblProdID") as Label;
                TextBox txtProdName = gvProducts.Rows[e.RowIndex].FindControl("txtProdName") as TextBox;
                TextBox txtProdDesc = gvProducts.Rows[e.RowIndex].FindControl("txtProdDesc") as TextBox;
                TextBox txtProdPrice = gvProducts.Rows[e.RowIndex].FindControl("txtProdPrice") as TextBox;
                TextBox txtProdQuant = gvProducts.Rows[e.RowIndex].FindControl("txtProdQuant") as TextBox;
                FileUpload fuProdImage = gvProducts.Rows[e.RowIndex].FindControl("fuProdImage") as FileUpload;
                DropDownList ddlCatList = gvProducts.Rows[e.RowIndex].FindControl("ddlCatList") as DropDownList;
                string catID = ddlCatList.SelectedValue;
                if (fuProdImage.HasFile)
                {
                    if ((fuNewProdImage.PostedFile.ContentType == "image/jpeg") || (fuNewProdImage.PostedFile.ContentType == "image/jpg") || (fuNewProdImage.PostedFile.ContentType == "image/JPEG") || (fuNewProdImage.PostedFile.ContentType == "image/JPG"))
                    {
                        string fn = Path.GetFileName(fuProdImage.FileName);
                        fuProdImage.SaveAs(Server.MapPath("~/Images/Products/") + fn);
                        string ProdimgUrl = fn;
                        conn.Open();
                        SqlCommand cmd = new SqlCommand("Update [Product] SET ProductName=@Pn,ProductDescription=@Pd,ProductPrice=@Pp,ProductQuantity=@Pq,ProductImage=@Pi,ProductCategoryID=@PcID WHERE ProductID=@ProdID", conn);
                        cmd.Parameters.AddWithValue("@ProdID", lblProdID.Text);
                        cmd.Parameters.AddWithValue("@Pn", txtProdName.Text);
                        cmd.Parameters.AddWithValue("@Pd", txtProdDesc.Text);
                        cmd.Parameters.AddWithValue("@Pp", txtProdPrice.Text);
                        cmd.Parameters.AddWithValue("@Pq", txtProdQuant.Text);
                        cmd.Parameters.AddWithValue("@Pi", ProdimgUrl);
                        cmd.Parameters.AddWithValue("@PcID", catID);
                        cmd.ExecuteNonQuery();
                        conn.Close();
                        gvProducts.EditIndex = -1;
                        BindProductListGrid();
                    }
                    else
                    {
                        lblErrorEditProd.Text = "Error You can only Upload Jepg files";
                    }
                }
                else
                {
                    Image imgProdImage = gvProducts.Rows[e.RowIndex].FindControl("imgProdImage") as Image;
                    string ProdimgUrl = imgProdImage.ImageUrl.Substring(18);
                    conn.Open();
                    SqlCommand cmd = new SqlCommand("Update [Product] SET ProductName=@Pn,ProductDescription=@Pd,ProductPrice=@Pp,ProductQuantity=@Pq,ProductImage=@Pi,ProductCategoryID=@PcID WHERE ProductID=@ProdID", conn);
                    cmd.Parameters.AddWithValue("@ProdID", lblProdID.Text);
                    cmd.Parameters.AddWithValue("@Pn", txtProdName.Text);
                    cmd.Parameters.AddWithValue("@Pd", txtProdDesc.Text);
                    cmd.Parameters.AddWithValue("@Pp", txtProdPrice.Text);
                    cmd.Parameters.AddWithValue("@Pq", txtProdQuant.Text);
                    cmd.Parameters.AddWithValue("@Pi", ProdimgUrl);
                    cmd.Parameters.AddWithValue("@PcID", catID);
                    cmd.ExecuteNonQuery();
                    conn.Close();
                    gvProducts.EditIndex = -1;
                    BindProductListGrid();
                }
            }
            catch(Exception ex)
            {
                lblErrorEditProd.Text = "Error" + ex.ToString();
            }
        }

        protected void gvProducts_RowDeleting(object sender, GridViewDeleteEventArgs e)
        {
            try
            {
                Label lblProdID = gvProducts.Rows[e.RowIndex].FindControl("lblProdID") as Label;
                conn.Open();
                SqlCommand cmd = new SqlCommand("DELETE FROM Product Where ProductID = @Pid", conn);
                cmd.Parameters.AddWithValue("@Pid", lblProdID.Text);
                cmd.ExecuteNonQuery();
                conn.Close();
                gvProducts.EditIndex = -1;
                BindProductListGrid();

            }
            catch (Exception ex)
            {
                lblErrorEditProd.Text = "Error" + ex.ToString();
            }
        }

        protected void btnAddNewProd_Click(object sender, EventArgs e)
        {
            try
            {
                if(fuNewProdImage.HasFile)
                {
                    if((fuNewProdImage.PostedFile.ContentType=="image/jpeg")||(fuNewProdImage.PostedFile.ContentType == "image/jpg")|| (fuNewProdImage.PostedFile.ContentType == "image/JPEG")|| (fuNewProdImage.PostedFile.ContentType == "image/JPG"))
                    {
                        string fn = Path.GetFileName(fuNewProdImage.FileName);
                        fuNewProdImage.SaveAs(Server.MapPath("~/Images/Products/") + fn);
                        conn.Open();
                        SqlCommand cmd = new SqlCommand("INSERT INTO [Product] (ProductID, ProductName,ProductDescription,ProductPrice,ProductQuantity,ProductImage,ProductCategoryID) VALUES (@Pid, @Pn,@Pd,@Pp,@Pq,@Pi,@PcatId)", conn);
                        cmd.Parameters.AddWithValue("@Pid", txtNewProdID.Text);
                        cmd.Parameters.AddWithValue("@Pn", txtNewProdName.Text);
                        cmd.Parameters.AddWithValue("@Pd", txtNewProdDesc.Text);
                        cmd.Parameters.AddWithValue("@Pp", txtNewProdPrice.Text);
                        cmd.Parameters.AddWithValue("@Pq", txtNewProdQuantity.Text);
                        cmd.Parameters.AddWithValue("@Pi", fn);
                        cmd.Parameters.AddWithValue("@PcatId", ddlNewProdCat.SelectedValue);
                        cmd.ExecuteNonQuery();
                        Response.Write("<script>alert('Product added successfully!');</script>");
                        conn.Close();
                        btnClearAddNewProd_Click(sender, e);
                        Page_Load(sender, e);
                    }
                    else
                    {
                        throw new Exception(string.Format("Only Jpeg files can be uploaded"));
                    }
                }
                
            }
            catch (Exception ex)
            {
                lblErrAddNewProd.Text = "Error" + ex.ToString();
            }
        }

        protected void btnClearAddNewProd_Click(object sender, EventArgs e)
        {
            txtNewProdID.Text = "";
            txtNewProdName.Text = "";
            txtNewProdDesc.Text = "";
            txtNewProdPrice.Text = "";
            txtNewProdQuantity.Text = "";
            fuNewProdImage.Dispose();
            ddlNewProdCat.SelectedIndex = -1;
            lblErrAddNewProd.Text = "";
        }
        protected void gvProducts_PageIndexChanging(object sender, GridViewPageEventArgs e)
        {
            gvProducts.PageIndex = e.NewPageIndex;
            BindProductListGrid();
        }
        private void BindNewsGrid()
        {
            conn.Open();
            SqlCommand cmd = new SqlCommand("SELECT * FROM [News]", conn);
            SqlDataAdapter sda = new SqlDataAdapter();
            {
                cmd.Connection = conn;
                sda.SelectCommand = cmd;
                using (DataTable dt = new DataTable())
                {
                    sda.Fill(dt);
                    gvNews.DataSource = dt;
                    gvNews.DataBind();
                }
                conn.Close();
            }
        }
        protected void gvNews_RowCancelingEdit(object sender, GridViewCancelEditEventArgs e)
        {
            gvNews.EditIndex = -1;
            BindNewsGrid();
        }

        protected void gvNews_RowEditing(object sender, GridViewEditEventArgs e)
        {
            gvNews.EditIndex = e.NewEditIndex;
            BindNewsGrid();
        }

        protected void gvNews_RowUpdating(object sender, GridViewUpdateEventArgs e)
        {
            try
            {
                Label lblNewsID = gvNews.Rows[e.RowIndex].FindControl("lblNewsID") as Label;
                TextBox txtNewsDesc = gvNews.Rows[e.RowIndex].FindControl("txtNewsDesc") as TextBox;
                FileUpload fuNewsImage = gvNews.Rows[e.RowIndex].FindControl("fuNewsImage") as FileUpload;
                Image imgNewsImage = gvNews.Rows[e.RowIndex].FindControl("imgNewsImage") as Image;
                string NewsImageURL = imgNewsImage.ImageUrl.Substring(14);
                string currentDate = DateTime.Now.ToShortDateString();
                string currentTime = DateTime.Now.ToShortTimeString();
                if (fuNewsImage.HasFile)
                {
                    if ((fuNewsImage.PostedFile.ContentType == "image/jpeg") || (fuNewsImage.PostedFile.ContentType == "image/jpg") || (fuNewsImage.PostedFile.ContentType == "image/JPEG") || (fuNewsImage.PostedFile.ContentType == "image/JPG"))
                    {
                        string fn = Path.GetFileName(fuNewsImage.FileName);
                        fuNewsImage.SaveAs(Server.MapPath("~/Images/News/") + fn);
                        conn.Open();
                        SqlCommand cmd = new SqlCommand("Update [News] SET NewsImage=@Nimg,NewsDesc=@Ndesc,NewsDate=@NDate,NewsTime=@Ntime WHERE [NewsID]=@Nid", conn);
                        cmd.Parameters.AddWithValue("@Nimg", fn);
                        cmd.Parameters.AddWithValue("@Ndesc", txtNewsDesc.Text);
                        cmd.Parameters.AddWithValue("@NDate", currentDate);
                        cmd.Parameters.AddWithValue("@Ntime", currentTime);
                        cmd.Parameters.AddWithValue("@Nid", lblNewsID.Text);
                        cmd.ExecuteNonQuery();
                        conn.Close();
                        gvNews.EditIndex = -1;
                        BindNewsGrid();
                    }
                    else
                    {
                        lblUpdateNewsError.Text = "Error, File can only be of JPEG type.";
                    }
                }
                else
                {
                    conn.Open();
                    SqlCommand cmd = new SqlCommand("Update [News] SET NewsImage=@Nimg,NewsDesc=@Ndesc,NewsDate=@NDate,NewsTime=@Ntime WHERE [NewsID]=@Nid", conn);
                    cmd.Parameters.AddWithValue("@Nimg", NewsImageURL);
                    cmd.Parameters.AddWithValue("@Ndesc", txtNewsDesc.Text);
                    cmd.Parameters.AddWithValue("@NDate", currentDate);
                    cmd.Parameters.AddWithValue("@Ntime", currentTime);
                    cmd.Parameters.AddWithValue("@Nid", lblNewsID.Text);
                    cmd.ExecuteNonQuery();
                    conn.Close();
                    gvNews.EditIndex = -1;
                    BindNewsGrid();
                }
            }
            catch (Exception ex)
            {
                lblUpdateNewsError.Text = "Error" + ex.ToString();
            }
        
    }

        protected void gvNews_RowDeleting(object sender, GridViewDeleteEventArgs e)
        {
            try
            {
                Label lblNewsID = gvNews.Rows[e.RowIndex].FindControl("lblNewsID") as Label;
                conn.Open();
                SqlCommand cmd = new SqlCommand("DELETE FROM News WHERE NewsID=@Nid", conn);
                cmd.Parameters.AddWithValue("@Nid", lblNewsID.Text);
                cmd.ExecuteNonQuery();
                conn.Close();
                gvNews.EditIndex = -1;
                BindNewsGrid();
            }
            catch (Exception ex)
            {
                lblUpdateNewsError.Text = "Error" + ex.ToString();
            }
        }

        protected void gvNews_PageIndexChanging(object sender, GridViewPageEventArgs e)
        {
            gvNews.PageIndex = e.NewPageIndex;
            BindNewsGrid();
        }

        protected void btnAddNews_Click(object sender, EventArgs e)
        {
            try
            {
                if(fuNewNewsImage.HasFile)
                {
                    if ((fuNewNewsImage.PostedFile.ContentType == "image/jpeg") || (fuNewNewsImage.PostedFile.ContentType == "image/jpg") || (fuNewNewsImage.PostedFile.ContentType == "image/JPEG") || (fuNewNewsImage.PostedFile.ContentType == "image/JPG"))
                    {
                        string fn = Path.GetFileName(fuNewNewsImage.FileName);
                        fuNewNewsImage.SaveAs(Server.MapPath("~/Images/News/") + fn);
                        string currentDate = DateTime.Now.ToShortDateString();
                        string currentTime = DateTime.Now.ToShortTimeString();
                        conn.Open();
                        SqlCommand cmd = new SqlCommand("INSERT INTO News (NewsImage,NewsDesc,NewsDate,NewsTime) VALUES (@NImg,@NDesc,@NDate,@NTime)", conn);
                        cmd.Parameters.AddWithValue("@NImg", fn);
                        cmd.Parameters.AddWithValue("@NDesc", txtNewsDesc.Text);
                        cmd.Parameters.AddWithValue("@NDate", currentDate);
                        cmd.Parameters.AddWithValue("@NTime", currentTime);
                        cmd.ExecuteNonQuery();
                        conn.Close();
                        btnClearNews_Click(sender, e);
                        btnMainNews_Click(sender,e);
                    }
                    else
                    {
                        lblAddNewsErr.Text = "Error file can only be of JPEG type";
                    }
                }
                else
                {
                    lblAddNewsErr.Text = "File Cannot Be Empty";
                }
            }
            catch(Exception ex)
            {
                lblAddNewsErr.Text = "Error" + ex.ToString();
            }
        }

        protected void btnClearNews_Click(object sender, EventArgs e)
        {
            txtNewsDesc.Text = "";
            fuNewNewsImage.Dispose();
            lblAddNewsErr.Text = "";
        }
        private void BindFaqGrid()
        {
            conn.Open();
            SqlCommand cmd = new SqlCommand("SELECT * FROM [FAQ]", conn);
            SqlDataAdapter sda = new SqlDataAdapter();
            {
                cmd.Connection = conn;
                sda.SelectCommand = cmd;
                using (DataTable dt = new DataTable())
                {
                    sda.Fill(dt);
                    gvFaq.DataSource = dt;
                    gvFaq.DataBind();
                }
                conn.Close();
            }
        }
        protected void gvFaq_RowCancelingEdit(object sender, GridViewCancelEditEventArgs e)
        {
            gvFaq.EditIndex = -1;
            BindFaqGrid();
        }

        protected void gvFaq_RowEditing(object sender, GridViewEditEventArgs e)
        {
            gvFaq.EditIndex = e.NewEditIndex;
            BindFaqGrid();
        }

        protected void gvFaq_RowUpdating(object sender, GridViewUpdateEventArgs e)
        {
            try
            {
                Label lblFaqId = gvFaq.Rows[e.RowIndex].FindControl("lblFaqId") as Label;
                TextBox txtFaqQuestion = gvFaq.Rows[e.RowIndex].FindControl("txtFaqQuestion") as TextBox;
                TextBox txtFaqAnswer = gvFaq.Rows[e.RowIndex].FindControl("txtFaqAnswer") as TextBox;
                TextBox txtFaqSearchTerm = gvFaq.Rows[e.RowIndex].FindControl("txtFaqSearchTerm") as TextBox;
                conn.Open();
                SqlCommand cmd = new SqlCommand("UPDATE [FAQ] SET FaqQuestion=@fq, FaqAnswer=@fa,FaqSearchTerm=@fst WHERE FaqID=@fid", conn);
                cmd.Parameters.AddWithValue("@fid", lblFaqId.Text);
                cmd.Parameters.AddWithValue("@fq", txtFaqQuestion.Text);
                cmd.Parameters.AddWithValue("@fa", txtFaqAnswer.Text);
                cmd.Parameters.AddWithValue("@fst", txtFaqSearchTerm.Text);
                cmd.ExecuteNonQuery();
                conn.Close();
                gvFaq.EditIndex = -1;
                BindFaqGrid();
            }
            catch(Exception ex)
            {
                lblUpdateFaqErr.Text = "Error" + ex.ToString();
            }
        }

        protected void gvFaq_RowDeleting(object sender, GridViewDeleteEventArgs e)
        {
            try
            {
                Label lblFaqId = gvFaq.Rows[e.RowIndex].FindControl("lblFaqId") as Label;
                conn.Open();
                SqlCommand cmd = new SqlCommand("DELETE FROM [FAQ] WHERE FaqID=@fid", conn);
                cmd.Parameters.AddWithValue("@fid", lblFaqId.Text);
                cmd.ExecuteNonQuery();
                conn.Close();
                gvFaq.EditIndex = -1;
                BindFaqGrid();

            }
            catch (Exception ex)
            {
                lblUpdateFaqErr.Text = "Error" + ex.ToString();
            }
        }

        protected void gvFaq_PageIndexChanging(object sender, GridViewPageEventArgs e)
        {
            gvFaq.PageIndex = e.NewPageIndex;
            BindFaqGrid();
        }

        protected void btnAddNewFaq_Click(object sender, EventArgs e)
        {
            try
            {
                conn.Open();
                SqlCommand cmd = new SqlCommand("INSERT INTO FAQ (FaqQuestion,FaqAnswer,FaqSearchTerm) VALUES (@fq,@fa,@fst)", conn);
                cmd.Parameters.AddWithValue("@fq", txtNewFaqQuestion.Text);
                cmd.Parameters.AddWithValue("@fa", txtNewFaqAnswer.Text);
                cmd.Parameters.AddWithValue("@fst", txtFaqSearchTerm.Text);
                cmd.ExecuteNonQuery();
                conn.Close();
                btnClearAddNewFaq_Click(sender, e);
                btnMainFaq_Click(sender, e);
            }
            catch (Exception ex)
            {
                lblAddNewFaqErr.Text = "Error" + ex.ToString();
            }

        }

        protected void btnClearAddNewFaq_Click(object sender, EventArgs e)
        {
            txtNewFaqQuestion.Text = "";
            txtNewFaqAnswer.Text = "";
            lblAddNewFaqErr.Text = "";
            txtFaqSearchTerm.Text = "";
        }

        protected void gvFeedback_PageIndexChanging(object sender, GridViewPageEventArgs e)
        {
            gvFeedback.PageIndex = e.NewPageIndex;
        }

      
    }
}