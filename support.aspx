<%@ Page Title="" Language="C#" MasterPageFile="~/member.Master" AutoEventWireup="true" CodeBehind="support.aspx.cs" Inherits="GroupAss.ServicesAndSupport" MaintainScrollPositionOnPostback="true" %>

<asp:Content ID="head" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content ID="Main" ContentPlaceHolderID="Main" runat="server">
    <style>
       
        #TextArea1 {
            height: 82px;
            width: 566px;
        }
       
        .center {
            margin-left:auto;
            margin-right:auto;
            width:50%;
            background-color:white;
        }
        .textbox{
            resize:none;
        }
    </style>


    
       <div class="background" style="margin-left:3%;">
            <asp:Menu ID="mnFeatures" Orientation="Horizontal" StaticMenuItemStyle-CssClass="tab" Font-Size="Large" 
                StaticSelectedStyle-CssClass="selectedTab" StaticMenuItemStyle-HorizontalPadding="50px" StaticSelectedStyle-BackColor="White"
                runat="server" OnMenuItemClick="mnFeatures_MenuItemClick" BackColor="White" >
                <Items>
                    <asp:MenuItem Text="Feedback" Value="0" Selected="true"></asp:MenuItem>
                    <asp:MenuItem Text="FAQ" Value="1"></asp:MenuItem>
                </Items>

<StaticMenuItemStyle HorizontalPadding="50px" CssClass="tab"></StaticMenuItemStyle>

<StaticSelectedStyle BackColor="#007bff" ForeColor="White" BorderColor="#007bff" CssClass="selectedTab"></StaticSelectedStyle>
            </asp:Menu>
           
            
                <asp:MultiView ID="mvMenu" ActiveViewIndex="0" runat="server">
                    <asp:View ID="View1" runat="server">
                        <br />
                        <h2 style="background-color: #d6d6d6;text-align:center">Your Feedbacks</h2>
                        <br />
                        <div style="width:800px; margin-left:20%">
                         <asp:GridView ID="GridViewFeed" runat="server" AutoGenerateColumns="False" AllowPaging="True" OnPageIndexChanging="GridViewFeed_PageIndexChanging" CellPadding="4" ForeColor="Black" Width="1000px" BackColor="#CCCCCC" BorderColor="#999999" BorderStyle="Solid" BorderWidth="1px" CellSpacing="2">
               
                <Columns>
                    
                    <asp:BoundField DataField="FeedbackDesc" HeaderText="Description">
                    <ItemStyle Width="180px" Height="20px"/>
                    </asp:BoundField>
                    <asp:BoundField DataField="Date" HeaderText="Date">
                    <ItemStyle Width="150px" HorizontalAlign="Center"  />
                    </asp:BoundField>
                    <asp:BoundField DataField="Time" HeaderText="Time" DataFormatString="{0:c}">
                    <ItemStyle Width="150px" HorizontalAlign="Center"  />
                    </asp:BoundField>
                  
                    
                </Columns>
                             <FooterStyle BackColor="#CCCCCC" />
                             <HeaderStyle BackColor="Black" Font-Bold="True" ForeColor="White"/>
                             <PagerStyle BackColor="#CCCCCC" ForeColor="Black" HorizontalAlign="Left" />
                             <RowStyle BackColor="White"/>
                             <SelectedRowStyle BackColor="#000099" Font-Bold="True" ForeColor="White" />
                             <SortedAscendingCellStyle BackColor="#F1F1F1" />
                             <SortedAscendingHeaderStyle BackColor="#808080" />
                             <SortedDescendingCellStyle BackColor="#CAC9C9" />
                             <SortedDescendingHeaderStyle BackColor="#383838" />
                </asp:GridView>


                        <br /><br /><br />
                       <h3>Please insert your feedback below:</h3><br />
                        <asp:TextBox ID="tbFeed" runat="server" TextMode="MultiLine" Width="800px" Placeholder="Insert text here..." Rows="5" CssClass="textbox"></asp:TextBox>
                        <asp:RequiredFieldValidator ID="rfvFeed" runat="server" ControlToValidate="tbFeed" ErrorMessage="Feedback cannot be left empty.." ForeColor="Red"></asp:RequiredFieldValidator>
                        <br /><br />
                        <asp:Button ID="btnFeed" runat="server" OnClick="btnFeed_Click" Text="Post" class="btn btn-primary"/>
                        <br />
                        
                        <asp:Label ID="lblResult" runat="server"></asp:Label>
                        <br />

                    </div>
                    </asp:View>
                    <asp:View ID="View2" runat="server">
                        <br />
                        <h2 style="background-color: #d6d6d6">Frequently Asked Questions</h2>
                                <asp:SqlDataSource ID="SqlDataSourceFAQ" runat="server" ConnectionString="<%$ ConnectionStrings:SwimmClubCon %>" SelectCommand="SELECT DISTINCT [FaqSearchTerm] FROM [FAQ]"></asp:SqlDataSource>
                        <br />
                        <div style="margin-left:25%">
                        <div class="row">
                            Categories:<asp:DropDownList ID="ddlFAQ" runat="server" Placeholder="Select one category" DataTextField="FaqSearchTerm" AutoPostBack="True" OnSelectedIndexChanged="ddlFAQ_SelectedIndexChanged" Height="40px" ForeColor="Black" class="form-control" style="width:400px">
                                       </asp:DropDownList>
                           &nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 
                        <asp:TextBox ID="tbFAQ" runat="server" Placeholder="Search FAQ" Height="40px" Width="200px" class="form-control"></asp:TextBox> &nbsp;&nbsp;
                        <asp:Button ID="btnFAQ" runat="server" OnClick="btnFAQ_Click" Text="Search" class="btn-primary btn" />
                            </div>
                        <br />
                        <br />
                        <asp:Label ID="lblMsg" runat="server" Font-Names="Arial"></asp:Label>
                        <br /><br />
                        <asp:GridView ID="GridViewFAQ" runat="server" AutoGenerateColumns="False" BackColor="White" BorderColor="#999999" BorderStyle="Solid" BorderWidth="1px" CellPadding="3" ForeColor="Black" GridLines="Vertical" Width="800px">
               
                            <AlternatingRowStyle BackColor="#CCCCCC" />
               
                <Columns>
                   
                    <asp:BoundField DataField="FaqQuestion" HeaderText="Question">
                    <ItemStyle Width="150px" />
                    </asp:BoundField>
                    <asp:BoundField DataField="FaqAnswer" HeaderText="Answer">
                    <ItemStyle Width="150px" />
                    </asp:BoundField>
                </Columns>
                            <FooterStyle BackColor="#CCCCCC" />
                            <HeaderStyle BackColor="Black" Font-Bold="True" ForeColor="White" />
                            <PagerStyle BackColor="#999999" ForeColor="Black" HorizontalAlign="Center" />
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
  