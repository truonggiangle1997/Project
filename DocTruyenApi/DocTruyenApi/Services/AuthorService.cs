using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using DocTruyenApi.Models;

namespace DocTruyenApi.Services
{
    public class AuthorService : IAuthorService
    {
        private dbMangaEntities db = new dbMangaEntities();

        public bool addAuthor(AuthorDTO author)
        {
            Author au = new Author();
            au.authorId = author.authorId;
            au.authorName = author.authorName;
            au.facebook = author.facebook;
            au.twitter = author.twitter;
            try
            {
                db.Authors.Add(au);
                db.SaveChanges();
                return true;
            }
            catch
            {
                return false;
            }
        }

        public bool deleteAuthor(string authorId)
        {
            Author au = db.Authors.Where(x => x.authorId.Equals(authorId)).SingleOrDefault();
            if (au == null)
            {
                return false;
            }
            else
            {
                try
                {
                    db.Authors.Attach(au);
                    db.Authors.Remove(au);
                    db.SaveChanges();
                    return true;
                }
                catch
                {
                    return false;
                }
            }
        }

        public IEnumerable<AuthorDTO> getAuthorByName(string authorName)
        {
            var authors = db
                .Authors
                .Select(au => new AuthorDTO()
                {
                    authorName = au.authorName,
                    authorId = au.authorId,
                    facebook = au.facebook,
                    twitter = au.twitter                   
                }).Where(au => au.authorName.Contains(authorName));
            return authors;
        }

        public IEnumerable<AuthorDTO> getAuthors()
        {
            var authors = db
                .Authors
                .Select(au => new AuthorDTO()
                {
                    authorId = au.authorId,
                    authorName = au.authorName
                });
            return authors;
        }

        public IEnumerable<MangaDetailDTO> getMangaByAuthorId(string authorId)
        {
            var mangas = db
                .Mangas
                .Include("Genres")
                .Select(mg => new MangaDetailDTO()
                {
                    mangaId = mg.mangaId,
                    mangaName = mg.mangaName,
                    authorName = mg.Author.authorName,
                    authorId = mg.authorId,
                    statusName = mg.Status.statusName,
                    describe = mg.describe,
                    cover = mg.cover,
                    Mangas_Genres = mg.Genres.Select(ge => new GenreDTO
                    {
                        genreId = ge.genreId,
                        genreName = ge.genreName
                    })
                })
                .OrderBy(mg => mg.mangaName)
                .Where(mg => mg.authorId.Equals(authorId));
            return mangas;
        }

        public bool updateAuthor(AuthorDTO author)
        {
            Author au = db.Authors.Where(x => x.authorId.Equals(author.authorId)).SingleOrDefault();
            if (au == null)
            {
                return false;
            }
            else
            {
                au.authorName = author.authorName;
                au.facebook = author.facebook;
                au.twitter = author.twitter;
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