using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace DocTruyenApi.Models
{
    public class UserDTO
    {
        public string userId { get; set; }
        public byte[] password { get; set; }
        public string name { get; set; }
        public Nullable<int> roleId { get; set; }
        public string condition { get; set; }
    }
}