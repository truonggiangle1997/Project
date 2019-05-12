using System;
using System.Collections.Generic;
using System.Linq;
using System.Runtime.Serialization;
using System.Web;

namespace DocTruyenApi.Models
{
    public class MangaDetailDTO
    {
        [DataMember]
        public string mangaId { get; set; }
        [DataMember]
        public string mangaName { get; set; }
        [DataMember]
        public string authorName { get; set; }
        [DataMember]
        public string authorId { get; set; }
        [DataMember]             
        public IEnumerable<GenreDTO> Mangas_Genres { get; set; }
        //public string genreName { get; set; }
        [DataMember]
        public IEnumerable<ChapterDTO> Mangas_Chapters { get; set; }
        [DataMember]
        public string statusName { get; set; }
        [DataMember]
        public string describe { get; set; }
        [DataMember]
        public string cover { get; set; }
    }
}