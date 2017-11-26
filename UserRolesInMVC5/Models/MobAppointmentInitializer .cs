using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace HospMgmt.Models
{
    public class MobAppointmentInitializer:System.Data.Entity.DropCreateDatabaseIfModelChanges<AppointmentDbContext>
    {
        protected override void Seed(AppointmentDbContext context)
        {
            base.Seed(context);
        }
    }
}