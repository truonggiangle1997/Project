//------------------------------------------------------------------------------
// <auto-generated>
//     This code was generated from a template.
//
//     Manual changes to this file may cause unexpected behavior in your application.
//     Manual changes to this file will be overwritten if the code is regenerated.
// </auto-generated>
//------------------------------------------------------------------------------

namespace DocTruyenApi
{
    using System;
    using System.Collections.Generic;
    
    public partial class Page
    {
        public int pageId { get; set; }
        public Nullable<int> chapterId { get; set; }
        public Nullable<int> pageNumber { get; set; }
        public string link1 { get; set; }
        public string link2 { get; set; }
    
        public virtual Chapter Chapter { get; set; }
    }
}
