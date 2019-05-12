using DocTruyenApi.Models;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace DocTruyenApi.Services
{
   public interface IAuthorService
    {
        IEnumerable<AuthorDTO> getAuthors();
        IEnumerable<AuthorDTO> getAuthorByName(string authorName);
        IEnumerable<MangaDetailDTO> getMangaByAuthorId(string authorId);
        bool addAuthor(AuthorDTO author);
        bool updateAuthor(AuthorDTO author);
        bool deleteAuthor(string authorId);
    }
}
