<%@ Page Title="" Language="C#" MasterPageFile="~/member.Master" AutoEventWireup="true" CodeBehind="profile.aspx.cs" Inherits="GroupAss.profile" MaintainScrollPositionOnPostback="true" %>


<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">

</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="Main" runat="server">
    <link rel="stylesheet" href="master.css">
    <div>
    <asp:MultiView ID="mvProfile" runat="server" ActiveViewIndex="0">
        <asp:View runat="server" ID="ProfileInfo">
            <div class="container">
<div class="row flex-lg-nowrap">
  <div class="col">
    <div class="row">
      <div class="col mb-3">
        <div class="card">
          <div class="card-body">
            <div class="e-profile">
                
              <div class="row justify-content-center">
               <div class="box">
               <asp:Image ID="imgProd" class="profimage" runat="server" />
                </div>   
              </div>
                <div class="row justify-content-center">
                        <asp:FileUpload ID="imageBrowse" ToolTip="Upload New Picture" class="btn" style="background-color:blanchedalmond" runat="server" />
                    </div>
              </div>
              <div class="tab-content pt-3">
                <div class="tab-pane active">
                    <div class="row">
                      <div class="col">
                          <div class="row">
                          <div class="col">
                            <div class="form-group">
                              <label class="Label">Username</label>
                                <asp:TextBox ID="txtUsername" class="form-control" runat="server" ReadOnly="True"></asp:TextBox>
                            </div>
                          </div>
                        </div>
                        <div class="row">
                          <div class="col">
                            <div class="form-group">
                              <label class="Label">First Name</label>
                                <asp:TextBox ID="txtFirstName" class="form-control" runat="server"></asp:TextBox><br />
                                <asp:RequiredFieldValidator ID="rfvFirstName" runat="server" ErrorMessage="First Name cannot be empty" ForeColor="Red" ControlToValidate="txtFirstName"></asp:RequiredFieldValidator>
                            </div>
                          </div>
                          <div class="col">
                            <div class="form-group">
                              <label class="Label">Last Name</label>
                               <asp:TextBox ID="txtLastName" class="form-control" runat="server"></asp:TextBox><br />
                               <asp:RequiredFieldValidator ID="rfvLastName" runat="server" ErrorMessage="Last Name cannot be empty" ForeColor="Red" ControlToValidate="txtLastName"></asp:RequiredFieldValidator>
                              </div>
                          </div>
                        </div>

                        <div class="row">
                            <div class="col">
                            <div class="form-group">
                              <label class="Label">Email</label>
                                <asp:TextBox ID="txtEmail" class="form-control" runat="server"></asp:TextBox>
                                <br />
                               <asp:RequiredFieldValidator ID="rfvEmail" runat="server" ErrorMessage="Email cannot be empty" ForeColor="Red" ControlToValidate="txtEmail"></asp:RequiredFieldValidator>
                                <br />
                                <asp:RegularExpressionValidator ID="revEmail" runat="server" ErrorMessage="Enter a valid Email Eg: user@gmail.com" ControlToValidate="txtEmail" ForeColor="Red" ValidationExpression="\w+([-+.']\w+)*@\w+([-.]\w+)*\.\w+([-.]\w+)*"></asp:RegularExpressionValidator>
                            </div>
                          </div>
                            <div class="col">
                            <div class="form-group">
                              <label class="Label">Contact Number</label>
                               <asp:TextBox ID="txtContact" class="form-control" runat="server"></asp:TextBox>
                                <br />
                                <asp:RequiredFieldValidator ID="rfvContactNo" runat="server" ErrorMessage="Contanct Number cannot be empty" ControlToValidate="txtContact" ForeColor="Red"></asp:RequiredFieldValidator>
                                <br />
                                <asp:RegularExpressionValidator ID="revContactNo" runat="server" ErrorMessage="Enter a valid Malaysian number" ControlToValidate="txtContact" ForeColor="Red" ValidationExpression="^(\+?6?01)[0|1|2|3|4|6|7|8|9]\-*[0-9]{7,8}$"></asp:RegularExpressionValidator>
                            </div>
                          </div>
                        </div>
                          <div class="row">
                               <div class="col">
                            <div class="form-group">
                              <label class="Label">Date Of Birth</label>
                               <asp:TextBox ID="txtDOB" class="form-control" runat="server" ReadOnly="true"></asp:TextBox>
                               
                            </div>
                          </div>
                              <div style="margin-top:1rem;">
                                  <div class="form-group">
                                  <asp:Button ID="btnCalendar" runat="server" Text="Change" class="btn btn-primary" OnClick="btnCalendar_Click"/>
                                <asp:Calendar ID="calendar" runat="server" OnSelectionChanged="calendar_SelectionChanged" Visible="False" OnDayRender="calendar_DayRender" BackColor="White" BorderColor="#3366CC" BorderWidth="1px" CellPadding="1" DayNameFormat="Shortest" Font-Names="Verdana" Font-Size="8pt" ForeColor="#003399" Height="200px" Width="220px">
                                      <DayHeaderStyle BackColor="#99CCCC" ForeColor="#336666" Height="1px" />
                                      <NextPrevStyle Font-Size="8pt" ForeColor="#CCCCFF" />
                                      <OtherMonthDayStyle ForeColor="#999999" />
                                      <SelectedDayStyle BackColor="#009999" Font-Bold="True" ForeColor="#CCFF99" />
                                      <SelectorStyle BackColor="#99CCCC" ForeColor="#336666" />
                                      <TitleStyle BackColor="#003399" BorderColor="#3366CC" BorderWidth="1px" Font-Bold="True" Font-Size="10pt" ForeColor="#CCCCFF" Height="25px" />
                                      <TodayDayStyle BackColor="#99CCCC" ForeColor="White" />
                                      <WeekendDayStyle BackColor="#CCCCFF" />
                                      </asp:Calendar>
                                     
                                      </div>
                                </div>
                             <div class="col">
                            <div class="form-group">
                              <label class="Label">Gender</label><br />
                                 <asp:TextBox ID="txtGender" class="form-control" runat="server" ReadOnly="true"></asp:TextBox>
                                 <br />
                                <asp:RadioButtonList ID="rblGender" runat="server" class="radioButton" RepeatDirection="Horizontal">
                                    <asp:ListItem Value="F">Female</asp:ListItem>
                                    <asp:ListItem Value="M">Male</asp:ListItem>
                                </asp:RadioButtonList>
                            </div>
                          </div>
                        </div>
                        <div class="row">
                          <div class="col">
                            <div class="form-group">
                              <label class="Label">Address</label>
                               <asp:TextBox ID="txtAddress" class="form-control" runat="server" TextMode="MultiLine" Rows="5"></asp:TextBox>
                                <br />
                                <asp:RequiredFieldValidator ID="rfvAddress" runat="server" ErrorMessage="Address cannot be empty" ForeColor="Red" ControlToValidate="txtAddress"></asp:RequiredFieldValidator>
                            </div>
                          </div>
                        </div>
                      </div>
                    </div>
                    <div class="row">
                      <div class="col d-flex justify-content-end">
                          <asp:Button ID="btnSaveChanges" class="btn btn-primary"  runat="server" Text="SAVE CHANGES" OnClick="btnSaveChanges_Click"/>  
                      </div>
                    <div class="col d-flex justify-content-end">
                    <asp:Button ID="btnChange" class="btn btn-primary"  runat="server" Text="CHANGE PASSWORD" CommandName="SwitchViewByID"  CommandArgument="Password"/>  
                      </div>
                        <br />
                         <asp:Label ID="lblStatus" runat="server"></asp:Label>
                    </div>
                </div>
              </div>
            </div>
          </div>
        </div>
      </div>

  </div>
