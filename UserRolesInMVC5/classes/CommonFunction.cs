using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data;
using System.Data.SqlClient;
using System.Linq;
using System.Web;

namespace HospMgmt
{
    public class CommonFunction
    {
        public static SqlConnection getConnection()
        {
            string constr = ConfigurationManager.ConnectionStrings["DefaultConnection"].ConnectionString;
            SqlConnection con = new SqlConnection(constr);
            return con;
        }
        public static DataTable getTable(string query,SqlConnection conn=null,SqlTransaction trans=null)
        {
            DataTable dt = new DataTable();
            using (conn)
            {
                using (SqlCommand cmd = new SqlCommand(query))
                {
                    using (SqlDataAdapter sda = new SqlDataAdapter())
                    {
                        cmd.Connection = conn;
                        cmd.Transaction = trans;
                        sda.SelectCommand = cmd;
                        using (dt)
                        {
                            sda.Fill(dt);
                        }
                    }
                }
            }
            return dt;
        }
    }
}