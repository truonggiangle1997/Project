using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using DocTruyenApi.Models;

namespace DocTruyenApi.Services
{
    public class PageService : IPageService
    {
        dbMangaEntities db = new dbMangaEntities();

        public bool addPage(PageDTO page)
        {
            Page pa = new Page();          
            pa.chapterId = page.chapterId;
            pa.pageNumber = page.pageNumber;
            pa.link1 = page.link1;
            pa.link2 = page.link2;
            try
            {
                db.Pages.Add(pa);
                db.SaveChanges();
                return true;
            }
            catch
            {
                return false;
            }
        }

        public bool deletePage(int pageId)
        {
            Page pa = db.Pages.Where(x => x.pageId == pageId).SingleOrDefault();
            if (pa == null)
            {
                return false;
            }
            else
            {
                try
                {
                    db.Pages.Attach(pa);
                    db.Pages.Remove(pa);
                    db.SaveChanges();
                    return true;
                }
                catch
                {
                    return false;
                }
            }
        }

        public IEnumerable<PageDTO> getPages(int chapterId)
        {
            var pages = db
                .Pages
                .Select(pa => new PageDTO()
                {
                    pageId = pa.pageId,
                    pageNumber = pa.pageNumber,
                    chapterId = pa.chapterId,
                    link1 = pa.link1,
                    link2 = pa.link2
                })
                .OrderBy(pa => pa.pageNumber)
                .Where(pa => pa.chapterId == chapterId);
            return pages;
        }

        public bool updatePage(PageDTO page)
        {
            Page pa = db.Pages.Where(x => x.chapterId == page.chapterId && x.pageNumber == page.pageNumber).FirstOrDefault();
            if(pa == null)
            {
                return false;
            }
            else
            {
                pa.chapterId = page.chapterId;
                pa.pageNumber = page.pageNumber;
                pa.link1 = page.link1;
                pa.link2 = page.link2;
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