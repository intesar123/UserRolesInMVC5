using MySql.Data.Entity;
using System;
using System.Collections.Generic;
using System.ComponentModel.DataAnnotations;
using System.Data.Common;
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
        [Required(ErrorMessage = "Mobile Number is required!")]
        public string mobnum { get; set; }
        public bool isverified { get; set; }
        public string isdcode { get; set; }
    }
    [DbConfigurationType(typeof(MySql.Data.Entity.MySqlEFConfiguration))]
    public class AppointmentDbContext : DbContext
    {
       
        
        public AppointmentDbContext():base("DefaultConnection")//specify the connection
        {
           ///   Database.SetInitializer(new MobAppInitializer());
           Database.SetInitializer<AppointmentDbContext>(new MobAppInitializer());
        }
        public DbSet<MobAppointment> MobAppointment { get; set; }



        protected override void OnModelCreating(DbModelBuilder modelBuilder)
        {
            //base.OnModelCreating(modelBuilder);

            //modelBuilder.Entity<AppointmentDbContext>().MapToStoredProcedures();
            modelBuilder.Conventions.Remove<PluralizingTableNameConvention>();
            //modelBuilder.Entity<MobAppointment>()
            //     .Property(e => e.mobnum)
            //     .IsUnicode(false);
        }
    }
    public class MobAppInitializer : CreateDatabaseIfNotExists<AppointmentDbContext>
    {
        protected override void Seed(AppointmentDbContext context)
        {
            base.Seed(context);
        }
    }
}