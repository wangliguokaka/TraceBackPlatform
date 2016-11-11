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
        [Table("SaleDetail", "Id", false, false)]
        public partial class ModelSaleDetail : BaseEntity
        {
            public ModelSaleDetail()
            { }
            #region SaleDetail

            public static string STRTABLENAME = "SaleDetail";
            public static string STRKEYNAME = "Id";


            /// <summary>
            /// 
            /// </summary>
            [Column("Id", DataType.Int, false, false)]
            public int Id { set; get; }


            /// <summary>
            /// 
            /// </summary>
            [Column("Serial", DataType.Int, false, false)]
            public int Serial { set; get; }


            /// <summary>
            /// 
            /// </summary>
            [Column("Bh", DataType.Varchar, false, false)]
            public string Bh { set; get; }


            /// <summary>
            /// 
            /// </summary>
            [Column("orderid", DataType.Varchar, false, false)]
            public string orderid { set; get; }


            /// <summary>
            /// 
            /// </summary>
            [Column("Qty", DataType.Int, false, false)]
            public int? Qty { set; get; }


            /// <summary>
            /// 
            /// </summary>
            [Column("OClass", DataType.Varchar, false, false)]
            public string OClass { set; get; }


            /// <summary>
            /// 
            /// </summary>
            [Column("ObatchNo", DataType.Varchar, false, false)]
            public string ObatchNo { set; get; }


            /// <summary>
            /// 
            /// </summary>
            [Column("BatchNo", DataType.Varchar, false, false)]
            public string BatchNo { set; get; }


            /// <summary>
            /// 
            /// </summary>
            [Column("ProdDate", DataType.Datetime, false, false)]
            public DateTime? ProdDate { set; get; }


            /// <summary>
            /// 
            /// </summary>
            [Column("TestDate", DataType.Datetime, false, false)]
            public DateTime? TestDate { set; get; }


            /// <summary>
            /// 
            /// </summary>
            [Column("BtQty", DataType.Int, false, false)]
            public int? BtQty { set; get; }


            /// <summary>
            /// 
            /// </summary>
            [Column("SRate", DataType.Decimal, false, false)]
            public decimal? SRate { set; get; }

            /// <summary>
            /// 
            /// </summary>
            [Column("Valid", DataType.Varchar, false, false)]
            public string Valid { set; get; }


            /// <summary>
            /// 
            /// </summary>
            [Column("Addr", DataType.Varchar, false, false)]
            public string Addr { set; get; }


            /// <summary>
            /// 
            /// </summary>
            [Column("Receiver", DataType.Varchar, false, false)]
            public string Receiver { set; get; }



            /// <summary>
            /// 
            /// </summary>
            [Column("Tel", DataType.Varchar, false, false)]
            public string Tel { set; get; }



            /// <summary>
            /// 
            /// </summary>
            [Column("Distri", DataType.Varchar, false, false)]
            public string Distri { set; get; }




            /// <summary>
            /// 
            /// </summary>
            [Column("DistriNo", DataType.Varchar, false, false)]
            public string DistriNo { set; get; }


            /// <summary>
            /// 
            /// </summary>
            [Column("NoStart", DataType.Varchar, false, false)]
            public string NoStart { set; get; }


            /// <summary>
            /// 
            /// </summary>
            [Column("NoEnd", DataType.Varchar, false, false)]
            public string NoEnd { set; get; }

            /// <summary>
            /// 
            /// </summary>
            [Column("NoQty", DataType.Int, false, false)]
            public int? NoQty { set; get; }

            #endregion SaleDetail

        }

}
