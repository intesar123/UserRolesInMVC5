using System;
using System.Collections.Generic;
using System.Data.Common;
using System.Data.Entity;
using System.Data.Entity.Migrations.History;
using System.Linq;
using System.Web;

namespace HospMgmt
{
    public class MSSqlHistoryContext: HistoryContext
    {
        //url https://docs.microsoft.com/en-us/aspnet/identity/overview/getting-started/aspnet-identity-using-mysql-storage-with-an-entityframework-mysql-provider
        public MSSqlHistoryContext(
     DbConnection existingConnection,
     string defaultSchema)
   : base(existingConnection, defaultSchema)
        {
        }

        protected override void OnModelCreating(DbModelBuilder modelBuilder)
        {
            base.OnModelCreating(modelBuilder);
            modelBuilder.Entity<HistoryRow>().Property(h => h.MigrationId).HasMaxLength(100).IsRequired();
            modelBuilder.Entity<HistoryRow>().Property(h => h.ContextKey).HasMaxLength(200).IsRequired();
        }
    }
}
