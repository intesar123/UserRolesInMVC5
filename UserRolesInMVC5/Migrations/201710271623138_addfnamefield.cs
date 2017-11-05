namespace HospMgmt.Migrations
{
    using System;
    using System.Data.Entity.Migrations;
    
    public partial class addfnamefield : DbMigration
    {
        public override void Up()
        {
            AddColumn("dbo.AspNetUsers", "FatherName", c => c.String());
        }
        
        public override void Down()
        {
            DropColumn("dbo.AspNetUsers", "FatherName");
        }
    }
}