</div>
</div>
        </asp:View>
<asp:View ID="Password" runat="server">
<div class="container">
<div class="row flex-lg-nowrap">
  <div class="col">
    <div class="row">
      <div class="col mb-3">
        <div class="card">
          <div class="card-body">
              <div class="tab-content pt-3">
                  <div class="tab-pane active">
                      <div class="row">
                          <div class="col d-flex justify-content-start">
                          <asp:Button ID="btnBack" class="btn btn-primary" style="margin-bottom:1rem;" runat="server" Text="Back" OnClick="btnBack_Click" CausesValidation="false"/>  
                      </div>
                      </div>
                    <div class="row">
                     <div class="col">
                      <div class="form-group">
                       <label class="Label">Security Question</label>
                           <asp:TextBox ID="txtSecurityQ" class="form-control" runat="server" ReadOnly="True"></asp:TextBox>
                            </div>
                          </div>
                        </div>
                      
                      <div class="row">
                     <div class="col">
                      <div class="form-group">
                       <label class="label">Answer</label>
                          <asp:TextBox ID="txtSecurityA" runat="server" class="form-control"></asp:TextBox>
                            <asp:Label ID="lblStatusSec" runat="server" Text="Wrong Answer" Visible="false"></asp:Label>
                            </div>
                          </div>
                          </div>
                      <div class="row">
                           <div class="col d-flex justify-content-end">
                          <asp:Button ID="btnSubmit" class="btn btn-primary"  runat="server" Text="Submit" OnClick="btnSubmit_Click"/>
                        
                      </div>
                          </div>
                      <div runat="server" visible="false" id="divPassword">
                    <div class="row">
                     <div class="col">
                      <div class="form-group">
                       <label class="label">Current Password</label>
                        <asp:TextBox ID="txtCurrentPass" class="form-control" runat="server" TextMode="Password"></asp:TextBox>
                          <br />
                          <asp:RequiredFieldValidator ID="rfvCurrentPass" runat="server" ErrorMessage="Enter Current Password" ControlToValidate="txtCurrentPass" ForeColor="Red"></asp:RequiredFieldValidator>

                            </div>
                          </div>
                        </div>
                       <div class="row">
                       <div class="col">
                            <div class="form-group">
                              <label class="label">New Password</label>
                               <asp:TextBox ID="txtNewPass" class="form-control" runat="server" TextMode="Password"></asp:TextBox>
                                <asp:RequiredFieldValidator ID="rfvNewPass" runat="server" ErrorMessage="Enter New Password" ControlToValidate="txtNewPass" ForeColor="Red"></asp:RequiredFieldValidator>
                                <br />
                                <asp:CompareValidator ID="cvCompare" runat="server" ErrorMessage="New Password cannot be same as Old Password" ControlToCompare="txtCurrentPass" ControlToValidate="txtNewPass" Operator="NotEqual" ForeColor="Red"></asp:CompareValidator>
                                <br />
                                <asp:RegularExpressionValidator ID="revNewPassword" runat="server" ErrorMessage="Enter a MIMINUM 8 characters with at least 1 Alphabet, 1 Number and 1 Special Character" ValidationExpression="^(?=.*[A-Za-z])(?=.*\d)(?=.*[$@$!%*#?&])[A-Za-z\d$@$!%*#?&]{8,}$" ForeColor="Red" ControlToValidate="txtNewPass"></asp:RegularExpressionValidator>
                              </div>
                          </div>
                           </div>
                      <div class="row">
                       <div class="col">
                            <div class="form-group">
                              <label class="label">Confirm New Password</label>
                               <asp:TextBox ID="txtConfirmNewPass" class="form-control" runat="server" TextMode="Password"></asp:TextBox>
                                <asp:CompareValidator ID="cvConfirmNewPass" runat="server" ErrorMessage="New Password and confirm new Password need to be the same" ControlToCompare="txtNewPass" ControlToValidate="txtConfirmNewPass" ForeColor="Red"></asp:CompareValidator><br />
                                <asp:RequiredFieldValidator ID="rfvConfirmNewPass" runat="server" ErrorMessage="Confirm New Password" ControlToValidate="txtConfirmNewPass" ForeColor="Red"></asp:RequiredFieldValidator>
                              </div>
                          </div>
                           </div>
                        <div class="row">
                       <div class="col d-flex justify-content-end">
                               <asp:Button ID="btnChangeNewPass" class="btn btn-primary"  runat="server" Text="Save New Password" OnClick="btnChange_Click"/>
                              </div>
                            </div>
                          </div>
                      </div>
                  </div>
              </div>
            </div>
          </div>
        </div>
      </div>
    </div>
</div>
        </asp:View>
    </asp:MultiView>

    </div>
 
</asp:Content>

