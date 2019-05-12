using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using DocTruyenApi.Models;

namespace DocTruyenApi.Services
{
    public class StatusService : IStatusService
    {
        private dbMangaEntities db = new dbMangaEntities();

        public bool addStatus(StatusDTO status)
        {
            Status st = new Status();
            st.statusId = status.statusId;
            st.statusName = status.statusName;
            try
            {
                db.Status.Add(st);
                db.SaveChanges();
                return true;
            }
            catch
            {
                return false;
            }
        }

        public bool deleteStatus(string statusId)
        {
            Status st = db.Status.Where(x => x.statusId.Equals(statusId)).SingleOrDefault();
            if (st == null)
            {
                return false;
            }
            else
            {
                try
                {
                    db.Status.Attach(st);
                    db.Status.Remove(st);
                    db.SaveChanges();
                    return true;
                }
                catch
                {
                    return false;
                }
            }
        }

        public IEnumerable<StatusDTO> getStatus()
        {
            var status = db
                 .Status
                 .Select(st => new StatusDTO()
                 {
                     statusId = st.statusId,
                     statusName = st.statusName
                 });
            return status;
        }

        public StatusDTO getStatusByName(string statusName)
        {
            var status = db
                .Status
                .Select(st => new StatusDTO()
                {
                    statusId = st.statusId,
                    statusName = st.statusName
                }).SingleOrDefault(st => st.statusName.Equals(statusName));
            return status;
        }

        public bool updateStatus(StatusDTO status)
        {
            Status st = db.Status.Where(x => x.statusId.Equals(status.statusId)).SingleOrDefault();
            if (st == null)
            {
                return false;
            }
            else
            {
                st.statusName = status.statusName;
                try
                {
                    db.SaveChanges();
                    return true;
                }
                catch
                {
                    return false;
                }
            }
        }
    }
}