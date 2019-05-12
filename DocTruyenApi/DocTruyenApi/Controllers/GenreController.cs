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
    [RoutePrefix("genre")]
    public class GenreController : ApiController
    {
        private IGenreService genreService = new GenreService();
        public GenreController() { }
        public GenreController(IGenreService genreService)
        {
            this.genreService = genreService;
        }

        [Route("")]
        [HttpGet]
        public IEnumerable<GenreDTO> getGenres()
        {
            return genreService.getGenres();
        }

        [Route("{genreName}")]
        [HttpGet]
        public IHttpActionResult getMangaByGenre(string genreName)
        {             
            if(genreService.getMangaByGenre(genreName).Count() == 0)
            {
                return NotFound();
            }
            else
            {
                return Ok(genreService.getMangaByGenre(genreName));
            }
        }

        [Route("{genreId}/{genreName}")]
        [HttpPost]
        public IHttpActionResult addGenre(string genreId, string genreName)
        {
            GenreDTO genre = new GenreDTO();
            genre.genreId = genreId;
            genre.genreName = genreName;

            if (!genreService.addGenre(genre))
            {
                return NotFound();
            }
            else
            {
                return Ok("Success");
            }
        }

        [Route("{genreId}/{genreName}")]
        [HttpPut]
        public IHttpActionResult update(string genreId, string genreName)
        {
            if (!ModelState.IsValid)
            {
                return BadRequest(ModelState);
            }
            GenreDTO genre = new GenreDTO();
            genre.genreId = genreId;
            genre.genreName = genreName;
            if (!genreService.updateGenre(genre))
            {
                return NotFound();
            }
            else
            {
                return Ok("Success");
            }
        }

        [Route("{genreId}")]
        [HttpDelete]
        public IHttpActionResult deleteGenre(string genreId)
        {
            if (!genreService.deleteGenre(genreId))
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
