using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using DocTruyenApi.Models;
using System.Security.Cryptography;
using System.Text;

namespace DocTruyenApi.Services
{
    public class UserService : IUserService
    {
        dbMangaEntities db = new dbMangaEntities();

        public bool addFavorite(string id, string mangaId)
        {
            var manga = db.Mangas.SingleOrDefault(x => x.mangaId.Equals(mangaId));
            var user = db.Users.SingleOrDefault(x => x.userId.Equals(id));

            try
            {               
                user.Mangas.Add(manga);
                db.SaveChanges();
                return true;
            }
            catch
            {
                return false;
            }
        }

        public bool addUser(UserDTO user)
        {
            User us = new User();
            us.userId = user.userId;
            us.password = user.password;
            us.name = user.name;
            us.roleId = user.roleId;
            us.condition = user.condition;

            try
            {
                db.Users.Add(us);
                db.SaveChanges();
                return true;
            }
            catch
            {
                return false;
            }
        }

        public bool deleteFavorite(string id, string mangaId)
        {
            var manga = db.Mangas.SingleOrDefault(x => x.mangaId.Equals(mangaId));
            var user = db.Users.SingleOrDefault(x => x.userId.Equals(id));

            try
            {
                db.Users.Attach(user);
                user.Mangas.Remove(manga);               
                db.SaveChanges();
                return true;
            }
            catch
            {
                return false;
            }
        }

        public IEnumerable<MangaDetailDTO> getMangaFavorite(string id)
        {
            var user = db.Users.SingleOrDefault(x => x.userId.Equals(id));
            if(user == null)
            {
                return null;
            }
            else
            {
                var mangas = user
                    .Mangas
                    .Select(mg => new MangaDetailDTO()
                    {
                        mangaId = mg.mangaId,
                        mangaName = mg.mangaName,
                        authorName = mg.Author.authorName,
                        statusName = mg.Status.statusName,
                        describe = mg.describe,
                        cover = mg.cover,
                        Mangas_Genres = mg.Genres.Select(ge => new GenreDTO
                        {
                            genreId = ge.genreId,
                            genreName = ge.genreName
                        })
                    }).OrderBy(mg => mg.mangaName);
                return mangas;
            }          
        }

        public UserDTO getUser(string id, string password)
        {
            byte[] inputBytes = Encoding.UTF8.GetBytes(password);
            SHA1Managed sha1 = new SHA1Managed();
            var password_hashed = sha1.ComputeHash(inputBytes);

            var user = db
                 .Users
                 .Select(x => new UserDTO()
                 {
                     userId = x.userId,
                     password = x.password,
                     roleId = x.roleId,
                     name = x.name,
                     condition = x.condition
                 }).SingleOrDefault(x => x.userId.Equals(id) && x.password == password_hashed);
            // neu dkien chi co password thi do password co the trung nhau nen singleordefault se loi

            if (user == null)
            {
                return null;
            }
            else
            {
                var userInfo = new UserDTO();
                userInfo.userId = user.userId;
                userInfo.name = user.name;
                userInfo.roleId = user.roleId;
                userInfo.condition = user.condition;
                return userInfo;
            }            
        }
    }
}