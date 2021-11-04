<%@ Page Title="" Language="C#" MasterPageFile="~/member.Master" AutoEventWireup="true" CodeBehind="maintenance.aspx.cs" Inherits="GroupAss.maintenance" MaintainScrollPositionOnPostback="true" %>
<asp:Content ID="head" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content ID="Main" ContentPlaceHolderID="Main" runat="server">
    <link rel="stylesheet" href="master.css" />
    <style>
         .textbox{
        resize:none;
    }
    </style>
    <div class="background" style="margin-left:3%;">
    <table>
        <tr>
            <td>
                &nbsp;
                <asp:Button ID="btnMaintainUsers" runat="server" Text="Maintain Users" class="btn btn-primary" OnClick="btnMaintainUsers_Click" CausesValidation="False" />
                &nbsp;
            </td>
            <td>
                &nbsp;
                <asp:Button ID="btnMainEcat" runat="server" Text="Maintain E-catalogue" class="btn btn-primary" OnClick="btnMainEcat_Click" CausesValidation="False" />
                &nbsp;
            </td>
            <td>
                &nbsp;
                <asp:Button ID="btnMainNews" runat="server" Text="Maintain News" class="btn btn-primary" OnClick="btnMainNews_Click" CausesValidation="False" />
                &nbsp;
            </td>
            <td>
                &nbsp;
                <asp:Button ID="btnMainFaq" runat="server" Text="Maintain FAQ's" class="btn btn-primary" OnClick="btnMainFaq_Click" CausesValidation="False" />
                &nbsp;
            </td>
            <td>
                &nbsp;
                <asp:Button ID="btnViewMemFeedback" runat="server" Text="View Member Feedback" class="btn btn-primary" OnClick="btnViewMemFeedback_Click" CausesValidation="False" />
                &nbsp;
            </td>
        </tr>
    </table>
    <asp:MultiView ID="mvMaintenance" runat="server" EnableViewState="false">
        <asp:View ID="vMainUsers" runat="server">
            <br />
            <div class="row">
            <asp:DropDownList ID="ddlSortBy" runat="server" OnSelectedIndexChanged="ddlSortBy_SelectedIndexChanged"  AutoPostBack="true" class="form-control" style="width:600px">
                <asp:ListItem>Choose 1</asp:ListItem>
                <asp:ListItem>Search</asp:ListItem>
                <asp:ListItem>All Users</asp:ListItem>
                <asp:ListItem>Admins</asp:ListItem>
                <asp:ListItem>Members</asp:ListItem>
                <asp:ListItem>Blocked Users</asp:ListItem>
            </asp:DropDownList>
            </div>
            <br />
            <div class="row">
            <asp:TextBox ID="txtSearchUsers" runat="server" Visible="false" Height="40px" class="form-control" style="width:200px"></asp:TextBox>&nbsp;
            <asp:Button ID="btnSearchUsers" runat="server" class="btn btn-primary" OnClick="btnSearchUsers_Click" Text="Search By Username" Visible="false" />
            </div>
            <br />
            <div  style="margin-left:5%">
            <asp:GridView ID="gvUsers" runat="server" AutoGenerateColumns="False" OnRowCommand="gvUsers_RowCommand" EmptyDataText="No records Found" AllowPaging="True" OnPageIndexChanging="gvUsers_PageIndexChanging" BackColor="#CCCCCC" BorderColor="#999999" BorderStyle="Solid" BorderWidth="3px" CellPadding="4" CellSpacing="2" ForeColor="Black">
                <Columns>
                    <asp:BoundField DataField="Username" HeaderText="Username" />
                    <asp:BoundField DataField="Fname" HeaderText="First name" />
                    <asp:BoundField DataField="Lname" HeaderText="Last Name" />
                    <asp:BoundField DataField="Dob" HeaderText="Date of Birth" />
                    <asp:BoundField DataField="ContactNo" HeaderText="Contact Number" />
                    <asp:BoundField DataField="Email" HeaderText="Email Address" />
                    <asp:BoundField DataField="Gender" HeaderText="Gender" />
                    <asp:BoundField DataField="Address" HeaderText="Physical Address" />
                    <asp:TemplateField HeaderText="User Type">
                        <ItemTemplate>
                            <asp:Label ID="lblYesAdmin" runat="server" Text="Admin" Visible="False"></asp:Label>
                            <asp:Label ID="lblYesMember" runat="server" Text="Member" Visible="False"></asp:Label>
                            <asp:Label ID="lblBlocked" runat="server" Text="(Blocked)" Visible="False"></asp:Label>
                            <asp:Label ID="lblIsAdmin" runat="server" Text='<%# Eval("isAdmin") %>' Visible="False"></asp:Label>
                            <asp:Label ID="lblIsBlocked" runat="server" Text='<%# Eval("isBlocked") %>' Visible="False"></asp:Label>
                        </ItemTemplate>
                    </asp:TemplateField>
                </Columns>
                <FooterStyle BackColor="#CCCCCC" />
                <HeaderStyle BackColor="Black" Font-Bold="True" ForeColor="White" />
                <PagerStyle BackColor="#CCCCCC" ForeColor="Black" HorizontalAlign="Left" />
                <RowStyle BackColor="White" Height="60px"/>
                <SelectedRowStyle BackColor="#000099" Font-Bold="True" ForeColor="White" />
                <SortedAscendingCellStyle BackColor="#F1F1F1" />
                <SortedAscendingHeaderStyle BackColor="#808080" />
                <SortedDescendingCellStyle BackColor="#CAC9C9" />
                <SortedDescendingHeaderStyle BackColor="#383838" />
            </asp:GridView>
                </div>
        </asp:View>
        <asp:View ID="vMainEcat" runat="server">
            <div>
            <br />
            <asp:DropDownList ID="ddlMaintainECat" runat="server" OnSelectedIndexChanged="ddlMaintainECat_SelectedIndexChanged" AutoPostBack="true" style="width:600px" class="form-control">
                <asp:ListItem>Choose 1</asp:ListItem>
                <asp:ListItem>Maintain Categories</asp:ListItem>
                <asp:ListItem>Maintain Products</asp:ListItem>
            </asp:DropDownList>
                </div>
            <div id="divMaintainCat" runat="server" visible="false">
                <br />
                <h2 style="background-color: #d6d6d6">Category Maintenance</h2>
                <br />
                <h3 style="background-color: #d6d6d6">Maintain Existing Categories</h3>
                <br />
                <div>
                <asp:GridView ID="gvCategories" runat="server" AllowPaging="True" AutoGenerateColumns="False" OnRowCancelingEdit="gvCategories_RowCancelingEdit" OnRowEditing="gvCategories_RowEditing" OnRowUpdating="gvCategories_RowUpdating" OnRowDeleting="gvCategories_RowDeleting" OnPageIndexChanging="gvCategories_PageIndexChanging" PageSize="5" BackColor="#CCCCCC" BorderColor="#999999" BorderStyle="Solid" BorderWidth="3px" CellPadding="4" CellSpacing="2" ForeColor="Black">
                    <Columns>
                        <asp:TemplateField>
                            <ItemTemplate>
                                <asp:Button ID="btnEditCat" runat="server" Text="Edit" CommandName="Edit" CausesValidation="False"  class="btn btn-primary" />
                            </ItemTemplate>
                            <EditItemTemplate>
                                <asp:Button ID="btnUpdateCat" runat="server" Text="Update" CommandName="Update" ValidationGroup="UpdatingCategory"  class="btn btn-primary"/>
                                <asp:Button ID="btnCancelUpdateCat" runat="server" Text="Cancel" CommandName="Cancel" CausesValidation="False"   class="btn btn-primary" />
                                <asp:Button ID="btnDeleteCat" runat="server" Text =" Delete" CommandName="Delete" CausesValidation="False"  class="btn btn-primary" />
                            </EditItemTemplate>
                            <ControlStyle BackColor="White" ForeColor="Black" Width="80px" />
                        </asp:TemplateField>
                        <asp:TemplateField HeaderText="Category ID">
                            <ItemTemplate>
                                <asp:Label ID="lblCatID" runat="server" Text='<%#Eval("CategoryID") %>'></asp:Label>
                            </ItemTemplate>
                        </asp:TemplateField>
                        <asp:TemplateField HeaderText="Short Description">
                            <ItemTemplate>
                                <asp:Label ID="lblCatShortDesc" runat="server" Text='<%#Eval("CategoryShortDesc") %>'></asp:Label>
                            </ItemTemplate>
                            <EditItemTemplate>
                                <asp:TextBox ID="txtCatShortDesc" runat="server" Text='<%#Eval("CategoryShortDesc") %>' TextMode="MultiLine" Wrap="true" Rows="5"></asp:TextBox>
                                <asp:RequiredFieldValidator ID="RVFEditShortDesc" runat="server" ControlToValidate="txtCatShortDesc" ErrorMessage="Short Description cannot be blank" ForeColor="Red" ValidationGroup="UpdatingCategory"></asp:RequiredFieldValidator>
                            </EditItemTemplate>
                        </asp:TemplateField>
                        <asp:TemplateField HeaderText="Long Description">
                            <ItemTemplate>
                                <asp:Label ID="lblCatLongDesc" runat="server" Text='<%#Eval("CategoryLongDesc") %>'></asp:Label>
                            </ItemTemplate>
                            <EditItemTemplate>
                                <asp:TextBox ID="txtCatLongDesc" runat="server" Text='<%#Eval("CategoryLongDesc") %>' TextMode="MultiLine" Wrap="true" Rows="5"></asp:TextBox>
                                <asp:RequiredFieldValidator ID="RVFlongDesc" runat="server" ControlToValidate="txtCatLongDesc" ErrorMessage="Long Description Cannot be blank" ForeColor="Red" ValidationGroup="UpdatingCategory"></asp:RequiredFieldValidator>
                            </EditItemTemplate>
                        </asp:TemplateField>
                    </Columns>
                    <FooterStyle BackColor="#CCCCCC" />
                    <HeaderStyle BackColor="Black" Font-Bold="True" ForeColor="White" />
                    <PagerStyle BackColor="#CCCCCC" ForeColor="Black" HorizontalAlign="Left" />
                    <RowStyle BackColor="White" Height="60px"/>
                    <SelectedRowStyle BackColor="#000099" Font-Bold="True" ForeColor="White" />
                    <SortedAscendingCellStyle BackColor="#F1F1F1" />
                    <SortedAscendingHeaderStyle BackColor="#808080" />
                    <SortedDescendingCellStyle BackColor="#CAC9C9" />
                    <SortedDescendingHeaderStyle BackColor="#383838" />
                </asp:GridView>
                    </div>
                <asp:Label ID="lblEditCatError" runat="server"></asp:Label>
                <br />
                <hr />
                <hr />
                <div>
                    <br />
                    <h3 style="background-color: #d6d6d6">Add a new Category</h3>
                    <br />
                    <table>
                        <tr>
                            <td>
                                <asp:Label ID="lblCatID" runat="server" Text="Category ID"></asp:Label>
                            </td>
                            <td>
                                <asp:TextBox ID="txtNewCatID" runat="server" TextMode="MultiLine" Wrap="true" class="form-control" style="width:400px"></asp:TextBox>
                            </td>
                            <td>
                                <asp:RequiredFieldValidator ID="RFVCatID" runat="server" ControlToValidate="txtNewCatID" ErrorMessage="Category ID cannot be blank" ForeColor="Red" ValidationGroup="AddingNewCategory"></asp:RequiredFieldValidator>
                            </td>
                        </tr>
                        <tr>
                            <td>
                                 <asp:Label ID="lblCatShortDesc" runat="server" Text="Short Description"></asp:Label>
                            </td>
                            <td>
                                <asp:TextBox ID="txtNewCatShortDesc" runat="server" TextMode="MultiLine" Wrap="true" Rows="3" class="form-control" style="width:800px"></asp:TextBox>
                            </td>
                            <td>
                                <asp:RequiredFieldValidator ID="RFVShortDesc" runat="server" ControlToValidate="txtNewCatShortDesc" ErrorMessage="Short Description cannot be blank" ForeColor="Red" ValidationGroup="AddingNewCategory"></asp:RequiredFieldValidator>
                            </td>
                        </tr>
                        <tr>
                            <td>
                                <asp:Label ID="lblCatLongDesc" runat="server" Text="Long Description"></asp:Label>
                            </td>
                            <td>
                                <asp:TextBox ID="txtNewCatLongDesc" runat="server" TextMode="MultiLine" Wrap="true" Rows="3" class="form-control" style="width:800px"></asp:TextBox>
                            </td>
                            <td>
                                <asp:RequiredFieldValidator ID="RVFLongDesc" runat="server" ControlToValidate="txtNewCatLongDesc" ErrorMessage="Long Description cannot be blank" ForeColor="Red" ValidationGroup="AddingNewCategory"></asp:RequiredFieldValidator>
                            </td>
                        </tr>
                        <tr>
                            <td></td>
                            <td>
                                <asp:Button ID="btnAddNewCat" runat="server" Text="Add" class="btn btn-primary" OnClick="btnAddNewCat_Click" ValidationGroup="AddingNewCategory"/>
                                &nbsp&nbsp&nbsp&nbsp&nbsp&nbsp
                                <asp:Button ID="btnClearNewCatFields" runat="server" Text="Clear" class="btn btn-primary" OnClick="btnClearNewCatFields_Click" CausesValidation="False"/>
                            </td>
                            <td></td>
                        </tr>
                    </table>
                   <asp:Label ID="lblAddNewCatError" runat="server" ForeColor="Red"></asp:Label>
                    
                    
                    
                </div>
            </div>
            <div id="divMaintainProd" runat="server" visible="false">
                <br />
                <h2 style="background-color: #d6d6d6">Product Maintenance</h2>
                <br />
                <h3 style="background-color: #d6d6d6">Maintain Existing Products</h3>
                <br />
                <asp:SqlDataSource ID="SqlDataSourceCatList" runat="server" ConnectionString="<%$ ConnectionStrings:SwimmClubCon %>" SelectCommand="SELECT [CategoryID], [CategoryShortDesc] FROM [Category]"></asp:SqlDataSource>
                <div class="row">
                <asp:DropDownList ID="ddlCategoryList" runat="server" DataTextField="CategoryShortDesc" DataValueField="CategoryID" DataSourceID="SqlDataSourceCatList" Height="40px" class="form-control" style="width:400px" ></asp:DropDownList>&nbsp;&nbsp;
                <asp:Button ID="btnViewSelectedCat" runat="server" CausesValidation="False" class="btn btn-primary" OnClick="btnViewSelectedCat_Click" Text="View" />
                </div>
                 <asp:GridView ID="gvProducts" runat="server" AutoGenerateColumns="False" OnRowEditing="gvProducts_RowEditing" OnRowCancelingEdit="gvProducts_RowCancelingEdit" OnRowUpdating="gvProducts_RowUpdating" OnRowDeleting="gvProducts_RowDeleting" OnPageIndexChanging="gvProducts_PageIndexChanging" AllowPaging="True" 
                    PageSize="5" BackColor="#CCCCCC" BorderColor="#999999" BorderStyle="Solid" BorderWidth="3px" CellPadding="4" CellSpacing="2" ForeColor="Black">
                    <Columns>
                        <asp:TemplateField>
                            <ItemTemplate>
                                <asp:Button ID="btnProdEdit" runat="server" CommandName="Edit" Text="Edit" CausesValidation="False"  class="btn btn-primary"/>
                            </ItemTemplate>
                            <EditItemTemplate>
                                <asp:Button ID="btnUpdateProd" runat="server" Text="Update" CommandName="Update" ValidationGroup="Update Product" class="btn btn-primary" />
                                <asp:Button ID="btnCancelUpdateProd" runat="server" Text="Cancel" CommandName="Cancel" CausesValidation="False" class="btn btn-primary" />
                                <asp:Button ID="btnDeleteProd" runat="server" Text =" Delete" CommandName="Delete" CausesValidation="False" class="btn btn-primary" />
                            </EditItemTemplate>
                            <ControlStyle BackColor="White" ForeColor="Black" Width="80px" />
                        </asp:TemplateField>
                        <asp:TemplateField HeaderText="Product ID">
                            <ItemTemplate>
                                <asp:Label ID="lblProdID" runat="server" Text='<%#Eval("ProductID") %>'></asp:Label>
                            </ItemTemplate>
                        </asp:TemplateField>
                        <asp:TemplateField HeaderText="Name">
                            <ItemTemplate>
                                <asp:Label ID="lblProdName" runat="server" Text='<%#Eval("ProductName") %>'></asp:Label>
                            </ItemTemplate>
                            <EditItemTemplate>
                                <asp:TextBox ID="txtProdName" runat="server" Text='<%#Eval("ProductName") %>' TextMode="MultiLine" Wrap="true" Rows="5" ></asp:TextBox>
                                <asp:RequiredFieldValidator ID="RVFUpdateName" runat="server" ErrorMessage="Name cannot be empty" ForeColor="Red" ValidationGroup="Update Product" ControlToValidate="txtProdName"></asp:RequiredFieldValidator>
                            </EditItemTemplate>
                        </asp:TemplateField>
                        <asp:TemplateField HeaderText="Description">
                            <ItemTemplate>
                                 <asp:Label ID="lblProdDesc" runat="server" Text='<%#Eval("ProductDescription") %>'></asp:Label>
                            </ItemTemplate>
                            <EditItemTemplate>
                                <asp:TextBox ID="txtProdDesc" runat="server" Text='<%#Eval("ProductDescription") %>' TextMode="MultiLine" Wrap="true" Rows="5"></asp:TextBox>
                                <asp:RequiredFieldValidator ID="RVFUpdateDesc" runat="server" ErrorMessage="Description cannot be blank" ForeColor="Red" ValidationGroup="Update Product" ControlToValidate="txtProdDesc"></asp:RequiredFieldValidator>
                            </EditItemTemplate>
                        </asp:TemplateField>
                        <asp:TemplateField HeaderText="Price">
                            <ItemTemplate>
                                <asp:Label ID="lblProdPrice" runat="server" Text='<%#Eval("ProductPrice","{0:c}") %>'></asp:Label>
                            </ItemTemplate>
                            <EditItemTemplate>
                                <asp:TextBox ID="txtProdPrice" runat="server" Text='<%#Eval("ProductPrice") %>'></asp:TextBox>
                                <asp:RequiredFieldValidator ID="RVFUpdatePrice" runat="server" ErrorMessage="Price cannot be blank" ForeColor="Red" ControlToValidate="txtProdPrice"></asp:RequiredFieldValidator>
                                <br />
                                <asp:RegularExpressionValidator ID="REVUpdatePrice" runat="server" ErrorMessage="Please enter a valid price e.g 10.00" ControlToValidate="txtProdPrice" ValidationGroup="Update Product" ForeColor="Red" ValidationExpression="^\d+(\.[0-9]{1,2})?$"></asp:RegularExpressionValidator>
                            </EditItemTemplate>
                        </asp:TemplateField>
                        <asp:TemplateField HeaderText="Quantity">
                            <ItemTemplate>
                                <asp:Label ID="lblProdQuant" runat="server" Text='<%#Eval("ProductQuantity") %>'></asp:Label>
                            </ItemTemplate>
                            <EditItemTemplate>
                                <asp:TextBox ID="txtProdQuant" runat="server"  Text='<%#Eval("ProductQuantity") %>' TextMode="number"></asp:TextBox>
                                <asp:RequiredFieldValidator ID="RVFUpdateQuantity" runat="server" ErrorMessage="Quantity cannot be blank" ForeColor="Red" ValidationGroup="Update Product" ControlToValidate="txtProdQuant"></asp:RequiredFieldValidator>
                                <br />
                                <asp:RangeValidator ID="rvUpdateQuantity" runat="server" ErrorMessage="please enter a valid quantity between 0 and 9999" ForeColor="Red" ValidationGroup="Update Product" ControlToValidate="txtProdQuant" MinimumValue="0" MaximumValue="9999"></asp:RangeValidator>
                            </EditItemTemplate>
                        </asp:TemplateField>
                        <asp:TemplateField HeaderText ="Image">
                            <ItemTemplate>
                                <asp:Image ID="imgProdImage" runat="server" ImageUrl='<%#Eval("ProductImage","~/Images/Products/{0}") %>' />
                            </ItemTemplate>
                            <EditItemTemplate>
                                <asp:Image ID="imgProdImage" runat="server" ImageUrl='<%#Eval("ProductImage","~/Images/Products/{0}") %>' />
                                <asp:FileUpload ID="fuProdImage" runat="server" />
                            </EditItemTemplate>
                            <ControlStyle Height="200px" Width="200px" />
                        </asp:TemplateField>
                        <asp:TemplateField HeaderText ="Category">
                            <ItemTemplate>
                                <asp:Label ID="lblProdCat" runat="server" Text='<%#Eval("CategoryShortDesc") %>'></asp:Label>
                                <asp:Label ID="lblProdCatId" runat="server" Text='<%#Eval("ProductCategoryID") %>' Visible="false"></asp:Label>
                            </ItemTemplate>
                            <EditItemTemplate>
                                <asp:Label ID="lblProdCatId" runat="server" Text='<%#Eval("ProductCategoryID") %>' Visible="false"></asp:Label>
                                <asp:DropDownList ID="ddlCatList" runat="server" DataTextField="CategoryShortDesc" DataValueField="CategoryID" DataSourceID="SqlDataSourceCatList" SelectedValue='<%# Eval("ProductCategoryID") %>'></asp:DropDownList>
                            </EditItemTemplate>
                        </asp:TemplateField>
                    </Columns>
                    <FooterStyle BackColor="#CCCCCC" />
                    <HeaderStyle BackColor="Black" Font-Bold="True" ForeColor="White" />
                    <PagerStyle BackColor="#CCCCCC" ForeColor="Black" HorizontalAlign="Left" />
                    <RowStyle BackColor="White" />
                    <SelectedRowStyle BackColor="#000099" Font-Bold="True" ForeColor="White" />
                    <SortedAscendingCellStyle BackColor="#F1F1F1" />
                    <SortedAscendingHeaderStyle BackColor="#808080" />
                    <SortedDescendingCellStyle BackColor="#CAC9C9" />
                    <SortedDescendingHeaderStyle BackColor="#383838" />
                </asp:GridView>
                <asp:Label ID="lblErrorEditProd" runat="server" Visible="false"></asp:Label>
                <br />
                <hr />
                <hr />
                <br />
                <div>
                    <h3 style="background-color: #d6d6d6">Add new Product</h3>
                    <br />
                    <table>
                        <tr>
                            <td>Product ID</td>
                            <td>
                                <asp:TextBox ID="txtNewProdID" runat="server" class="form-control" style="width:800px"></asp:TextBox>
                            </td>
                            <td>
                                <asp:RequiredFieldValidator ID="RVFNewProdID" runat="server" ErrorMessage="Product ID cannot be Blank" ForeColor="Red" ValidationGroup="Add New Product" ControlToValidate="txtNewProdID" ></asp:RequiredFieldValidator>
                            </td>
                        </tr>
                        <tr>
                            <td>Name</td>
                            <td>
                                <asp:TextBox ID="txtNewProdName" runat="server" TextMode="MultiLine" Wrap="true" Rows="3" class="form-control" style="width:800px" ></asp:TextBox>
                            </td>
                            <td>

                                <asp:RequiredFieldValidator ID="rvfNewProdName" runat="server" ControlToValidate="txtNewProdName" ErrorMessage="Name cannot be Blank" ForeColor="Red" ValidationGroup="Add New Product"></asp:RequiredFieldValidator>

                            </td>
                        </tr>
                        <tr>
                            <td>Description</td>
                            <td>
                                <asp:TextBox ID="txtNewProdDesc" runat="server" TextMode="MultiLine" Wrap="true" Rows="5" class="form-control" style="width:800px"></asp:TextBox>
                            </td>
                            <td>

                                <asp:RequiredFieldValidator ID="rvfNewProdDesc" runat="server" ControlToValidate="txtNewProdDesc" ErrorMessage="Description Cannot be Blank" ForeColor="Red" ValidationGroup="Add New Product"></asp:RequiredFieldValidator>

                            </td>
                        </tr>
                        <tr>
                            <td>Price</td>
                            <td>
                                <asp:TextBox ID="txtNewProdPrice" runat="server" class="form-control" style="width:300px"></asp:TextBox>
                            </td>
                            <td>
                                <asp:RequiredFieldValidator ID="RequiredFieldValidator3" runat="server" ControlToValidate="txtNewProdPrice" ErrorMessage="Price cannot be Blank" ForeColor="Red" ValidationGroup="Add New Product"></asp:RequiredFieldValidator>
                                <br />
                                <asp:RegularExpressionValidator ID="revtxtNewProdPrice" runat="server" ErrorMessage="Please enter a valid price e.g 10.00" ValidationGroup="Add New Product" ForeColor="Red" ControlToValidate="txtNewProdPrice" ValidationExpression="^\d+(\.[0-9]{1,2})?$"></asp:RegularExpressionValidator>
                            </td>
                        </tr>
                        <tr>
                            <td>Quantity</td>
                            <td>
                                <asp:TextBox ID="txtNewProdQuantity" runat="server" TextMode="Number" class="form-control" style="width:300px"></asp:TextBox>
                            </td>
                            <td>
                                <asp:RequiredFieldValidator ID="rvftxtProdQuantity" runat="server" ControlToValidate="txtNewProdQuantity" ErrorMessage="Quantity cannot be blank" ForeColor="Red" ValidationGroup="Add New Product"></asp:RequiredFieldValidator>
                                <br />
                                <asp:RangeValidator ID="rvNewProdQuantity" runat="server" ErrorMessage="Enter a valid range from 0 - 9999" MinimumValue="0" MaximumValue="9999" ControlToValidate="txtNewProdQuantity" ValidationGroup="Add New Product"></asp:RangeValidator>
                            </td>
                        </tr>
                        <tr>
                            <td>Image</td>
                            <td>
                                <asp:FileUpload ID="fuNewProdImage" runat="server" />
                            </td>
                            <td>
                                <asp:RequiredFieldValidator ID="RequiredFieldValidator5" runat="server" ControlToValidate="fuNewProdImage" ErrorMessage="You need to upload an Image" ForeColor="Red" ValidationGroup="Add New Product"></asp:RequiredFieldValidator>
                            </td>
                        </tr>
                        <tr>
                            <td>Category</td>
                            <td>
                                <asp:DropDownList ID="ddlNewProdCat" runat="server" DataTextField="CategoryShortDesc" DataValueField="CategoryID" DataSourceID="SqlDataSourceCatList" class="form-control" style="width:400px">
                                </asp:DropDownList>
                            </td>
                            <td>
                                <asp:RequiredFieldValidator ID="RequiredFieldValidator6" runat="server" ControlToValidate="ddlNewProdCat" ErrorMessage="Select a valid category" ForeColor="Red" ValidationGroup="Add New Product" InitialValue="-1"></asp:RequiredFieldValidator>
                            </td>
                        </tr>
                        <tr>
                            <td></td>
                            <td>
                                <asp:Button ID="btnAddNewProd" runat="server" Text="Add" class="btn btn-primary" OnClick="btnAddNewProd_Click" ValidationGroup="Add New Product" />
                                &nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp
                                <asp:Button ID="btnClearAddNewProd" runat="server" Text="Clear" class="btn btn-primary" OnClick="btnClearAddNewProd_Click" CausesValidation="False" />
                            </td>
                        </tr>
                    </table>
                    <asp:Label ID="lblErrAddNewProd" runat="server"></asp:Label>
                </div>
            </div>

        </asp:View>
        <asp:View ID="vMainNews" runat="server">
            <br />
            <h2 style="background-color: #d6d6d6">Maintain News</h2>
            <br />
            <asp:SqlDataSource ID="SqlDataSourceNews" runat="server" ConnectionString="<%$ ConnectionStrings:SwimmClubCon %>" SelectCommand="SELECT * FROM [News]"></asp:SqlDataSource>
            <asp:GridView ID="gvNews" runat="server" EmptyDataText="There is no news" AllowPaging="True" AutoGenerateColumns="False" OnRowCancelingEdit="gvNews_RowCancelingEdit" OnRowEditing="gvNews_RowEditing" OnRowUpdating="gvNews_RowUpdating" OnRowDeleting="gvNews_RowDeleting" OnPageIndexChanging="gvNews_PageIndexChanging" PageSize="5"
                BackColor="#CCCCCC" BorderColor="#999999" BorderStyle="Solid" BorderWidth="3px" CellPadding="4" CellSpacing="2" ForeColor="Black">
                <Columns>
                    <asp:TemplateField>
                        <ItemTemplate>
                            <asp:Button ID="btnEditNews" runat="server" Text="Edit" CommandName="Edit" CausesValidation="false" class="btn btn-primary"/>
                        </ItemTemplate>
                        <EditItemTemplate>
                            <asp:Button ID="btnUpdateNews" runat="server" Text="Update" CommandName="Update" ValidationGroup="Update News" class="btn btn-primary" />
                            <asp:Button ID="btnDeleteNews" runat="server" Text="Delete" CommandName="Delete" CausesValidation="false" class="btn btn-primary"/>
                            <asp:Button ID="btnCancelNewsUpdate" runat="server" Text="Cancel" CommandName="Cancel" CausesValidation="false" class="btn btn-primary"/>
                        </EditItemTemplate>
                        <ControlStyle BackColor="White" ForeColor="Black" Width="90px" />
                    </asp:TemplateField>
                    <asp:TemplateField HeaderText="News ID">
                        <ItemTemplate>
                            <asp:Label ID="lblNewsID" runat="server" Text='<%#Eval("NewsID") %>'></asp:Label>
                        </ItemTemplate>
                    </asp:TemplateField>
                    <asp:TemplateField HeaderText ="Image">
                        <ItemTemplate>
                            <asp:Image ID="imgNewsImage" runat="server" ImageUrl='<%#Eval("NewsImage","~/Images/News/{0}") %>' />
                        </ItemTemplate>
                        <EditItemTemplate>
                            <asp:Image ID="imgNewsImage" runat="server" ImageUrl='<%#Eval("NewsImage","~/Images/News/{0}") %>' />
                            <asp:FileUpload ID="fuNewsImage" runat="server" />
                        </EditItemTemplate>
                        <ControlStyle Height="200px" Width="200px" />
                    </asp:TemplateField>
                    <asp:TemplateField HeaderText="News Description">
                        <ItemTemplate>
                            <asp:Label ID="lblNewsDesc" runat="server" Text='<%#Eval("NewsDesc") %>'></asp:Label>
                        </ItemTemplate>
                        <EditItemTemplate>
                            <asp:TextBox ID="txtNewsDesc" runat="server" Text='<%#Eval("NewsDesc") %>' TextMode="MultiLine" Wrap="true" Rows="5"></asp:TextBox>
                            <asp:RequiredFieldValidator ID="RVFNewsDesc" runat="server" ErrorMessage="Description cannot be blank" ForeColor="Red" ControlToValidate="txtNewsDesc" ValidationGroup="Update News"></asp:RequiredFieldValidator>
                        </EditItemTemplate>
                    </asp:TemplateField>
                    <asp:TemplateField HeaderText="News Date (last updated)">
                        <ItemTemplate>
                            <asp:Label ID="lblNewsDate" runat="server" Text='<%#Eval("NewsDate") %>'></asp:Label>
                        </ItemTemplate>
                    </asp:TemplateField>
                    <asp:TemplateField HeaderText="News Time (last updated)">
                        <ItemTemplate>
                            <asp:Label ID="lblNewsTime" runat="server" Text='<%#Eval("NewsTime") %>'></asp:Label>
                        </ItemTemplate>
                    </asp:TemplateField>
                </Columns>
                <FooterStyle BackColor="#CCCCCC" />
                <HeaderStyle BackColor="Black" Font-Bold="True" ForeColor="White" />
                <PagerStyle BackColor="#CCCCCC" ForeColor="Black" HorizontalAlign="Left" />
                <RowStyle BackColor="White" />
                <SelectedRowStyle BackColor="#000099" Font-Bold="True" ForeColor="White" />
                <SortedAscendingCellStyle BackColor="#F1F1F1" />
                <SortedAscendingHeaderStyle BackColor="#808080" />
                <SortedDescendingCellStyle BackColor="#CAC9C9" />
                <SortedDescendingHeaderStyle BackColor="#383838" />
            </asp:GridView>
            <asp:Label ID="lblUpdateNewsError" runat="server"></asp:Label>
            <br />
            <hr />
            <hr />
            <h3 style="background-color: #d6d6d6">Add new News</h3>
            <br />
            <table>
                <tr>
                    <td>News Image</td>
                    <td>
                        <asp:FileUpload ID="fuNewNewsImage" runat="server" />
                    </td>
                    <td>
                        <asp:RequiredFieldValidator ID="RVFNewNewsImage" runat="server" ErrorMessage="You must Upload an Image to Add News" ForeColor="Red" ControlToValidate="fuNewNewsImage" ValidationGroup="Add New News"></asp:RequiredFieldValidator>
                    </td>
                </tr>
                <tr>
                    <td>News Description</td>
                    <td>
                        <asp:TextBox ID="txtNewsDesc" runat="server"></asp:TextBox>
                    </td>
                    <td>
                        <asp:RequiredFieldValidator ID="RVFNewNewsDesc" runat="server" ErrorMessage="You must Have a description for your News" ForeColor="Red" ControlToValidate="txtNewsDesc" ValidationGroup="Add New News" ></asp:RequiredFieldValidator>
                    </td>
                </tr>
                <tr>
                    <td class="auto-style1"></td>
                    <td class="auto-style1">
                        <asp:Button ID="btnAddNews" runat="server" Text="AddNews" class="btn btn-primary" OnClick="btnAddNews_Click" />
                        &nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp
                        <asp:Button ID="btnClearNews" runat="server" Text="Clear" class="btn btn-primary" CausesValidation="false" OnClick="btnClearNews_Click"/>
                    </td>
                    <td></td>
                </tr>
            </table>
            <asp:Label ID="lblAddNewsErr" runat="server"></asp:Label>
        </asp:View>
        <asp:View ID="vMainFaq" runat="server">
            <br />
            <h2 style="background-color: #d6d6d6">Maintain Frequently Asked Questions</h2>
            <br />
            <h3 style="background-color: #d6d6d6">Current Frequently Asked Questions</h3>
            <br />
            <asp:SqlDataSource ID="SqlDataSourceFaq" runat="server" ConnectionString="<%$ ConnectionStrings:SwimmClubCon %>" SelectCommand="SELECT * FROM [FAQ]"></asp:SqlDataSource>
            <asp:GridView ID="gvFaq" runat="server" EmptyDataText="There is no FAQ" AllowPaging="True" AutoGenerateColumns="False" OnRowCancelingEdit="gvFaq_RowCancelingEdit" OnRowEditing="gvFaq_RowEditing" OnRowUpdating="gvFaq_RowUpdating" OnRowDeleting="gvFaq_RowDeleting" OnPageIndexChanging="gvFaq_PageIndexChanging" PageSize="5"
                BackColor="#CCCCCC" BorderColor="#999999" BorderStyle="Solid" BorderWidth="3px" CellPadding="4" CellSpacing="2" ForeColor="Black">
                <Columns>
                    <asp:TemplateField>
                        <ItemTemplate> 
                            <asp:Button ID="btnEditFaq" runat="server" Text="Edit" CommandName="Edit" CausesValidation="false" class="btn btn-primary" />
                        </ItemTemplate>
                        <EditItemTemplate>
                            <asp:Button ID="btnUpdateFaq" runat="server" Text="Update" CommandName="Update" ValidationGroup="Update FAQ" class="btn btn-primary"/>
                            <asp:Button ID="btnCancelFaq" runat="server" Text="Cancel" CommandName="Cancel" CausesValidation="false" class="btn btn-primary" />
                            <asp:Button ID="btnDeleteFaq" runat="server" Text="Delete" CommandName="Delete" CausesValidation="false" class="btn btn-primary" />
                        </EditItemTemplate>
                        <ControlStyle BackColor="White" ForeColor="Black" Width="90px" />
                    </asp:TemplateField>
                    <asp:TemplateField HeaderText="FAQ ID">
                        <ItemTemplate>
                            <asp:Label ID="lblFaqId" runat="server" Text='<%#Eval("FaqID") %>' ></asp:Label>
                        </ItemTemplate>
                    </asp:TemplateField>
                    <asp:TemplateField HeaderText="Question">
                        <ItemTemplate>
                            <asp:Label ID="lblFaqQuestion" runat="server" Text='<%#Eval("FaqQuestion") %>' ></asp:Label>
                        </ItemTemplate>
                        <EditItemTemplate>
                            <asp:TextBox ID="txtFaqQuestion" runat="server" Text='<%#Eval("FaqQuestion") %>' TextMode="MultiLine" Wrap="true" Rows="5"></asp:TextBox>
                            <asp:RequiredFieldValidator ID="rvftxtFaqQuestion" runat="server" ErrorMessage="Question cannot be left Blank" ForeColor="Red" ControlToValidate="txtFaqQuestion" ValidationGroup="Update FAQ"></asp:RequiredFieldValidator>
                        </EditItemTemplate>
                    </asp:TemplateField>
                    <asp:TemplateField HeaderText="Answer">
                        <ItemTemplate>
                            <asp:Label ID="lblFaqAnswer" runat="server" Text='<%#Eval("FaqAnswer") %>' ></asp:Label>
                        </ItemTemplate>
                        <EditItemTemplate>
                            <asp:TextBox ID="txtFaqAnswer" runat="server" Text='<%#Eval("FaqAnswer") %>' TextMode="MultiLine" Wrap="true" Rows="5"></asp:TextBox>
                            <asp:RequiredFieldValidator ID="rvftxtFaqAnswer" runat="server" ErrorMessage="Answer cannot be left blank" ForeColor="Red" ControlToValidate="txtFaqAnswer" ValidationGroup="Update FAQ"></asp:RequiredFieldValidator>
                        </EditItemTemplate>
                    </asp:TemplateField>
                    <asp:TemplateField HeaderText="Search Term">
                        <ItemTemplate>
                            <asp:Label ID="lblFaqSearchTerm" runat="server" Text='<%#Eval("FaqSearchTerm") %>' ></asp:Label>
                        </ItemTemplate>
                        <EditItemTemplate>
                            <asp:TextBox ID="txtFaqSearchTerm" runat="server" Text='<%#Eval("FaqSearchTerm") %>'></asp:TextBox>
                            <asp:RequiredFieldValidator ID="rvfFaqSearchTerm" runat="server" ErrorMessage="Search term cannot be blank" ForeColor="Red" ControlToValidate="txtFaqSearchTerm" ValidationGroup="Update FAQ"></asp:RequiredFieldValidator>
                        </EditItemTemplate>
                    </asp:TemplateField>
                </Columns>
                <FooterStyle BackColor="#CCCCCC" />
                <HeaderStyle BackColor="Black" Font-Bold="True" ForeColor="White" />
                <PagerStyle BackColor="#CCCCCC" ForeColor="Black" HorizontalAlign="Left" />
                <RowStyle BackColor="White" />
                <SelectedRowStyle BackColor="#000099" Font-Bold="True" ForeColor="White" />
                <SortedAscendingCellStyle BackColor="#F1F1F1" />
                <SortedAscendingHeaderStyle BackColor="#808080" />
                <SortedDescendingCellStyle BackColor="#CAC9C9" />
                <SortedDescendingHeaderStyle BackColor="#383838" />
            </asp:GridView>
            <asp:Label ID="lblUpdateFaqErr" runat="server" Text=""></asp:Label>
            <br />
            <br />
            <hr />
            <hr />
            <h3 style="background-color: #d6d6d6">Add a New Frequently Asked Question</h3>
            <br />
            <table>
                <tr>
                    <td>FAQ Question</td>
                    <td>
                        <asp:TextBox ID="txtNewFaqQuestion" runat="server" TextMode="MultiLine" Wrap="true" Rows="5" class="form-control" style="width:600px"></asp:TextBox>
                    </td>
                    <td>
                        <asp:RequiredFieldValidator ID="RVFNewFaqQuestion" runat="server" ErrorMessage="Question text cannot be empty" ForeColor="Red" ControlToValidate="txtNewFaqQuestion" ValidationGroup="Add FAQ"></asp:RequiredFieldValidator>
                    </td>
                </tr>
                <tr>
                    <td>FAQ Answer</td>
                    <td>
                        <asp:TextBox ID="txtNewFaqAnswer" runat="server"  TextMode="MultiLine" Wrap="true" Rows="5" class="form-control" style="width:600px"></asp:TextBox>
                    </td>
                    <td>
                        <asp:RequiredFieldValidator ID="rvfNewFaqAnswer" runat="server" ErrorMessage="Answer text cannot be empty" ForeColor="Red" ControlToValidate="txtNewFaqAnswer" ValidationGroup="Add FAQ"></asp:RequiredFieldValidator>
                    </td>
                </tr>
                <tr>
                    <td>
                        FAQ Search Term
                    </td>
                    <td>
                        <asp:TextBox ID="txtFaqSearchTerm" runat="server" class="form-control" style="width:100px"></asp:TextBox>
                    </td>
                    <td>
                        <asp:RequiredFieldValidator ID="rvftxtFaqSearchTerm" runat="server" ErrorMessage="Search term is required" ForeColor="Red" ControlToValidate="txtFaqSearchTerm" ValidationGroup="Add FAQ"></asp:RequiredFieldValidator>
                    </td>
                </tr>
                <tr>
                    <td></td>
                    <td>
                        <asp:Button ID="btnAddNewFaq" runat="server" Text="Add" class="btn btn-primary" ValidationGroup="Add FAQ" OnClick="btnAddNewFaq_Click"/>
                        &nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp
                        <asp:Button ID="btnClearAddNewFaq" runat="server" Text="Clear" class="btn btn-primary" CausesValidation="false" OnClick="btnClearAddNewFaq_Click"/>
                    </td>
                </tr>
            </table>
            <asp:Label ID="lblAddNewFaqErr" runat="server"></asp:Label>
        </asp:View>
        <asp:View ID="vMemFeedback" runat="server">
            <br />
            <h2 style="background-color: #d6d6d6">Member Feedback</h2>
            <br />
            <asp:SqlDataSource ID="SQLDataSourceFeedback" runat="server" ConnectionString="<%$ ConnectionStrings:SwimmClubCon %>" SelectCommand="SELECT * FROM [Feedback]"></asp:SqlDataSource>
            <div style="margin-left:20%">
            <asp:GridView ID="gvFeedback" runat="server" EmptyDataText="There is no Feedback From Members" AllowPaging="True" AutoGenerateColumns="False" OnPageIndexChanging="gvFeedback_PageIndexChanging" AllowSorting="True" DataKeyNames="FeedbackID" DataSourceID="SQLDataSourceFeedback"
                 BackColor="#CCCCCC" BorderColor="#999999" BorderStyle="Solid" BorderWidth="3px" CellPadding="4" CellSpacing="2" ForeColor="Black" Width="900px">
                <Columns>
                    <asp:BoundField DataField="Username" HeaderText="Username" SortExpression="Username" />
                    <asp:BoundField DataField="FeedbackDesc" HeaderText="FeedbackDesc" SortExpression="FeedbackDesc" />
                    <asp:BoundField DataField="Date" HeaderText="Date" SortExpression="Date" />
                    <asp:BoundField DataField="Time" HeaderText="Time" SortExpression="Time" />
                </Columns>
                <FooterStyle BackColor="#CCCCCC" />
                <HeaderStyle BackColor="Black" Font-Bold="True" ForeColor="White" />
                <PagerStyle BackColor="#CCCCCC" ForeColor="Black" HorizontalAlign="Left" />
                <RowStyle BackColor="White" Height="30px"/>
                <SelectedRowStyle BackColor="#000099" Font-Bold="True" ForeColor="White" />
                <SortedAscendingCellStyle BackColor="#F1F1F1" />
                <SortedAscendingHeaderStyle BackColor="#808080" />
                <SortedDescendingCellStyle BackColor="#CAC9C9" />
                <SortedDescendingHeaderStyle BackColor="#383838" />
            </asp:GridView>
                </div>
        </asp:View>
    </asp:MultiView>
        </div>
</asp:Content>

