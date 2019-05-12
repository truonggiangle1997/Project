using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using DocTruyenApi.Models;

namespace DocTruyenApi.Services
{
    public class ChapterService : IChapterService
    {
        dbMangaEntities db = new dbMangaEntities();
        public bool addChapter(ChapterDTO chapter)
        {
            Chapter ch = new Chapter();
            ch.chapterId = chapter.chapterId;
            ch.chapterNumber = chapter.chapterNumber;
            ch.chapterName = chapter.chapterName;
            ch.mangaId = chapter.mangaId;
            try
            {
                db.Chapters.Add(ch);
                db.SaveChanges();
                return true;
            }
            catch
            {
                return false;
            }
        }

        public bool deleteChapter(string chapterId)
        {
            Chapter ch = db.Chapters.Where(x => x.chapterId.Equals(chapterId)).SingleOrDefault();
            if (ch == null)
            {
                return false;
            }
            else
            {
                try
                {
                    db.Chapters.Attach(ch);
                    db.Chapters.Remove(ch);
                    db.SaveChanges();
                    return true;
                }
                catch
                {
                    return false;
                }
            }
        }

        public IEnumerable<ChapterDTO> getChapters(string mangaId)
        {
            var chapters = db
                  .Chapters
                  .Include("Pages")
                  .Select(ch => new ChapterDTO()
                  {
                      chapterId = ch.chapterId,
                      mangaId = ch.mangaId,
                      chapterName = ch.chapterName,
                      chapterNumber = ch.chapterNumber,
                      //Chapters_Pages = ch.Pages.Select(pa => new PageDTO()
                      //{
                      //    pageId = pa.pageId,
                      //    chapterId = pa.chapterId,
                      //    pageNumber = pa.pageNumber,
                      //    link1 = pa.link1,
                      //    link2 = pa.link2
                      //})
                  })
                  .OrderBy(ch => ch.chapterNumber)
                  .Where(ch => ch.mangaId.Equals(mangaId));
            return chapters;
        }

        public bool updateChapter(ChapterDTO chapter)
        {
            Chapter ch = db.Chapters.Where(x => x.chapterId.Equals(chapter.chapterId)).SingleOrDefault();
            if (ch == null)
            {
                return false;
            }
            else
            {
                ch.chapterName = chapter.chapterName;
                ch.mangaId = chapter.mangaId;
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