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
        [Table("DictDetail", "ClassID", false, false)]
        public partial class ModelDictDetail : BaseEntity
        {
            public ModelDictDetail()
            { }

            public static string STRTABLENAME = "DictDetail";
            public static string STRKEYNAME = "ClassID";


            /// <summary>
            /// 
            /// </summary>
            [Column("ClassID", DataType.Varchar, true, false)]
            public string ClassID { set; get; }

            /// <summary>
            /// 
            /// </summary>
            [Column("Code", DataType.Varchar, true, false)]
            public string Code { set; get; }

            /// <summary>
            /// 
            /// </summary>
            [Column("DictName", DataType.Varchar, true, false)]
            public string DictName { set; get; }


        /// <summary>
        /// 
        /// </summary>
        [Column("Sortno", DataType.Int, false, false)]
            public int? SortNo { set; get; }


            /// <summary>
            /// 
            /// </summary>
            [Column("OperTime", DataType.Datetime, false, false)]
            public DateTime OperTime { set; get; }

            /// <summary>
            /// 
            /// </summary>
            [Column("oper", DataType.Varchar, false, false)]
            public string oper { set; get; }



    }

}
