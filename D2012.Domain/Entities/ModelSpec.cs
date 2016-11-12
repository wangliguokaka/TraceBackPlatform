using D2012.Common.DbCommon;
using D2012.Domain.Common;
using System;
using System.Collections.Generic;

namespace D2012.Domain.Entities
{
    /// <summary>
    /// 用户管理
    /// </summary>
    [Serializable]
    [Table("Spec", "ID", false, false)]
    public partial class ModelSpec : BaseEntity
    {
        public ModelSpec()
        { }
        #region Model

        public static string STRTABLENAME = "Spec";
        public static string STRKEYNAME = "ID";


        /// <summary>
        /// 
        /// </summary>
        [Column("ID", DataType.Int, true, true)]
        public int ID { set; get; }

        
        /// <summary>
        /// 
        /// </summary>
        [Column("Class", DataType.Varchar, false, false)]
        public string Class { set; get; }

        /// <summary>
        /// 
        /// </summary>
        [Column("Bh", DataType.Varchar, false, false)]
        public string Bh{ set; get; }


        /// <summary>
        /// 
        /// </summary>
        [Column("ProductName", DataType.Varchar, false, false)]
        public string ProductName { set; get; }

        
        /// <summary>
        /// 
        /// </summary>
        [Column("Spec", DataType.Varchar, false, false)]
        public string Spec { set; get; }

        /// <summary>
        /// 
        /// </summary>
        [Column("exterior", DataType.Varchar, false, false)]
        public string exterior { set; get; }

        /// <summary>
        /// 
        /// </summary>
        [Column("Size", DataType.Varchar, false, false)]
        public string Size { set; get; }


        /// <summary>
        /// 
        /// </summary>
        [Column("OrderNo", DataType.Numeric, false, false)]
        public string OrderNo { set; get; }


        /// <summary>
        /// 
        /// </summary>
        [Column("Color", DataType.Varchar, false, false)]
        public string Color { set; get; }


        /// <summary>
        /// 
        /// </summary>
        [Column("Remark", DataType.Varchar, false, false)]
        public string Remark { set; get; }
        
        #endregion Model

    }
}