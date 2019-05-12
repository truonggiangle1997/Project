using Newtonsoft.Json;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Runtime.Serialization;
using System.Web;

namespace DocTruyenApi.Models
{
    //[DataContract(IsReference = true)]
    public class MangaDTO
    {
        [DataMember]
        public string mangaId { get; set; }
        [DataMember]
        public string mangaName { get; set; }
        [DataMember]
        public string authorId { get; set; }      
        [DataMember]
        public int statusId { get; set; }      
        [DataMember]
        public string describe { get; set; }
        [DataMember]
        public string cover { get; set; }
        public MangaDTO() { }
        public MangaDTO(string mangaId, string mangaName, string authorId, int statusId, string describe, string cover)
        {
            this.mangaId = mangaId;
            this.mangaName = mangaName;
            this.authorId = authorId;
            this.statusId = statusId;
            this.describe = describe;
            this.cover = cover;
        }
    }
}