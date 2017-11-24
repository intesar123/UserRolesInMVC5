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

             onclick="btn_login_Click"  />
        <asp:Button runat="server" ID="btnCreate" Text="Create User" OnClick="btnCreate_Click"/>
        <asp:Button runat="server" ID="btnUpdate" Text="Update User" OnClick="btnUpdate_Click"/>

        <br />

    <asp:Label ID="lblmessage" runat="server" Font-Bold="True" ForeColor="#FF3300"></asp:Label><br />

    </div>
        <br />
        <pre>
            --start stored procedure 

---Create Stored procedure
 create procedure login_proc(@UserName varchar(255),@Password varchar(50))
 As 
 declare @status int 
 if exists(Select * from login where UserName=@UserName and Password=@Password)
 
     set @status=1
	 
 else 
 
    set @status=0
	
 select @status

 ---Create Stored procedure
 create procedure insert_login_proc(@UserName varchar(255),@Password varchar(50))
 As
 Begin 
  set NOCOUNT OFF
  insert into login(UserName,Password) values(@UserName,@Password)
  return @@ROWCOUNT
 End


 ---Create table first
create table login(UserName varchar(255),Password varchar(50))

 ---Create Stored procedure
 Alter procedure insert_login_proc(@UserName varchar(255),@Password varchar(50))
 As
 Begin 
  set NOCOUNT On
  insert into login(UserName,Password) values(@UserName,@Password)
  return @@ROWCOUNT
 End

 ---Execute Stored Procedure
 exec insert_login_proc 'Raheel2','944637374'

 ---Drop Stored procedure
 Drop procedure insert_login_proc
---end stored procedure
        </pre>

    </form>

</body>

</html>