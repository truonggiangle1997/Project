using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace DocTruyenApi.Models
{
    public class AuthorDTO
    {
        public string authorId { get; set; }
        public string authorName { get; set; }
        public string facebook { get; set; }
        public string twitter { get; set; }
    }
}