using DocTruyenApi.Models;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace DocTruyenApi.Services
{
    public interface IChapterService
    {
        IEnumerable<ChapterDTO> getChapters(string mangaId);
        bool addChapter(ChapterDTO chapter);
        bool updateChapter(ChapterDTO chapter);
        bool deleteChapter(string chapterId);
    }
}
