using System;
using System.Collections.Generic;
using System.Data.Entity;
using System.Linq;
using System.Web;

namespace HospMgmt
{
    public class MSSqlConfiguration: DbConfiguration
    {
        public MSSqlConfiguration()
        {
            SetHistoryContext(
            "System.Data.SqlClient", (conn, schema) => new MSSqlHistoryContext(conn, schema));
        }
    }
}