<%@ Page Title="" Language="C#" MasterPageFile="~/member.Master" AutoEventWireup="true" CodeBehind="communication.aspx.cs" Inherits="GroupAss.communication" MaintainScrollPositionOnPostback="true" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <style type="text/css">
        .auto-style1 {
            width: 100%;
        }
    </style>
</asp:Content>
<asp:Content ID="Content3" ContentPlaceHolderID="Main" runat="server">
    <link rel="stylesheet" href="master.css">
    
    <asp:MultiView ID="mvForum" runat="server" ActiveViewIndex="0" >
        <asp:View ID="vAllThread" runat="server">
       <asp:Button ID="btnAllThread" runat="server" Text="All Thread"  class="btn btn-primary" CommandName="SwitchViewByID" CommandArgument="vAllThread"/>
    <asp:Button ID="btnNewThread" runat="server" Text="Create New Thread"  class="btn btn-primary" CommandName="SwitchViewByID" CommandArgument="vNewThread"/>
            <div style="margin-top:2%;" >
                <br />
            <h2 style="background-color: #d6d6d6;text-align:center">All Threads</h2>
                <br />
            <div style="margin-left:3%">
<asp:DataList ID="dlForum" runat="server" RepeatDirection="Vertical" style="width:1400px">
               <ItemTemplate>    
            <table style="width:1600px; text-align:center;">
                <tr style="background-color:black;color:white">
                    <th style="padding:2%">Posted By</th>
                    <th style="padding:2%">Thread title</th>
                    <th style="padding:2%">View Thread</th>
                    <th style="padding:2%">Date Uploaded</th>
                    <th style="padding:2%">Time Uploaded</th>
                </tr>
                <tr>
                    <td style="padding:2%">
                        <asp:Label ID="lblUsername" runat="server" Text='<%#Eval("Username") %>'></asp:Label>

                    </td>
                    <td style="padding:2%">
                        <asp:Label ID="lblForumTitle" runat="server" Text='<%# Eval("ForumTitle") %>'></asp:Label>
                    </td>
                    <td style="padding:2%">
                        <asp:HyperLink ID="hlViewForum" runat="server" NavigateUrl='<%# "viewforum.aspx?ForumID="+Eval("ForumID") %>' style="color:blue;text-decoration:underline" >View Thread</asp:HyperLink>
                    </td>
                    <td style="padding:2%">
                        <asp:Label ID="lblDateUploaded" runat="server" Text='<%# Eval("ForumDate") %>'></asp:Label>
                    </td>
                    <td style="padding:2%">
                        <asp:Label ID="lblTimeUploded" runat="server" Text='<%# Eval("ForumTime") %>'></asp:Label>
                    </td>
                </tr>
            </table>
           <hr />
                </div>
        </ItemTemplate>
    </asp:DataList>
                
            </div>
              </div>
            </asp:View>
        <asp:View ID="vNewThread" runat="server">
            <asp:Button ID="btnAllThread1" runat="server" Text="All Thread"  class="btn btn-primary" CommandName="SwitchViewByID" CommandArgument="vAllThread" CausesValidation="false"/>
    <asp:Button ID="btnNewThread1" runat="server" Text="Create New Thread"  class="btn btn-primary" CommandName="SwitchViewByID" CommandArgument="vNewThread" CausesValidation="false"/>
           <div style="margin-top:2%">
            <div class="row">
        <div class="col">
        <div class="form-group">
            <br />
           <h2 style="background-color: #d6d6d6; text-align:center">New Forum</h2>
            <br />
        </div>
        </div>
    </div>
         <div class="container">
        <div class="row">
        <div class="col">
        <div class="form-group">
            <label class="label">Title</label>
            <asp:TextBox ID="txtTitle" class="form-control" runat="server" placeholder="Enter your Title of Content Here">
            </asp:TextBox>
            <asp:RequiredFieldValidator ID="rfvTitle" runat="server" ControlToValidate="txtTitle" ErrorMessage="Enter Title of Thread" ForeColor="Red"></asp:RequiredFieldValidator>
        </div>
        </div>
    </div>
         <div class="row">
        <div class="col">
        <div class="form-group">
            <label class="label">Content</label>
            <asp:TextBox ID="txtContent" class="form-control" placeholder="Place your content here" runat="server" TextMode="MultiLine"></asp:TextBox>
            <asp:RequiredFieldValidator ID="rfvContent" runat="server" ErrorMessage="Enter Content" ControlToValidate="txtContent" ForeColor="Red"></asp:RequiredFieldValidator>
        </div>
        </div>
    </div> 
        <div class="row">
        <div class="col">
        <div class="form-group">
            <label class="label">Upload Your File Here</label><br />
            <asp:FileUpload ID="FileUploadForum" runat="server" class="btn" style="background-color:blanchedalmond"/>
        </div>
        </div>
    </div>
        <div class="row">
        <div class="col d-flex justify-content-end" style="background-color: #DBF3FA" >
            <asp:Button ID="btnSave" runat="server" Text="Save" class="btn btn-primary" OnClick="btnSave_Click"/>

        </div>
         <div class="col">
            <asp:Button ID="btnClear" runat="server" Text="Clear" class="btn btn-primary" OnClick="btnClear_Click" CausesValidation="false"/>           
        </div>
            <asp:Label ID="lblStatus" runat="server" ></asp:Label>
    </div>
                 </div>
               </div>
        </asp:View>

    </asp:MultiView>
</asp:Content>

