<%@ Page Title="" Language="C#" MasterPageFile="~/member.Master" AutoEventWireup="true" CodeBehind="catalouge.aspx.cs" Inherits="GroupAss.catalouge" MaintainScrollPositionOnPostback="true" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server"></asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="Main" runat="server">
    <div class="background" style="margin-left:3%">
        <div class="row">
        <asp:TextBox ID="txtSearchBar" runat="server" style="width:300px; height:35px" class="form-control"></asp:TextBox>
         <asp:Button ID="btnSearch" runat="server" Text="Search"  OnClick="btnSearch_Click" class="btn btn-primary" style="margin-left:1%"/>
        </div>
        
    <asp:DataList ID="dlCategory" runat="server" RepeatDirection="Horizontal" style="width:1500px; letter-spacing:2px;justify-content:space-evenly; margin-top:2%; text-decoration:underline">
        <ItemTemplate>
            <table style="width:100%">
                <tr>
                    <td>
 <asp:HyperLink ID="hlCategory" runat="server" NavigateUrl='<%# "?CategoryID="+Eval("CategoryID") %>' Text='<%# Eval("CategoryShortDesc") %>' style="color:blue"></asp:HyperLink>
                    </td>
                </tr>
                </table>
           
        </ItemTemplate>
    </asp:DataList>
  <div style="margin-left:5%">
    <asp:DataList ID="dlProduct" runat="server" RepeatDirection="Horizontal" RepeatColumns="6" OnItemCommand="dlProduct_ItemCommand">
        <ItemTemplate>
            <table style="text-align:center; width:100%; margin-top:30%" >
                <tr>
                    <td class="td">
                        <asp:Image ID="imgProd" runat="server" ImageUrl='<%# Eval("ProductImage","~/Images/Products/{0}") %>' />
                    </td>
                </tr>
                <tr>
                    <td class="td">
                        <asp:Label ID="lblProductID" runat="server" Text="Product ID" Visible="false"></asp:Label>
                        <asp:Label ID="lblProdID" runat="server" Text='<%# Eval("ProductID") %>' Visible="false"></asp:Label>
                    </td>
                </tr>
                <tr>
                    <td class="td">
                        <asp:Label ID="lblProdName" runat="server" Text='<%# Eval("ProductName") %>'></asp:Label>
                    </td>
                </tr>
                <tr>
                    <td class="td">
                        <asp:Label ID="lblPrice" runat="server" Text='<%# Eval("ProductPrice","{0:c}") %>' ForeColor="OrangeRed"></asp:Label>
                    </td>
                </tr>
                <tr>
                    <td class="td">
                        <asp:Label ID="lblProductQuantity" runat="server" Text="IN STOCK"></asp:Label><br />
                        <asp:Label ID="lblInStock" runat="server" Text='<%# Eval("ProductQuantity") %>'></asp:Label>
                    </td>
                </tr>
                <tr>
                    <td>
                        <asp:TextBox ID="txtQuantity" runat="server" Text="1" TextMode="Number" Width="20%" style="text-align:center; padding-left:5%"></asp:TextBox>
                    </td>
                </tr>
                <tr>
                    <td class="auto-style2">
                        <asp:Button ID="btnAddtocart" runat="server" Text="Add to Shopping Cart" class="btn btn-primary" CommandName="AddCart" />
                    </td>
                </tr>
            </table>
        </ItemTemplate>

    </asp:DataList>
      </div>
        </div>
</asp:Content>
