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
    [RoutePrefix("author")]
    public class AuthorController : ApiController
    {
        IAuthorService authorService = new AuthorService();
        public AuthorController() { }
        public AuthorController(IAuthorService authorService)
        {
            this.authorService = authorService;
        }

        [Route("")]
        [HttpGet]
        public IEnumerable<AuthorDTO> getAuthors()
        {
            return authorService.getAuthors();
        }

        [Route("{authorId}")]
        [HttpGet]
        public IHttpActionResult getMangaByAuthorId(string authorId)
        {
            if(authorService.getMangaByAuthorId(authorId).Count() == 0)
            {
                return NotFound();
            }
            else
            {
                return Ok(authorService.getMangaByAuthorId(authorId));
            }                    
        }

        [Route("{find}/{authorName}")]
        [HttpGet]
        public IHttpActionResult getAuthorByName(string authorName)
        {
            if (authorService.getAuthorByName(authorName) == null)
            {
                return NotFound() ;
            }
            else
            {
                return Ok(authorService.getAuthorByName(authorName));
            }
        }

        [Route("{authorId}/{authorName}/{facebook}/{twitter}")]
        [HttpPost]
        public IHttpActionResult addAuthor(string authorId, string authorName, string facebook, string twitter)
        {
            if (!ModelState.IsValid)
            {
                return BadRequest(ModelState);
            }
            AuthorDTO au = new AuthorDTO();
            au.authorId = authorId;
            au.authorName = authorName;
            au.facebook = facebook;
            au.twitter = twitter;
            if (!authorService.addAuthor(au))
            {
                return NotFound();
            }
            else
            {
                return Ok("Success");
            }
        }

        [Route("{authorId}/{authorName}/{facebook}/{twitter}")]
        [HttpPut]
        public IHttpActionResult updateAuthor(string authorId, string authorName, string facebook, string twitter)
        {
            if (!ModelState.IsValid)
            {
                return BadRequest(ModelState);
            }
            AuthorDTO au = new AuthorDTO();
            au.authorId = authorId;
            au.authorName = authorName;
            au.facebook = facebook;
            au.twitter = twitter;
            if (!authorService.updateAuthor(au))
            {
                return NotFound();
            }
            else
            {
                return Ok("Success");
            }
        }

        [Route("{authorId}")]
        [HttpDelete]
        public IHttpActionResult deleteAuthor(string authorId)
        {
            if (!authorService.deleteAuthor(authorId))
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
