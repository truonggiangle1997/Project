using DocTruyenApi.Models;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace DocTruyenApi.Services
{
    public interface IGenreService
    {
        IEnumerable<GenreDTO> getGenres();
        GenreDTO getGenreByName(string genreName);
        IEnumerable<MangaDetailDTO> getMangaByGenre(string genreName);
        bool addGenre(GenreDTO genre);
        bool updateGenre(GenreDTO genre);
        bool deleteGenre(string genreId);
    }
}
