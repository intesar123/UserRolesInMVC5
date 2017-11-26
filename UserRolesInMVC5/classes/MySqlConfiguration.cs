using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data.Entity;
using System.Linq;
using System.Web;

namespace HospMgmt
{
    public class MySqlConfiguration: DbConfiguration
    {
        public MySqlConfiguration()
        {
            if (!Convert.ToBoolean(ConfigurationManager.AppSettings["ismssql"]))
            {
                SetHistoryContext(
            "MySql.Data.MySqlClient", (conn, schema) => new MySqlHistoryContext(conn, schema));
            }
            else
            {
                SetHistoryContext(
           "System.Data.SqlClient", (conn, schema) => new MySqlHistoryContext(conn, schema));
            }
        }
    }
}