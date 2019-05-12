using System;
using System.Collections.Generic;
using System.Linq;
using System.Runtime.Serialization;
using System.Web;

namespace DocTruyenApi.Models
{
    public class ChapterDTO
    {
        [DataMember]
        public int chapterId { get; set; }
        [DataMember]
        public string chapterName { get; set; }
        [DataMember]
        public string mangaId { get; set; }
        [DataMember]
        public Nullable<int> chapterNumber { get; set; }
        //[DataMember]
        //public IEnumerable<PageDTO> Chapters_Pages { get; set; }
    }
}