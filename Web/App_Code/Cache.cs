using D2012.Domain.Entities;
using D2012.Domain.Services;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

/// <summary>
/// Cache 的摘要说明
/// </summary>
public class DataCache
{
    private static List<ModelDict> dict;
    
    static DataCache()
    {
        ServiceCommon servComm = new ServiceCommon();
        dict = servComm.GetListTop<ModelDict>(0,null).ToList();  
    }

    public static List<ModelDict> findAllDict()
    {
        return dict;
    }  
}