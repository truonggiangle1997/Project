using DocTruyenApi.Models;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;


namespace DocTruyenApi.Services
{
    public interface IMangaService
    {
        IEnumerable<MangaDetailDTO> getMangas();
        IEnumerable<MangaDetailDTO> getMangas(int? pageNumber, int? count);
        IEnumerable<MangaDetailDTO> findMangasByName(string mangaName);
        MangaDetailDTO getMangaById(string mangaId);
        bool addManga(MangaDTO manga);
        bool addMangaGenre(string mangaId, string genreId);
        bool updateManga(MangaDTO manga);
        bool deleteManga(string mangaId);
        bool deleteMangaGenre(string mangaId, string genreId);
    }
}
