using DocTruyenApi.Models;
using DocTruyenApi.Services;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Net;
using System.Net.Http;
using System.Text;
using System.Web.Http;
using System.Web.Http.Cors;

namespace DocTruyenApi.Controllers
{
    [EnableCorsAttribute("*", "*", "*")]
    [RoutePrefix("page")]
    public class PageController : ApiController
    {
        IPageService pageService = new PageService();
       

        public PageController() { }
        public PageController(IPageService pageService)
        {
            this.pageService = pageService;
        }

        [Route("{chapterId}")]
        [HttpGet]
        public IEnumerable<PageDTO> getPages(int chapterId)
        {
            return pageService.getPages(chapterId);
        }


        [Route("{chapterId}/{pageNumber}/{link1}/{link2}")]
        [HttpPost]
        public IHttpActionResult addPage(int chapterId, int pageNumber ,string link1, string link2)
        {
            string link1_changed = "";
            string link2_changed = "";

            if (!link1.Equals("null"))
            {
                link1_changed = Encoding.UTF8.GetString(getLink(link1));
            }
            else { link1_changed = link1; }

            if (!link2.Equals("null"))
            {
                link2_changed = Encoding.UTF8.GetString(getLink(link2));
            }
            else { link2_changed = link2; }

            PageDTO pa = new PageDTO();
            pa.chapterId = chapterId;
            pa.pageNumber = pageNumber;
            pa.link1 = link1_changed;
            pa.link2 = link2_changed;
            if (!pageService.addPage(pa))
            {
                return NotFound();
            }
            else
            {
                return Ok("Success");
            }
        }

        [Route("{chapterId}/{pageNumber}/{link1}/{link2}")]
        [HttpPut]
        public IHttpActionResult updatePage(int chapterId, int pageNumber, string link1, string link2)
        {
            if (!ModelState.IsValid)
            {
                return BadRequest(ModelState);
            }

            string link1_changed = "";
            string link2_changed = "";

            if (!link1.Equals("null"))
            {
                link1_changed = Encoding.UTF8.GetString(getLink(link1));
            }
            else { link1_changed = link1; }

            if (!link2.Equals("null"))
            {
                link2_changed = Encoding.UTF8.GetString(getLink(link2));
            }
            else { link2_changed = link2; }
            PageDTO pa = new PageDTO();
            
            pa.chapterId = chapterId;
            pa.pageNumber = pageNumber;
            pa.link1 = link1_changed;
            pa.link2 = link2_changed;
            if (!pageService.updatePage(pa))
            {
                return NotFound();
            }
            else
            {
                return Ok("Success");
            }
        }

        [Route("{pageId}")]
        [HttpDelete]
        public IHttpActionResult deletePage(int pageId)
        {
            if (!pageService.deletePage(pageId))
            {
                return NotFound();
            }
            else
            {
                return Ok("Success");
            }
        }

        private byte[] getLink(string link)
        {
            int NumberChars = link.Length;
            byte[] bytes = new byte[NumberChars / 2];
            for (int i = 0; i < NumberChars; i += 2)
                bytes[i / 2] = Convert.ToByte(link.Substring(i, 2), 16);
            return bytes;
        }
    }
}
