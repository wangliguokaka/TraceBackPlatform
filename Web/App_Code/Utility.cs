using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using Newtonsoft.Json;

namespace TraceBackPlatform.AppCode
{
    public class Utility
    { 
        
        /// <summary>
        /// 将json数组转为实体集合
        /// </summary>
        public static List<T> ConvertJsonToEntity<T>(string[] jsonArray)
        {
            return jsonArray.Select(JsonConvert.DeserializeObject<T>).ToList();
        }

        /// <summary>
        /// 将json对象转为实体
        /// </summary>
        public static T ConvertJsonToEntity<T>(string jsonStr)
        {
            return JsonConvert.DeserializeObject<T>(jsonStr);
        }
    }
}