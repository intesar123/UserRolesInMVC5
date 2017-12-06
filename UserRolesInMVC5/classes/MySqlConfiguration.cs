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
            "Oracle.ManagedDataAccess.Client", (conn, schema) => new MySqlHistoryContext(conn, schema));
            }
            else
            {
                SetHistoryContext(
           "Oracle.ManagedDataAccess.Client", (conn, schema) => new MySqlHistoryContext(conn, schema));
            }
        }
    }
}