using System;
using System.Collections.Generic;
using System.Data;
using System.Data.Entity;
using System.Linq;
using System.Net;
using System.Web;
using System.Web.Mvc;
using HospMgmt.Models;

namespace HospMgmt.Controllers
{
    public class MobAppointmentsController : Controller
    {
        private AppointmentDbContext db = new AppointmentDbContext();

        // GET: MobAppointments
        public ActionResult Index()
        {
            return View(db.mvctest.ToList());
        }

        // GET: MobAppointments/Details/5
        
        public ActionResult Details(int? id)
        {
            if (id == null)
            {
                return new HttpStatusCodeResult(HttpStatusCode.BadRequest);
            }
            MobAppointment mobAppointment = db.mvctest.Find(id);
            if (mobAppointment == null)
            {
                return HttpNotFound();
            }
            return View(mobAppointment);
        }

        // GET: MobAppointments/Create
        public ActionResult Create()
        {
            return View();
        }

        // POST: MobAppointments/Create
        // To protect from overposting attacks, please enable the specific properties you want to bind to, for 
        // more details see http://go.microsoft.com/fwlink/?LinkId=317598.
        [HttpPost]
        [ValidateAntiForgeryToken]
        public ActionResult Create([Bind(Include = "id,mobnum,isverified")] MobAppointment mobAppointment)
        {
            if (ModelState.IsValid)
            {
                db.mvctest.Add(mobAppointment);
                db.SaveChanges();
                return RedirectToAction("Index");
            }

            return View(mobAppointment);
        }

        // GET: MobAppointments/Edit/5
        public ActionResult Edit(int? id)
        {
            if (id == null)
            {
                return new HttpStatusCodeResult(HttpStatusCode.BadRequest);
            }
            MobAppointment mobAppointment = db.mvctest.Find(id);
            if (mobAppointment == null)
            {
                return HttpNotFound();
            }
            return View(mobAppointment);
        }

        // POST: MobAppointments/Edit/5
        // To protect from overposting attacks, please enable the specific properties you want to bind to, for 
        // more details see http://go.microsoft.com/fwlink/?LinkId=317598.
        [HttpPost]
        [ValidateAntiForgeryToken]
        public ActionResult Edit([Bind(Include = "id,mobnum,isverified")] MobAppointment mobAppointment)
        {
            if (ModelState.IsValid)
            {
                db.Entry(mobAppointment).State = EntityState.Modified;
                db.SaveChanges();
                return RedirectToAction("Index");
            }
            return View(mobAppointment);
        }

        // GET: MobAppointments/Delete/5
        [Authorize(Roles = "Admin")]
        public ActionResult Delete(int? id)
        {
            if (id == null)
            {
                return new HttpStatusCodeResult(HttpStatusCode.BadRequest);
            }
            MobAppointment mobAppointment = db.mvctest.Find(id);
            if (mobAppointment == null)
            {
                return HttpNotFound();
            }
            return View(mobAppointment);
        }

        // POST: MobAppointments/Delete/5
        [HttpPost, ActionName("Delete")]
        [ValidateAntiForgeryToken]
        public ActionResult DeleteConfirmed(int id)
        {
            MobAppointment mobAppointment = db.mvctest.Find(id);
            db.mvctest.Remove(mobAppointment);
            db.SaveChanges();
            return RedirectToAction("Index");
        }

        protected override void Dispose(bool disposing)
        {
            if (disposing)
            {
                db.Dispose();
            }
            base.Dispose(disposing);
        }
    }
}
