<%@ Page Title="" Language="C#" MasterPageFile="~/member.Master" AutoEventWireup="true" CodeBehind="viewforum.aspx.cs" Inherits="GroupAss.viewforum" MaintainScrollPositionOnPostback="true" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <style type="text/css">
        .auto-style1 {
            width: 100%;
        }
    </style>
</asp:Content>
<asp:Content ID="Content3" ContentPlaceHolderID="Main" runat="server">
     <link rel="stylesheet" href="master.css">
    <div class="forum-content">
        <h2 style="background-color: #d6d6d6;text-align:center">Main Thread</h2>
    <asp:DataList ID="dlViewForum" runat="server">
        <ItemTemplate>
            <table style="width:1400px; text-align:center">
                <tr>
                    <th  style="background-color:#5f5f5f;padding:2%;color:white">Created by</th>
                    <td style="padding:2%;text-align:left">
                        <asp:Label ID="lblUsername" runat="server" Text='<%# Eval("Username") %>'></asp:Label>
                    </td>
                </tr>
                <tr>
                    <th  style="background-color:#5f5f5f;padding:2%;color:white">Title</th>
                    <td style="padding:2%;text-align:left">
                        <asp:Label ID="lblTitle" runat="server" Text='<%# Eval("ForumTitle") %>'></asp:Label>
                    </td>
                </tr>
                <tr>
                    <th  style="background-color:#5f5f5f;padding:2%;color:white"">Content</th>
                    <td style="padding:2%;text-align:left">
                        <asp:Label ID="lblContent" runat="server" Text='<%# Eval("ForumText") %>'></asp:Label>
                    </td>
                </tr>
                <tr>
                     <th  style="background-color:#5f5f5f;padding:2%;color:white">Files</th>
                     <td style="padding:2%;text-align:left">
                        <asp:Label ID="lblFilename" runat="server" Text='<%# Eval("ForumFile") %>'></asp:Label>
                        <asp:LinkButton ID="lbDownload" runat="server" CommandArgument='<%#Eval("ForumFile") %>' OnClick="lbDownload_Click" >DOWNLOAD</asp:LinkButton>
                         <asp:Label ID="lblisHaveFile" runat="server" Text="No file present in this forum" Visible="false"></asp:Label>
                        <br />
                    </td>
                </tr>
                <tr>
                    <th style="background-color:#5f5f5f;padding:2%;color:white">Date Created</th>
                    <td style="padding:2%;text-align:left">
                        <asp:Label ID="lblDate" runat="server" Text='<%# Eval("ForumDate") %>'></asp:Label>
                    </td>
                    <th  style="background-color:#5f5f5f;padding:2%;color:white">Time Created</th>
                    <td style="padding:2%;text-align:left">
                        <asp:Label ID="lblTime" runat="server" Text='<%# Eval("ForumTime") %>'></asp:Label>
                    </td>
                </tr>
                <tr>
                    <td  style="padding:2%" colspan="2"> 
                        <asp:Button ID="btnReply" runat="server" Text="Reply" OnClick="btnReply_Click" class="btn btn-primary"/>&nbsp;&nbsp;&nbsp;
                        <asp:Button ID="btnCancel" runat="server" Text="Cancel" OnClick="btnCancel_Click" class="btn btn-primary" />
                    </td>
            </table>
        </ItemTemplate>
    </asp:DataList>
        </div>
    <div runat="server" visible="false" id="divforumReply" style="margin-top:10px;margin-left:20%">
        <asp:TextBox ID="txtReply" runat="server" Textmode="MultiLine" Rows="3" class="form-control" style="width:800px"></asp:TextBox>
        <asp:Button ID="btnEnter" runat="server" Text="Enter" OnClick="btnEnter_Click" class="btn btn-primary" />
    </div>
    <div class="replies" style="margin-top:3%">
        <h2 style="background-color: #d6d6d6">Replies to thread</h2>
        <asp:DataList ID="dlReplies" runat="server">
            <ItemTemplate>
                <table style="width:100%;table-layout: fixed;text-align:center;">
                    <tr>
                        <th style="padding:1%">Replied By:</th>
                        <td style="padding:1%;text-align:left">
                            <asp:Label ID="lblRepliesUserN" runat="server" Text='<%# Eval("Username") %>'></asp:Label>
                        </td>
                    </tr>
                    <tr>
                        <th style="padding:1%">Reply Text:</th>
                        <td style="padding:1%;text-align:left">
                            <asp:Label ID="lblRepliesContent" runat="server" Text='<%# Eval("ForumReplyText") %>'></asp:Label>
                        </td>
                    </tr>
                    <tr>
                        <th style="padding:1%">Reply Date:</th>
                        <td style="padding:1%;text-align:left">
                            <asp:Label ID="lblRepliesDate" runat="server" Text='<%# Eval("ForumReplyDate") %>'></asp:Label>
                        </td>
                        <th style="padding:1%">Reply Time</th>
                        <td style="padding:1%;text-align:left">
                            <asp:Label ID="lblRepliesTime" runat="server" Text='<%# Eval("ForumReplyTime") %>'></asp:Label>
                        </td>
                    </tr>
                </table>
                <hr />
            </ItemTemplate>
        </asp:DataList>
    </div>

</asp:Content>

