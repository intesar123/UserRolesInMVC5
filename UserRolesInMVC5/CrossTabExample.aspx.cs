using CrystalDecisions.CrystalReports.Engine;
using CrystalDecisions.Shared;
using Microsoft.Reporting.WebForms;
using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace HospMgmt
{
    public partial class CrossTabExample : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {

        }

        protected void btnprint_Click(object sender, EventArgs e)
        {
            CreatePDFFile();
        }
        private void CreatePDFFile(string fileName="TestFile")
        {    
            // Setup DataSet
             datasets.DataSetTest ds = new datasets.DataSetTest();

           // IList customerList = new List();
            
            DataTable dt = CommonFunction.getTable("select p.id,p.firstname,p.lastname,ph.id as phid,ph.phone_num,ph.phone_type from people p left outer join phones ph on ph.pid=p.id  order by p.id",CommonFunction.getConnection());
            foreach (DataRow dr1 in dt.Rows)
            {
                DataRow dr = ds.people.NewpeopleRow();
                if (dr1["id"] != DBNull.Value)
                {
                    dr["id"] = Convert.ToInt32(dr1["id"]);
                }
                if (dr1["firstname"] != DBNull.Value)
                {
                    dr["name"] = Convert.ToString(dr1["firstname"]);
                }
                if (dr1["phone_num"] != DBNull.Value)
                {
                    dr["phone"] = Convert.ToString(dr1["phone_num"]);
                }
                if (dr1["phone_type"] != DBNull.Value)
                {
                    dr["type"] = Convert.ToString(dr1["phone_type"]);
                }
               // ds.phone.Rows.Add(dr2);
                ds.people.Rows.Add(dr);
            }
            ReportDocument rpt = new ReportDocument();
            rpt.Load(@Server.MapPath("reports/Crosstabtest.rpt"));

            rpt.SetDataSource(ds);
            ExportOptions CrExportOptions;
            DiskFileDestinationOptions CrDiskFileDestinationOptions = new DiskFileDestinationOptions();
            PdfRtfWordFormatOptions CrFormatTypeOptions = new PdfRtfWordFormatOptions();
            CrDiskFileDestinationOptions.DiskFileName = "E:\\SampleReport.pdf";
            CrExportOptions = rpt.ExportOptions;
            {
                CrExportOptions.ExportDestinationType = ExportDestinationType.DiskFile;
                CrExportOptions.ExportFormatType = ExportFormatType.PortableDocFormat;
                CrExportOptions.DestinationOptions = CrDiskFileDestinationOptions;
                CrExportOptions.FormatOptions = CrFormatTypeOptions;
            }
            rpt.Export();
            
        }
    }
}