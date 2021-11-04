<%@ Page Title="" Language="C#" MasterPageFile="~/member.Master" AutoEventWireup="true" CodeBehind="news.aspx.cs" Inherits="GroupAss.NewsAnnouncements" MaintainScrollPositionOnPostback="true" %>
<asp:Content ID="head" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content ID="Main" ContentPlaceHolderID="Main" runat="server">
    <style>
        .center {
            margin-left:auto;
            margin-right:auto;
            width:60%;
            background-color:white;
        }
     
  
      
    </style>
    <%--<div style="text-align:right">Welcome <%=Session["Username"].ToString() %><br />
                <asp:HyperLink ID="logout" runat="server" NavigateUrl="~/logout.aspx" Visible="False" ForeColor="Blue">Logout</asp:HyperLink>
            </div>--%>
    <div class="background" style="margin-left:3%">
         <br /><br />
            <h2 style="background-color: #d6d6d6;text-align:center">News Announcements</h2>
        <br />
        <div style="margin-left:20%">
            <asp:GridView ID="GridViewNews" runat="server" AutoGenerateColumns="False" Width="953px" AllowPaging="True" OnPageIndexChanging="GridViewNews_PageIndexChanging" CellPadding="4" ForeColor="Black" PageSize="3" BackColor="#CCCCCC" BorderColor="#999999" BorderStyle="Solid" BorderWidth="3px" CellSpacing="2">
                <Columns>
                   
                   <asp:TemplateField HeaderText="Image">
                       <ItemTemplate>
                           <asp:Image ID="newsImg" runat="server" ImageUrl='<%# Eval("NewsImage","~/images/News/{0}") %>' />
                       </ItemTemplate>
                       <ControlStyle Height="200px" Width="200px"/>
                   </asp:TemplateField>
                    <asp:BoundField DataField="NewsDesc" HeaderText="Description">
                    <ItemStyle Width="300px" />
                    </asp:BoundField>
                    <asp:BoundField DataField="NewsDate" HeaderText="Date" />
                    <asp:BoundField DataField="NewsTime" HeaderText="Time" />
                </Columns>

                <FooterStyle BackColor="#CCCCCC" />
                <HeaderStyle BackColor="Black" Font-Bold="True" ForeColor="White" />
                <PagerStyle BackColor="#CCCCCC" ForeColor="Black" HorizontalAlign="Left" Font-Size="Larger" Wrap="True" />
                <RowStyle BackColor="White" />
                <SelectedRowStyle BackColor="#000099" Font-Bold="True" ForeColor="White" />
                <SortedAscendingCellStyle BackColor="#F1F1F1" />
                <SortedAscendingHeaderStyle BackColor="#808080" />
                <SortedDescendingCellStyle BackColor="#CAC9C9" />
                <SortedDescendingHeaderStyle BackColor="#383838" />

            </asp:GridView>
            </div>
        </div>
    

</asp:Content>

        
