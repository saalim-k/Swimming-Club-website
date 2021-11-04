<%@ Page Language="C#" AutoEventWireup="true" MasterPageFile="~/member.Master" CodeBehind="login.aspx.cs" Inherits="GroupAss.login" MaintainScrollPositionOnPostback="true" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server"></asp:Content>
<asp:Content ID="Content3" ContentPlaceHolderID="Main" runat="server">
                     <h1 style="background-color: #d6d6d6; text-align:center">LOG IN FORM</h1>
                    <hr />
                   <div>
                    <asp:MultiView ID="logForgPage" runat="server" ActiveViewIndex="0">
                        <asp:View ID="view1" runat="server">
                            <table style="width:800px;margin-left:35%;margin-top:2%">
                                <tr>
                                    <td style="padding:1%">
                                        <asp:Label runat="server" AssociatedControlID="Username">Username:</asp:Label>
                                    </td>
                                    <td style="padding:1%">
                                        <asp:TextBox runat="server" ID="Username" class="form-control"/>
                                    </td>
                                    <td style="padding:1%">
                                        <asp:RequiredFieldValidator runat="server" 
                                            ControlToValidate="Username"
                                            ForeColor="Red"
                                            ErrorMessage="Please Enter Valid Username!." />
                                    </td>
                                </tr>
                                <tr>
                                    <td style="padding:1%">
                                        <asp:Label runat="server" AssociatedControlID="Password">Password:</asp:Label>
                                    </td>
                                    <td style="padding:1%">
                                        <asp:TextBox runat="server" ID="Password" TextMode="Password" class="form-control"/>
                                         <asp:Label ID="lblErrorMessage" runat="server" ForeColor="Red"></asp:Label>
                                    </td>
                                    <td style="padding:1%">
                                        <asp:RequiredFieldValidator runat="server" 
                                            ControlToValidate="Password" 
                                            ForeColor="Red"
                                            ErrorMessage="Password Is Required To LogIn." />
                                    </td>
                                </tr>
                                <tr>
                                    <td style="padding:1%">
                                        &nbsp;</td>
                                    <td style="padding:1%">
                                        <asp:CheckBox ID="RememberMe" runat="server" />
                                        <asp:Label runat="server" AssociatedControlID="RememberMe">Remember me?</asp:Label>
                                    </td>
                                </tr>
                                <tr>
                                    <td style="padding:1%;">
                                        &nbsp;</td>
                                    <td style="padding:1%; width:auto">
                                    <asp:Button ID="btnLogin" runat="server" OnClick="btnLogin_Click" Text="Log in" class="btn btn-primary"/>
                                    <asp:Button ID="btnNext1" runat="server" OnClick="btnNext1_Click" Text="Forgot Your Password?" CausesValidation="false" class="btn btn-primary"/>
                                    </td>
                                </tr>
                            </table>
                        </asp:View>
                        <asp:View ID="view2" runat="server">
                            <asp:SqlDataSource ID="SqlDataSource1" runat="server" ConnectionString="<%$ ConnectionStrings:SwimmClubCon %>" SelectCommand="SELECT [Username], [Sec_Ques] FROM [Account] WHERE ([Username] = @Username)">
                                <SelectParameters>
                                    <asp:ControlParameter ControlID="txtUsername" DefaultValue="Null" Name="Username" PropertyName="Text" Type="String" />
                                </SelectParameters>
                            </asp:SqlDataSource>
                            <table style="width:800px;margin-left:35%;margin-top:2%">
                                <tr>
                                    <td style="padding:1%">
                                        <asp:Label ID="lblUsername" runat="server" Text="Enter your Username: "></asp:Label>
                                    </td>
                                    <td style="padding:1%">
                                        <asp:TextBox ID="txtUsername" runat="server" class="form-control"></asp:TextBox>
                                    </td>
                                    <td style="padding:1%">
                                        <asp:Button ID="btnNextShowQuestions" runat="server" Text="Next" OnClick="btnNextShowQuestions_Click" class="btn btn-primary"/>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
                                        <asp:Button ID="btnCancelNGobacktoLogin" runat="server" CausesValidation="false" OnClick="btnCancelNGobacktoLogin_Click" Text="Cancel" class="btn btn-primary" />
                                    </td>
                                    <td style="padding:1%">
                                        &nbsp;</td>
                                </tr>
                                <tr>
                                    <td style="padding:1%">
                                        <asp:Label ID="lblSecQuest" runat="server" Visible="false">Security Question:</asp:Label>
                                    </td >
                                    <td style="padding:1%">
                                        <asp:DataList ID="DataList1" runat="server" DataSourceID="SqlDataSource1" Visible="false">
                                            <ItemTemplate>
                                                <asp:Label ID="Label1" runat="server" Text='<%# Eval("Sec_Ques") %>'></asp:Label>
                                            </ItemTemplate>
                                        </asp:DataList>
                                    </td>
                                </tr>
                                <tr>
                                    <td style="padding:1%">
                                        <asp:Label ID="lblsecAns" runat="server" Visible="false">Provide Your Correct Answer</asp:Label>
                                    </td>
                                    <td style="padding:1%">
                                        <asp:TextBox runat="server" ID="Sec_Ans" Visible="false" class="form-control"/>
                                    </td>
                                    <td style="padding:1%">
                                        <asp:RequiredFieldValidator runat="server" 
                                            ControlToValidate="Sec_Ans"
                                            ForeColor="Red" 
                                            ErrorMessage="The Answer Field Cannot Be Empty!"/>
                                    </td>
                                </tr>
                                <tr>
                                    <td style="padding:1%"></td>
                                    <td style="padding:1%">
                                         <asp:Button ID="btnSubmitSecAns" runat="server" OnClick="btnSubmitSecAns_Click" Text="Submit" Visible="false" class="btn btn-primary"/>
                                    </td>
                                    <td style="padding:1%">
                                        <asp:Label ID="lblErrSecAns" runat="server" ForeColor="Red"></asp:Label>
                                    </td>
                                </tr>
                            </table>
                        </asp:View>
                        <asp:View ID="view3" runat="server">
                            <table style="width:800px;margin-left:35%;margin-top:2%">
                                <tr>
                                    <td style="padding:1%">
                                        <asp:Label ID="lblYourUsername" runat="server"></asp:Label>
                                    </td>
                                    <td style="padding:1%"></td>
                                </tr>
                                <tr>
                                    <td style="padding:1%">
                                        <asp:Label runat="server">New Password</asp:Label>
                                    </td>
                                    <td style="padding:1%">
                                        <asp:TextBox runat="server" ID="TextBox1" TextMode="Password" class="form-control"/>
                                    </td>
                                    <td style="padding:1%">
                                        <asp:RequiredFieldValidator runat="server" 
                                        ControlToValidate="TextBox1"
                                        ForeColor="Red"
                                        ErrorMessage="Enter Your New Password" />
                                        <br />
            <asp:RegularExpressionValidator ID="revPassword" runat="server" ErrorMessage="Enter a MIMINUM 8 characters with at least 1 Alphabet, 1 Number and 1 Special Character" ValidationExpression="^(?=.*[A-Za-z])(?=.*\d)(?=.*[$@$!%*#?&])[A-Za-z\d$@$!%*#?&]{8,}$" ForeColor="Red" ControlToValidate="TextBox1"></asp:RegularExpressionValidator>
                                    </td>
                                </tr>
                                <tr>
                                    <td style="padding:1%">
                                        <asp:Label runat="server" >Confirm Password</asp:Label>
                                    </td>
                                    <td style="padding:1%">
                                        <asp:TextBox runat="server" ID="ConfirmPassword" TextMode="Password" class="form-control"/>
                                    </td>
                                    <td style="padding:1%">
                                        <asp:RequiredFieldValidator runat="server" 
                                        ControlToValidate="ConfirmPassword"
                                        ForeColor="Red" BackColor="LightBlue"
                                        Display="Dynamic" 
                                        ErrorMessage="Enter You New Confirmed Password!"/>
                                        <br />
                                        <asp:CompareValidator runat="server" 
                                        ControlToCompare="Password" 
                                        ControlToValidate="ConfirmPassword"
                                        ForeColor="Red" BackColor="LightBlue"
                                        Display="Dynamic" 
                                        ErrorMessage="The Passworrds Do Not Match!"/>

                                    </td>
                                </tr>
                                <tr>
                                    <td style="padding:1%"></td>
                                    <td style="padding:1%">
                                        <asp:Button ID="btnConfirm" runat="server" OnClick="btnConfirm_Click" Text="Confirm" class="btn btn-primary" />
                                    </td>
                                    <td style="padding:1%">
                                        <asp:Label ID="lblErrUpdatePass" runat="server" ForeColor="Red"></asp:Label>
                                    </td>
                                </tr>
                            </table>
                            </asp:View>
                    </asp:MultiView>
                       </div>
</asp:Content>
