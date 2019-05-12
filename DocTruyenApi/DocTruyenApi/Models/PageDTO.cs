using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace DocTruyenApi.Models
{
    public class PageDTO
    {
        public int pageId { get; set; }
        public Nullable<int> chapterId { get; set; }
        public Nullable<int> pageNumber { get; set; }
        public string link1 { get; set; }
        public string link2 { get; set; }
    }
}