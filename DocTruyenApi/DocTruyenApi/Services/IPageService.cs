using DocTruyenApi.Models;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace DocTruyenApi.Services
{
    public interface IPageService
    {
        IEnumerable<PageDTO> getPages(int chapterId);
        bool addPage(PageDTO page);
        bool updatePage(PageDTO page);
        bool deletePage(int pageId);
    }
}
