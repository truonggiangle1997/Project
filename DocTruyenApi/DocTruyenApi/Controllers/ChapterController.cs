using DocTruyenApi.Models;
using DocTruyenApi.Services;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Net;
using System.Net.Http;
using System.Web.Http;
using System.Web.Http.Cors;

namespace DocTruyenApi.Controllers
{
    [EnableCorsAttribute("*", "*", "*")]
    [RoutePrefix("chapter")]
    public class ChapterController : ApiController
    {
        IChapterService chapterService = new ChapterService();        

        public ChapterController() { }
        public ChapterController(IChapterService chapterService)
        {
            this.chapterService = chapterService;          
        }

        [Route("{mangaId}")]
        [HttpGet]
        public IEnumerable<ChapterDTO> getChapters(string mangaId)
        {            
            return chapterService.getChapters(mangaId);
        }

        [Route("{mangaId}/{chapterNumber}/{chapterName}")]
        [HttpPost]
        public IHttpActionResult addChapter(string mangaId, int chapterNumber, string chapterName)
        {
            ChapterDTO chapter = new ChapterDTO();
            chapter.chapterName = chapterName;
            chapter.mangaId = mangaId;
            chapter.chapterNumber = chapterNumber;

            if (!chapterService.addChapter(chapter))
            {
                return NotFound();
            }
            else
            {
                return Ok("Success");
            }
        }
    }
}
