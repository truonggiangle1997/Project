using System;
using DocTruyenApi.Models;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace DocTruyenApi.Services
{
    public class MangaService : IMangaService
    {
        private readonly dbMangaEntities db = new dbMangaEntities();      
        public IEnumerable<MangaDetailDTO> getMangas(int? pageNumber, int? count)
        {
           
            var takePage = pageNumber ?? 1;   // Neu tham bien la null thi mac dinh se la trang 1
            var takeCount = count ?? 5; // Neu tham bien la null thi mac dinh moi trang co 5 items

            var mangas = db
                .Mangas
                .Include("Genres")
                .Select(mg => new MangaDetailDTO
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

                })
                .OrderBy(x => x.mangaId)
                .Skip((takePage - 1) * takeCount)
                .Take(takeCount);
            return mangas;
        }

        public IEnumerable<MangaDetailDTO> findMangasByName(string mangaName)
        {
            var mangas = db
                .Mangas
                .Include("Genres")
                .Include("Chapters")
                .Select(mg => new MangaDetailDTO
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
                })
                .OrderBy(mg => mg.mangaName)
                .Where(mg => mg.mangaName.Contains(mangaName)).ToList();          
            return mangas;
        }

        public bool addManga(MangaDTO manga)
        {
            Manga mg = new Manga();
            mg.mangaId = manga.mangaId;
            mg.mangaName = manga.mangaName;
            mg.authorId = manga.authorId;
            mg.statusId = manga.statusId;
            mg.describe = manga.describe;
            mg.cover = manga.cover;
            try
            {
                db.Mangas.Add(mg);
                db.SaveChanges();
                return true;
            }
            catch
            {
                return false;
            }
        }

        public bool updateManga(MangaDTO manga)
        {
            Manga mg = db.Mangas.Where(x => x.mangaId.Equals(manga.mangaId)).SingleOrDefault();
            if(mg == null)
            {
                return false;
            }
            else
            {
                mg.mangaName = manga.mangaName;
                mg.authorId = manga.authorId;
                mg.statusId = manga.statusId;
                mg.describe = manga.describe;
                mg.cover = manga.cover;
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

        public bool deleteManga(string mangaId)
        {
            Manga mg = db.Mangas.Where(x => x.mangaId.Equals(mangaId)).SingleOrDefault();
            if (mg == null)
            {
                return false;
            }
            else
            {              
                try
                {
                    db.Mangas.Attach(mg);
                    db.Mangas.Remove(mg);
                    db.SaveChanges();
                    return true;
                }
                catch
                {
                    return false;
                }
            }
        }

        public bool deleteMangaGenre(string mangaId, string genreId)
        {
            var manga = db.Mangas.SingleOrDefault(x => x.mangaId.Equals(mangaId));
            var genre = db.Genres.SingleOrDefault(x => x.genreId.Equals(genreId));

            try
            {
                db.Mangas.Attach(manga);
                manga.Genres.Remove(genre);
                db.SaveChanges();
                return true;
            }
            catch
            {
                return false;
            }
        }

        public bool addMangaGenre(string mangaId, string genreId)
        {
            var manga = db.Mangas.SingleOrDefault(x => x.mangaId.Equals(mangaId));
            var genre = db.Genres.SingleOrDefault(x => x.genreId.Equals(genreId));

            try
            {
                manga.Genres.Add(genre);
                db.SaveChanges();
                return true;
            }
            catch
            {
                return false;
            }
        }

        public MangaDetailDTO getMangaById(string mangaId)
        {
            var manga = db
               .Mangas
               .Include("Genres")
               .Include("Chapters")
               .Select(mg => new MangaDetailDTO
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
                   }),
                   Mangas_Chapters = mg.Chapters.Select(ch => new ChapterDTO
                   {
                       chapterId = ch.chapterId,
                       chapterName = ch.chapterName,
                       mangaId = ch.mangaId,
                       chapterNumber = ch.chapterNumber
                   })
               }).SingleOrDefault(mg => mg.mangaId.Equals(mangaId));
            return manga;
        }

        public IEnumerable<MangaDetailDTO> getMangas()
        {
            var mangas = db
                .Mangas
                .Include("Genres")
                .Select(mg => new MangaDetailDTO
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

                }).OrderBy(x => x.mangaId);
            return mangas;
        }
    }
}