using System;
using System.Collections.Generic;
using System.Data;
using System.Data.SqlClient;
using System.Linq;
using System.Text.RegularExpressions;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace MachineTest
{
    public partial class Index : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                lstcountry.DataSource = getCountry("");
                lstcountry.DataValueField = "id";
                lstcountry.DataTextField = "name";
                lstcountry.DataBind();

                lststate.DataSource = getState("");
                lststate.DataValueField = "id";
                lststate.DataTextField = "name";
                lststate.DataBind();

                lstcity.DataSource = getCity("");
                lstcity.DataValueField = "id";
                lstcity.DataTextField = "name";
                lstcity.DataBind();

                string empcode = "EM0000001";
                DataTable dt = getAllEmployee();

                if (dt.Rows.Count > 0)
                {
                    empcode = Convert.ToString(dt.Rows[0]["id"]);
                    var match = Regex.Match(empcode, @"^([^0-9]+)([0-9]+)$");
                    var num = int.Parse(match.Groups[2].Value);
                    var after = match.Groups[1].Value + (num + 1);
                    empcode = after;
                }
                empid.Text = empcode;


            }
        }

        public DataTable getCountry(string id)
        {
            string whcl = string.Empty;
            if (id.Length > 0)
            {
                whcl = " where id=" + Convert.ToInt32(id);
            }

            DataTable dt = new DataTable();
            try
            {
                string Connstr = System.Configuration.ConfigurationManager.ConnectionStrings["DefaultConnection"].ConnectionString;
                using (SqlCommand cmd = new SqlCommand("Select * from country" + whcl))
                {
                    using (SqlConnection conn = new SqlConnection(Connstr))
                    {
                        cmd.Connection = conn;
                        using (SqlDataAdapter sda = new SqlDataAdapter())
                        {
                            sda.SelectCommand = cmd;
                            using (dt)
                            {
                                sda.Fill(dt);
                            }
                        }
                    }

                }
            }
            catch (Exception ex)
            {

                throw ex;
            }
            return dt;
        }
        public DataTable getState(string id)
        {
            string whcl = string.Empty;
            if (id.Length > 0)
            {
                whcl = " where id=" + Convert.ToInt32(id);
            }

            DataTable dt = new DataTable();
            try
            {
                string Connstr = System.Configuration.ConfigurationManager.ConnectionStrings["DefaultConnection"].ConnectionString;
                using (SqlCommand cmd = new SqlCommand("Select id,name from State" + whcl))
                {
                    using (SqlConnection conn = new SqlConnection(Connstr))
                    {
                        cmd.Connection = conn;
                        using (SqlDataAdapter sda = new SqlDataAdapter())
                        {
                            sda.SelectCommand = cmd;
                            using (dt)
                            {
                                sda.Fill(dt);
                            }
                        }
                    }

                }
            }
            catch (Exception ex)
            {

                throw ex;
            }
            return dt;
        }
        public DataTable getCity(string id)
        {
            string whcl = string.Empty;
            if (id.Length > 0)
            {
                whcl = " where id=" + Convert.ToInt32(id);
            }

            DataTable dt = new DataTable();
            try
            {
                string Connstr = System.Configuration.ConfigurationManager.ConnectionStrings["DefaultConnection"].ConnectionString;
                using (SqlCommand cmd = new SqlCommand("Select id,name from city" + whcl))
                {
                    using (SqlConnection conn = new SqlConnection(Connstr))
                    {
                        cmd.Connection = conn;
                        using (SqlDataAdapter sda = new SqlDataAdapter())
                        {
                            sda.SelectCommand = cmd;
                            using (dt)
                            {
                                sda.Fill(dt);
                            }
                        }
                    }

                }
            }
            catch (Exception ex)
            {

                throw ex;
            }
            return dt;
        }
        public DataTable getAllEmployee()
        {

            DataTable dt = new DataTable();
            try
            {
                string Connstr = System.Configuration.ConfigurationManager.ConnectionStrings["DefaultConnection"].ConnectionString;
                using (SqlCommand cmd = new SqlCommand("Select * from Employee order by id desc"))
                {
                    using (SqlConnection conn = new SqlConnection(Connstr))
                    {
                        cmd.Connection = conn;
                        using (SqlDataAdapter sda = new SqlDataAdapter())
                        {
                            sda.SelectCommand = cmd;
                            using (dt)
                            {
                                sda.Fill(dt);
                            }
                        }
                    }

                }
            }
            catch (Exception ex)
            {

                throw ex;
            }
            return dt;
        }
        public DataTable getEmployee(string id)
        {

            DataTable dt = new DataTable();
            try
            {
                string Connstr = System.Configuration.ConfigurationManager.ConnectionStrings["DefaultConnection"].ConnectionString;
                using (SqlCommand cmd = new SqlCommand("Select * from Employee where id='"+id+"'"))
                {
                    using (SqlConnection conn = new SqlConnection(Connstr))
                    {
                        cmd.Connection = conn;
                        using (SqlDataAdapter sda = new SqlDataAdapter())
                        {
                            sda.SelectCommand = cmd;
                            using (dt)
                            {
                                sda.Fill(dt);
                            }
                        }
                    }

                }
            }
            catch (Exception ex)
            {

                throw ex;
            }
            return dt;
        }

        protected void btnsave_Click(object sender, EventArgs e)
        {
            string msg = string.Empty;
            string Connstr = System.Configuration.ConfigurationManager.ConnectionStrings["DefaultConnection"].ConnectionString;
            try
            {
                using (SqlCommand cmd = new SqlCommand("insert into Employee(id,empname,country,state,city,empimage,mobileno,gender) values(@id,@empname,@country,@state,@city,@empimage,@mobileno,@gender)"))
                {
                    deleteEmp(empid.Text.Trim());
                    cmd.Parameters.Add("id", DbType.String).Value = empid.Text.Trim();
                    cmd.Parameters.Add("empname", DbType.String).Value = txtname.Text.Trim();
                    cmd.Parameters.Add("country", DbType.String).Value = lstcountry.SelectedValue.Trim();
                    cmd.Parameters.Add("state", DbType.String).Value = lststate.SelectedValue.Trim();
                    cmd.Parameters.Add("city", DbType.String).Value = lstcity.SelectedValue.Trim();
                    byte[] bytearr = empimg.FileBytes;
                    cmd.Parameters.Add("empimage", DbType.Binary).Value = bytearr;
                    cmd.Parameters.Add("mobileno", DbType.String).Value = txtmob.Text.Trim();
                    cmd.Parameters.Add("gender", DbType.String).Value = gender.SelectedValue.Trim();

                    using (SqlConnection conn = new SqlConnection(Connstr))
                    {
                        cmd.Connection = conn;
                        conn.Open();
                        int issaved = cmd.ExecuteNonQuery();
                        if (issaved > 0)
                        {
                            msg = "Saved Successfully";
                        }
                    }
                }
            }
            catch (Exception ex)
            {

                msg = ex.Message;
            }
            msglbl.Text = msg;
        }

        protected void btnView_Click(object sender, EventArgs e)
        {
            DataTable dt = getAllEmployee();

            TableRow tr = new TableRow();
            TableCell tc = new TableCell();
            tc = new TableCell();
            tc.Text = "Id";
            tr.Controls.Add(tc);
            tc = new TableCell();
            tc.Text = "Name";
            tr.Controls.Add(tc);
            tc = new TableCell();
            tc.Text = "Country";
            tr.Controls.Add(tc);
            tc = new TableCell();
            tc.Text = "Image";
            tr.Controls.Add(tc);
            tc = new TableCell();
            tc.Text = "State";
            tr.Controls.Add(tc);
            tc = new TableCell();
            tc.Text = "City";
            tr.Controls.Add(tc);
            tc = new TableCell();
            tc.Text = "Mobile";
            tr.Controls.Add(tc);
            tc = new TableCell();
            tc.Text = "Gender";
            tr.Controls.Add(tc);
            tc = new TableCell();
            tc.Text = "";
            tr.Controls.Add(tc);
            tr.ID = "header";
            emptable.Controls.Add(tr);


            foreach (DataRow dr in dt.Rows)
            {
                tr = new TableRow();
                tc = new TableCell();
                tc.Text = Convert.ToString(dr["id"]);
                tr.Controls.Add(tc);
                tc = new TableCell();
                tc.Text = Convert.ToString(dr["empname"]);
                tr.Controls.Add(tc);

                tc = new TableCell();
                if (getCountry(Convert.ToString(dr["country"])).Rows.Count > 0)
                {
                    tc.Text = Convert.ToString(getCountry(Convert.ToString(dr["country"])).Rows[0]["name"]);
                }
                tr.Controls.Add(tc);
                tc = new TableCell();
                if (getState(Convert.ToString(dr["state"])).Rows.Count > 0)
                {
                    tc.Text = Convert.ToString(getState(Convert.ToString(dr["state"])).Rows[0]["name"]);
                }
                tr.Controls.Add(tc);
                tc = new TableCell();
                if (getCity(Convert.ToString(dr["city"])).Rows.Count > 0)
                {
                    tc.Text = Convert.ToString(getCity(Convert.ToString(dr["city"])).Rows[0]["name"]);
                }
                tr.Controls.Add(tc);
                tc = new TableCell();
                if (dr["empimage"] != DBNull.Value)
                {
                    Image img = new Image();
                    img.Height = 100;
                    img.Width = 100;
                    byte[] bytearr = (byte[])dr["empimage"];
                    img.ImageUrl = "data:image;base64," + Convert.ToBase64String(bytearr);
                    tc.Controls.Add(img);
                }
                tr.Controls.Add(tc);
                tc = new TableCell();
                tc.Text = Convert.ToString(dr["mobileno"]);
                tr.Controls.Add(tc);
                tc = new TableCell();
                tc.Text = Convert.ToString(dr["gender"]);
                tr.Controls.Add(tc);
                tc = new TableCell();
                LinkButton lnk = new LinkButton();
                lnk.Text = "Edit";
                lnk.OnClientClick = "return EditEmp('" + Convert.ToString(dr["id"])+"')";
                tc.Controls.Add(lnk);
                tr.Controls.Add(tc);
                emptable.Controls.Add(tr);
            }
        }

        public void deleteEmp(String id)
        {
            string whcl = string.Empty;
            if (id.Length > 0)
            {
                whcl = " where id=" + id;
            }
            try
            {
                string Connstr = System.Configuration.ConfigurationManager.ConnectionStrings["DefaultConnection"].ConnectionString;
                using (SqlCommand cmd = new SqlCommand("Delete  from Employee where id='" + id + "'"))
                {
                    using (SqlConnection conn = new SqlConnection(Connstr))
                    {
                        cmd.Connection = conn;
                        conn.Open();
                        cmd.ExecuteNonQuery();
                    }

                }
            }
            catch (Exception ex)
            {

                throw ex;
            }

        }



        protected void btnedit_Click(object sender, EventArgs e)
        {
            DataTable dt = getEmployee(empedit.Value);
            if (dt.Rows.Count > 0)
            {
                if (dt.Rows[0]["id"] != DBNull.Value)
                {
                    empid.Text = Convert.ToString(dt.Rows[0]["id"]).Trim();
                }
                if (dt.Rows[0]["empname"] != DBNull.Value)
                {
                    txtname.Text = Convert.ToString(dt.Rows[0]["empname"]).Trim();
                }
                if (dt.Rows[0]["country"] != DBNull.Value)
                {
                    lstcountry.SelectedValue = Convert.ToString(dt.Rows[0]["country"]).Trim();
                }
                if (dt.Rows[0]["state"] != DBNull.Value)
                {
                    lststate.SelectedValue = Convert.ToString(dt.Rows[0]["state"]).Trim();
                }
                if (dt.Rows[0]["city"] != DBNull.Value)
                {
                    lstcity.SelectedValue = Convert.ToString(dt.Rows[0]["city"]).Trim();
                }
                if (dt.Rows[0]["mobileno"] != DBNull.Value)
                {
                    txtmob.Text = Convert.ToString(dt.Rows[0]["mobileno"]).Trim();
                }
                if (dt.Rows[0]["gender"] != DBNull.Value)
                {
                    gender.SelectedValue = Convert.ToString(dt.Rows[0]["gender"]).Trim();
                }



            }
        }



    }
}



