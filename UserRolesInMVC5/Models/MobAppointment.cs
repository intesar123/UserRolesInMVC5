using System;
using System.Collections.Generic;
using System.ComponentModel.DataAnnotations;
using System.Data.Entity;
using System.Data.Entity.ModelConfiguration.Conventions;
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
        public string isdcode { get; set; }
    }

    public class AppointmentDbContext : DbContext
    {
        public AppointmentDbContext():base("DefaultConnection")//specify the connection
        {
        }
        public DbSet<MobAppointment> MobAppointment { get; set; }
        protected override void OnModelCreating(DbModelBuilder modelBuilder)
        {
            modelBuilder.Conventions.Remove<PluralizingTableNameConvention>();
        }
    }
}