<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="Index.aspx.cs" Inherits="MachineTest.Index" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title></title>
    <style>
        #emptable {
            width:100%;
        }
        #emptable td{
            padding:10px;
        }
        #header {
         background-color:black;
         color: white;
        }
        
    </style>
    <script>
        function EditEmp(id)
        {
            if (id.length>0)
            {
                var editid = document.getElementById("empedit");
                editid.value = id;
                var editemp = document.getElementById("btnedit");
                editemp.click();
                alert(id);
            }
            

            return false;
        }
     </script>
</head>
<body>
    <form id="form1" runat="server">
    <div>
        <table style="width:100%">
            <tr>
                <td colspan="4">
                    <td><asp:Label runat="server" ID="msglbl"></asp:Label></td>
                </td>
            </tr>
            <tr>
                <td>Id</td>
                <td><asp:Label runat="server" ID="empid"></asp:Label></td>
                 <td>Name</td>
                <td><asp:TextBox runat="server" ID="txtname"></asp:TextBox></td>
            </tr>
            <tr>
                 <td>Contry</td>
                <td><asp:DropDownList runat="server" ID="lstcountry"></asp:DropDownList> </td>
                 <td>State</td>
                <td><asp:DropDownList runat="server" ID="lststate"></asp:DropDownList> </td>
            </tr>
            <tr>
                <td>City</td>
                <td><asp:DropDownList runat="server" ID="lstcity"></asp:DropDownList> </td>
                 <td>Image</td>
                <td><asp:FileUpload runat="server" ID="empimg"></asp:FileUpload></td>
            </tr>
             <tr>
                 <td>Mobile</td>
                <td><asp:TextBox runat="server" ID="txtmob"></asp:TextBox></td>
                 <td>Gender</td>
                <td><asp:RadioButtonList ID="gender" runat="server">
                    <asp:ListItem Value="M" Text="Male"></asp:ListItem>
                    <asp:ListItem Value="F" Text="Female"></asp:ListItem>
                    </asp:RadioButtonList></td>
            </tr>
            <tr>
                <asp:HiddenField runat="server" ID="empedit" />
                <td colspan="2"><asp:Button runat="server" ID="btnedit" Text="edit" style="display:none" OnClick="btnedit_Click"/></td>
                <td colspan="2" style="text-align:center"><asp:Button runat="server" ID="btnsave" Text="Save" OnClick="btnsave_Click" /><asp:Button runat="server" ID="btnView" Text="View" OnClick="btnView_Click" style="height: 26px" /></td>
            </tr>
        </table>
        <asp:Table runat="server" ID="emptable">

        </asp:Table>
    </div>
    </form>
</body>
</html>
