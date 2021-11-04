<%@ Page Title="" Language="C#" MasterPageFile="~/member.Master" AutoEventWireup="true" CodeBehind="cart.aspx.cs" Inherits="GroupAss.cart" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="Main" runat="server">
        <br />
    <H2 style="background-color: #d6d6d6;text-align:center">My Cart</H2>
        <br />
   <div style="margin-left:20%">
    <asp:GridView ID="gvMyCart" runat="server" EmptyDataText="You have no items in Your Cart" AutoGenerateColumns="False" AllowPaging="True" OnRowCancelingEdit="gvMyCart_RowCancelingEdit" OnRowUpdating="gvMyCart_RowUpdating" OnRowDeleting="gvMyCart_RowDeleting" OnPageIndexChanging="gvMyCart_PageIndexChanging" OnRowEditing="gvMyCart_RowEditing" BackColor="#CCCCCC" BorderColor="#999999" BorderStyle="Solid" BorderWidth="3px" CellPadding="4" CellSpacing="2" ForeColor="Black" style="text-align:center;">
        <Columns>
            <asp:TemplateField Visible="false">
                <ItemTemplate>
                    <asp:Label ID="lblProductID" runat="server" Text='<%#Eval("ProductID")%>' Visible="false"></asp:Label>
                </ItemTemplate>
                <ControlStyle Width="80px" />
            </asp:TemplateField>
            <asp:BoundField HeaderText="Product Name" DataField="ProductName"/>
            <asp:BoundField HeaderText="Product Description" DataField="ProductDescription" />
            <asp:TemplateField HeaderText="Price Per Piece">
                <ItemTemplate>
                    <asp:Label ID="lblPrice" runat="server" Text='<%#Eval("ProductPrice","{0:c}")%>'></asp:Label>
                </ItemTemplate>
            </asp:TemplateField>
            <asp:TemplateField HeaderText="Quantity">
                <ItemTemplate>
                    <asp:Label ID="lblQuantity" runat="server"  Text='<%#Eval("Quantity")%>'></asp:Label>
                    <asp:Button ID="btnEditQuant" runat="server" Text="Edit" CommandName="Edit" />

                </ItemTemplate>
                <EditItemTemplate>
                    <asp:TextBox ID="txtQuantity" runat="server" Text='<%#Eval("Quantity")%>' TextMode="Number"></asp:TextBox>
                    <asp:Button ID="btnUpdateQuant" runat="server" Text="Save" CommandName="Update" ValidationGroup="Update quant" />
                    <asp:Button ID="btnCancelEdit" runat="server" Text="Cancel" CommandName="Cancel" CausesValidation="false" />
                    <br />
                    <asp:RequiredFieldValidator ID="rvfQuant" runat="server" ErrorMessage="quantity cannot be empty" ValidationGroup="Update quant" ControlToValidate="txtQuantity" ForeColor="Red"></asp:RequiredFieldValidator>
                    <br />
                    <asp:RangeValidator ID="rvQuant" runat="server" ErrorMessage="quantity cannot be less than 0 or more than 100" ForeColor="Red" ControlToValidate="txtQuantity" MinimumValue="1" MaximumValue="100" ValidationGroup="Update quant" Type="Integer"></asp:RangeValidator>
                </EditItemTemplate>
                <ControlStyle BackColor="White" ForeColor="Black" Width="60px" />
            </asp:TemplateField>
            <asp:TemplateField HeaderText="Product Image">
                <ItemTemplate>
                    <asp:Image ID="imgProdImage" runat="server" ImageUrl='<%#Eval("ProductImage","~/Images/Products/{0}") %>'  />
                </ItemTemplate>
                <ControlStyle Width="200px" />
            </asp:TemplateField>
            <asp:TemplateField HeaderText="Total Price">
                <ItemTemplate>
                    <asp:Label ID="lblTotal" runat="server" Text='<%#Eval("total","{0:c}") %>'></asp:Label>
                </ItemTemplate>
            </asp:TemplateField>
            <asp:TemplateField>
                <ItemTemplate>
                    <asp:Button ID="btnDelFromCart" runat="server" Text="Delete" CommandName="Delete" />
                </ItemTemplate>
                <ControlStyle BackColor="White" ForeColor="Black" Width="60px" />
            </asp:TemplateField>
            
        </Columns>
        <FooterStyle BackColor="#CCCCCC" />
        <HeaderStyle BackColor="Black" Font-Bold="True" ForeColor="White" />
        <PagerStyle BackColor="#CCCCCC" ForeColor="Black" HorizontalAlign="Left" />
        <RowStyle BackColor="White" />
        <SelectedRowStyle BackColor="#000099" Font-Bold="True" ForeColor="White" />
        <SortedAscendingCellStyle BackColor="#F1F1F1" />
        <SortedAscendingHeaderStyle BackColor="Gray" />
        <SortedDescendingCellStyle BackColor="#CAC9C9" />
        <SortedDescendingHeaderStyle BackColor="#383838" />
    </asp:GridView>
       
    <asp:Label ID="lblErrUpdating" runat="server"></asp:Label>
    <table style="margin-top:5%">
        <tr>
            <td style="font-weight:bold">
                 <asp:Label ID="lblCostOFAll" Text="Cost Of All the items currently in your Cart: " runat="server"></asp:Label>
            </td>
            <td>
                <asp:Label ID="lblCostofAllitemsincart" runat="server"></asp:Label>
            </td>
        </tr>
        <tr>
            <td style="padding-top:2%">
                <asp:Button ID="btnBuyAll" runat="server" Text="Buy All" class="btn btn-primary" OnClick="btnBuyAll_Click" />
            </td>
            <td style="padding-top:2%">
                <asp:Button ID="btnRemoveAll" runat="server" Text="Remove All Items from Cart" class="btn btn-primary" OnClick="btnRemoveAll_Click" />
            </td>
        </tr>
    </table>
        </div>

    </asp:Content>
