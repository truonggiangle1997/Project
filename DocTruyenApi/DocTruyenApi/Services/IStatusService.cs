using DocTruyenApi.Models;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace DocTruyenApi.Services
{
  public interface IStatusService
    {
        IEnumerable<StatusDTO> getStatus();
        StatusDTO getStatusByName(string statusName);
        bool addStatus(StatusDTO status);
        bool updateStatus(StatusDTO status);
        bool deleteStatus(string statusId);
    }
}
