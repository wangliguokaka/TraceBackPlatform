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
        [Table("DictArea", "codeid", false, false)]
        public partial class DictArea : BaseEntity
        {
            public DictArea()
            { }
            #region DictArea

            public static string STRTABLENAME = "DictArea";
            public static string STRKEYNAME = "codeid";


            /// <summary>
            /// 
            /// </summary>
            [Column("Codeid", DataType.Int, true, true)]
            public int Codeid { set; get; }


            /// <summary>
            /// 
            /// </summary>
            [Column("Parentid", DataType.Int, false, false)]
            public int? parentid { set; get; }


            /// <summary>
            /// 
            /// </summary>
            [Column("Areaname", DataType.Varchar, false, false)]
            public string Areaname { set; get; }


            #endregion DictArea

    }

}
