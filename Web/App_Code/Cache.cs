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
    private static List<ModelDictDetail> dict;
    private static List<ModelSpec> dictSpec;

    static DataCache()
    {
        ServiceCommon servComm = new ServiceCommon();
        dict = servComm.GetListTop<ModelDictDetail>(0,null).ToList();
        dictSpec= servComm.GetListTop<ModelSpec>(0, null).ToList();
    }

    public static List<ModelDictDetail> findAllDict()
    {
        return dict;
    }  
}