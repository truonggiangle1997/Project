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
    
    [EnableCorsAttribute("*","*","*")]
    [RoutePrefix("manga")]   
    public class MangaController : ApiController
    {
        //Init
        private IMangaService mangaService = new MangaService();
       
        //Construtors
        public MangaController() { }
        public MangaController(IMangaService mangaService)
        {
            this.mangaService = mangaService;
        }

        // Truong hop route nhieu field hon tham bien trong ham thi ten tham bien phai giong voi ten trong route, vd: pageNumber
        // Neu co cung so field thi ten cua tham bien trong ham co the khong can giong voi ten trong route
        [Route("{pages}/{pageNumber}")]  
        [HttpGet]
        public IEnumerable<MangaDetailDTO> getMangas(int? pageNumber)
        {
            return mangaService.getMangas(pageNumber, null);
        }
        
        [Route("{mangaName}")] 
        [HttpGet]
        public IHttpActionResult getMangaByName(string mangaName)
        {
            if( mangaService.findMangasByName(mangaName) == null)
            {
                return NotFound();
            }
            else
            {
                return Ok(mangaService.findMangasByName(mangaName));
            }
        }

        [Route("{read}/{mangaId}/{mangaName}")]
        [HttpGet]
        public IHttpActionResult getMangaById(string mangaId, string mangaName)
        {
            if (mangaService.getMangaById(mangaId) == null)
            {
                return NotFound();
            }
            else
            {
                return Ok(mangaService.getMangaById(mangaId));
            }
        }

        [Route("")]
        [HttpGet]
        public IEnumerable<MangaDetailDTO> getMangas()
        {
            return mangaService.getMangas();
        }

        [Route("{mangaId}/{mangaName}/{authorId}/{statusId}/{describe}/{cover}")]
        [HttpPost]
        public IHttpActionResult addManga(string mangaId, string mangaName, string authorId, int statusId, string describe, string cover)
        {
            
            if (!ModelState.IsValid)
            {
                return BadRequest(ModelState);
            }

            string cover_changed = "";
            if (!cover.Equals("null"))
            {
                cover_changed = Encoding.UTF8.GetString(getLink(cover));
            }

            else cover_changed = cover;
            
            MangaDTO mg = new MangaDTO();
            mg.mangaId = mangaId;
            mg.mangaName = mangaName;
            mg.authorId = authorId;
            mg.statusId = statusId;
            mg.describe = describe;
            mg.cover = cover_changed;
            if(!mangaService.addManga(mg))
            {
                return NotFound();
            }
            else
            {
                return Ok("Success");
            }
        }

        [Route("{mangaId}/{genreId}")]
        [HttpPost]
        public IHttpActionResult addMangaGenre(string mangaId, string genreId)
        {
            if (!mangaService.addMangaGenre(mangaId, genreId))
            {
                return NotFound();
            }
            else
            {
                return Ok("Success");
            }
        }

        [Route("{mangaId}/{mangaName}/{authorId}/{statusId}/{describe}/{cover}")]
        [HttpPut]
        public IHttpActionResult updateManga(string mangaId, string mangaName, string authorId, int statusId, string describe, string cover)
        {
            if (!ModelState.IsValid)
            {
                return BadRequest(ModelState);
            }

            string cover_changed = Encoding.UTF8.GetString(getLink(cover));
            MangaDTO mg = new MangaDTO();
            mg.mangaId = mangaId;
            mg.mangaName = mangaName;
            mg.authorId = authorId;
            mg.statusId = statusId;
            mg.describe = describe;
            mg.cover = cover_changed;
            if (!mangaService.updateManga(mg))
            {
                return NotFound();
            }
            else
            {
                return Ok("Success");
            }
        }

        [Route("{mangaId}")]
        [HttpDelete]
        public IHttpActionResult deleteManga(string mangaId)
        {
            if (!mangaService.deleteManga(mangaId))
            {
                return NotFound();
            }
            else
            {
                return Ok("Success");            
            }
        }

        [Route("{mangaId}/{genreId}")]
        [HttpDelete]
        public IHttpActionResult deleteMangaGenre(string mangaId, string genreId)
        {
            if (!mangaService.deleteMangaGenre(mangaId, genreId))
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
