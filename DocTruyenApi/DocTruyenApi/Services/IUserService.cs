using DocTruyenApi.Models;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace DocTruyenApi.Services
{
    public interface IUserService
    {
        UserDTO getUser(string id, string password);
        IEnumerable<MangaDetailDTO> getMangaFavorite(string id);
        bool addUser(UserDTO user); 
        bool addFavorite(string id, string mangaId);
        bool deleteFavorite(string id, string mangaId);
    }
}
