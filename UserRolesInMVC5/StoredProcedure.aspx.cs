using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data;
using System.Data.SqlClient;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace HospMgmt
{
    public partial class StoredProcedure : System.Web.UI.Page
    {
        string strConnString = ConfigurationManager.ConnectionStrings["DefaultConnection"].ConnectionString;
        SqlCommand com;
        SqlParameter UserName, Password;
        protected void Page_Load(object sender, EventArgs e)
        {

        }

        protected void btnCreate_Click(object sender, EventArgs e)
        {
            string connstr = ConfigurationManager.ConnectionStrings["DefaultConnection"].ConnectionString;
            using (SqlConnection conn = new SqlConnection(connstr))
            {
                using (SqlCommand cmd = new SqlCommand())
                {
                    cmd.Parameters.Add("@userName",DbType.String).Value= TextBox_user_name.Text;
                    cmd.Parameters.Add("@Password",DbType.String).Value=TextBox_password.Text;
                    cmd.Connection = conn;
                    cmd.CommandType = CommandType.StoredProcedure;
                    conn.Open();
                    cmd.CommandText = "insert_login_proc";
                    if(Convert.ToInt16(cmd.ExecuteNonQuery())>0)
                    {
                        lblmessage.Text = "Successfully Savedd!...";
                    }
                    else
                    {
                        lblmessage.Text = "Unable to save...";
                    }
                }
            }
            

        }

        protected void btnUpdate_Click(object sender, EventArgs e)
        {

        }

        protected void btn_login_Click(object sender, EventArgs e)
        {
            UserName = new SqlParameter();
            Password = new SqlParameter();
            SqlConnection con = new SqlConnection(strConnString);
            com = new SqlCommand();
            com.Connection = con;
            con.Open();
            Session["UserName"] = TextBox_user_name.Text;
            com.CommandType = CommandType.StoredProcedure;
            com.CommandText = "login_proc";
            UserName.SqlDbType = SqlDbType.VarChar;
            UserName.Size = 50;
            UserName.ParameterName = "@UserName";
            UserName.Value = TextBox_user_name.Text.ToString();
            UserName.Direction = ParameterDirection.Input;
            Password.SqlDbType = SqlDbType.VarChar;
            Password.Size = 50;
            Password.ParameterName = "@Password";
            Password.Value = TextBox_password.Text.ToString();
            Password.Direction = ParameterDirection.Input;
            com.Parameters.Add(UserName);
            com.Parameters.Add(Password);
            int status;
            status = Convert.ToInt16(com.ExecuteScalar());
            if (status == 1)
            {
                Response.Redirect("Welcome.aspx");
            }
            else
            {
                lblmessage.Text = "Invalid UserName and Password...";
            }
            con.Close();

        }
    }
}