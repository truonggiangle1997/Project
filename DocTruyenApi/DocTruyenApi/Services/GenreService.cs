using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using DocTruyenApi.Models;

namespace DocTruyenApi.Services
{
    public class GenreService : IGenreService
    {
        private dbMangaEntities db = new dbMangaEntities();

        public bool addGenre(GenreDTO genre)
        {
            Genre ge = new Genre();
            ge.genreId = genre.genreId;
            ge.genreName = genre.genreName;
            try
            {
                db.Genres.Add(ge);
                db.SaveChanges();
                return true;
            }
            catch
            {
                return false;
            }
        }

        public bool deleteGenre(string genreId)
        {
            Genre ge = db.Genres.Where(x => x.genreId.Equals(genreId)).SingleOrDefault();
            if (ge == null)
            {
                return false;
            }
            else
            {
                try
                {
                    db.Genres.Attach(ge);
                    db.Genres.Remove(ge);
                    db.SaveChanges();
                    return true;
                }
                catch
                {
                    return false;
                }
            }
        }

        public GenreDTO getGenreByName(string genreName)
        {
            var genre = db
                .Genres
                .Select(gr => new GenreDTO()
                {
                    genreId = gr.genreId,
                    genreName = gr.genreName
                }).SingleOrDefault(gr => gr.genreId.Equals(genreName));
            return genre;
        }

        public IEnumerable<GenreDTO> getGenres()
        {
            var genres = db
                .Genres
                .Select(ge => new GenreDTO()
                {
                    genreId = ge.genreId,
                    genreName = ge.genreName
                });
            return genres;
        }


        public IEnumerable<MangaDetailDTO> getMangaByGenre(string genreName)
        {
            var mangas = db
                .Mangas
                .Include("genres")
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
                    }).Where(ge => ge.genreName.Equals(genreName)),
                }).Where(x => x.Mangas_Genres.Count() != 0);
            return mangas;
        }

        public bool updateGenre(GenreDTO genre)
        {
            Genre ge = db.Genres.Where(x => x.genreId.Equals(genre.genreId)).SingleOrDefault();
            if (ge == null)
            {
                return false;
            }
            else
            {
                ge.genreName = genre.genreName;
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