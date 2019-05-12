using DocTruyenApi.Models;
using DocTruyenApi.Services;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Net;
using System.Net.Http;
using System.Security.Cryptography;
using System.Text;
using System.Web.Http;
using System.Web.Http.Cors;

namespace DocTruyenApi.Controllers
{
    [EnableCorsAttribute("*", "*", "*")]
    [RoutePrefix("user")]
    public class UserController : ApiController
    {
        IUserService userService = new UserService();

        public UserController() { }
        public UserController(IUserService userService)
        {
            this.userService = userService;
        }


        [Route("{id}/{password}")]
        [HttpGet]
        public IHttpActionResult getUser(string id, string password)
        {
            if (userService.getUser(id, password) == null)
            {
                return NotFound();
            }
            else
            {
                return Ok(userService.getUser(id, password));
            }
        }

        [Route("{id}")]
        [HttpGet]
        public IHttpActionResult getMangaFavorite(string id)
        {
            if(userService.getMangaFavorite(id) == null)
            {
                return NotFound();
            }
            else
            {
                return Ok(userService.getMangaFavorite(id));
            }
        }

        [Route("{id}/{mangaId}")]
        [HttpPost]
        public IHttpActionResult addFavorite(string id, string mangaId)
        {
            if(!userService.addFavorite(id, mangaId))
            {
                return NotFound();
            }
            else
            {
                return Ok("Success");
            }
        }

        [Route("{userId}/{password}/{name}/{roleId}/{condition}")]
        [HttpPost]
        public IHttpActionResult addUser(string userId, string password, string name, int roleId, string condition)
        {
            byte[] inputBytes = Encoding.UTF8.GetBytes(password);
            SHA1Managed sha1 = new SHA1Managed();
            var password_hashed = sha1.ComputeHash(inputBytes);

            UserDTO user = new UserDTO();
            user.userId = userId;
            user.password = password_hashed;
            user.name = name;
            user.roleId = roleId;
            user.condition = condition;

            if (!userService.addUser(user))
            {
                return NotFound();
            }
            else
            {
                return Ok("Success");
            }
        }

        [Route("{id}/{mangaId}")]
        [HttpDelete]
        public IHttpActionResult deleteFavorite(string id, string mangaId)
        {
            if (!userService.deleteFavorite(id, mangaId))
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
