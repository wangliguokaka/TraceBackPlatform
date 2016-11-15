using D2012.Common.DbCommon;
using D2012.Domain.Common;
using System;
using System.Collections.Generic;

namespace D2012.Domain.Entities
{

    /// <summary>
    /// 
    /// </summary>
    [Serializable]
    [Table("Dict", "ClassID", false, false)]
    public partial class ModelDict : BaseEntity
    {
        public ModelDict()
        { }

        public static string STRTABLENAME = "Dict";
        public static string STRKEYNAME = "ClassID";

        /// <summary>
        /// 
        /// </summary>
        [Column("MainClass", DataType.Varchar, false, false)]
        public string MainClass { set; get; }
        /// <summary>
        /// 
        /// </summary>
        [Column("ClassID", DataType.Varchar, false, false)]
        public string ClassID { set; get; }

        /// <summary>
        /// 
        /// </summary>
        [Column("ClassName", DataType.Varchar, false, false)]
        public string ClassName { set; get; }


        /// <summary>
        /// 
        /// </summary>
        [Column("Sortno", DataType.Int, false, false)]
        public int? Sortno { set; get; }


        /// <summary>
        /// 
        /// </summary>
        [Column("UpdateTime", DataType.Datetime, false, false)]
        public DateTime UpdateTime { set; get; }

        /// <summary>
        /// 
        /// </summary>
        [Column("UpdateUser", DataType.Varchar, false, false)]
        public string UpdateUser { set; get; }



    }
   

}
