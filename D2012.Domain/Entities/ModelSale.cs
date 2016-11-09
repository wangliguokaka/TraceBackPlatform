using D2012.Common.DbCommon;
using D2012.Domain.Common;
using System;
using System.Collections.Generic;

namespace D2012.Domain.Entities
{/// <summary>
    /// 
    /// </summary>
    [Serializable]
    [Table("Sale", "Id", false, false)]
    public partial class ModelSale : BaseEntity
    {
        public ModelSale()
        { }
        #region Sale

        public static string STRTABLENAME = "Sale";
        public static string STRKEYNAME = "Id";


        /// <summary>
        /// 
        /// </summary>
        [Column("Id", DataType.Int, true, true)]
        public int Id { set; get; }


        /// <summary>
        /// 
        /// </summary>
        [Column("SaleDate", DataType.Datetime, false, false)]
        public DateTime? SaleDate { set; get; }


        /// <summary>
        /// 
        /// </summary>
        [Column("seller", DataType.Varchar, false, false)]
        public string Seller { set; get; }


        /// <summary>
        /// 
        /// </summary>
        [Column("Salesperson", DataType.Varchar, false, false)]
        public string Salesperson { set; get; }


        /// <summary>
        /// 
        /// </summary>
        [Column("BillDate", DataType.Datetime, false, false)]
        public DateTime? BillDate { set; get; }


        /// <summary>
        /// 
        /// </summary>
        [Column("BillNo", DataType.Varchar, false, false)]
        public string BillNo { set; get; }


        /// <summary>
        /// 
        /// </summary>
        [Column("BillClass", DataType.Varchar, false, false)]
        public string BillClass { set; get; }


        /// <summary>
        /// 
        /// </summary>
        [Column("Reg", DataType.Varchar, false, false)]
        public string Reg { set; get; }


        /// <summary>
        /// 
        /// </summary>
        [Column("RegTime", DataType.Datetime, false, false)]
        public DateTime RegTime { set; get; }


        #endregion Sale

    }
}
