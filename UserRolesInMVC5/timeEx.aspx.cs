using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace HospMgmt
{
    public partial class timeEx : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if(!IsPostBack)
            {
                //DateTime dt = DateTime.Parse("12:00 AM");
                //MKB.TimePicker.TimeSelector.AmPmSpec am_pm;
                //if (dt.ToString("tt") == "AM")
                //{
                //    am_pm = MKB.TimePicker.TimeSelector.AmPmSpec.AM;
                //}
                //else
                //{
                //    am_pm = MKB.TimePicker.TimeSelector.AmPmSpec.PM;
                //}
                ////am_pm = MKB.TimePicker.TimeSelector.AmPmSpec.AM;
                //TimeSelector9.SetTime(dt.Hour, dt.Minute, am_pm);
            }

        }
    }
}