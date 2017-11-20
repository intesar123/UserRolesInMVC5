<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="StoredProcedure.aspx.cs" Inherits="HospMgmt.StoredProcedure" %>

<!DOCTYPE html>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<head runat="server">

    <title>Untitled Page</title>


</head>

<body>

    <form id="form1" runat="server">

    <div>

   

     <asp:Label ID="Label1" runat="server" Text="Name" Font-Bold="True"></asp:Label>

        <asp:TextBox ID="TextBox_user_name" runat="server" ForeColor="#993300" Width="100px"></asp:TextBox>

        <asp:RequiredFieldValidator ID="RequiredFieldValidator1" runat="server"

            ControlToValidate="TextBox_user_name" ErrorMessage="Please enter username"></asp:RequiredFieldValidator>

        <br />

        <asp:Label ID="Label2" runat="server" Text="Password" Font-Bold="True"></asp:Label>

        <asp:TextBox ID="TextBox_password" runat="server" ForeColor="#CC6600"

            TextMode="Password" Width="100px"></asp:TextBox>

        <asp:RequiredFieldValidator ID="RequiredFieldValidator2" runat="server"

            ControlToValidate="TextBox_password" ErrorMessage="Please enter password"></asp:RequiredFieldValidator>

        <br />

        <asp:Button ID="btn_login" runat="server" Text="Login" Font-Bold="True"

             onclick="btn_login_Click"  /><br />

    <asp:Label ID="lblmessage" runat="server" Font-Bold="True" ForeColor="#FF3300"></asp:Label><br />

    </div>

    </form>

</body>

</html>