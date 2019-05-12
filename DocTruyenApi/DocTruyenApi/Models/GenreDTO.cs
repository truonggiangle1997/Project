using System;
using System.Collections.Generic;
using System.Linq;
using System.Runtime.Serialization;
using System.Web;

namespace DocTruyenApi.Models
{
    public class GenreDTO
    {
        [DataMember]
        public string genreId { get; set; }
        [DataMember]
        public string genreName { get; set; }
    }
}