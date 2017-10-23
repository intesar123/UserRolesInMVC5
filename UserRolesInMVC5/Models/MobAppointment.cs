using System;
using System.Collections.Generic;
using System.ComponentModel.DataAnnotations;
using System.Data.Entity;
using System.Linq;
using System.Web;

namespace HospMgmt.Models
{
    public class MobAppointment
    {

        [Key]
       public int id { get; set; }
        [Required(ErrorMessage ="Mobile Number is required!")]
       public string mobnum { get; set; }
       public bool isverified { get; set; }
    }

    public class AppointmentDbContext : DbContext
    {
        public DbSet<MobAppointment> mvctest { get; set; }
    }
}