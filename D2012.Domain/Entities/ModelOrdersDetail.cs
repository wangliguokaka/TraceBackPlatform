using D2012.Common.DbCommon;
using D2012.Domain.Common;
using System;
using System.Collections.Generic;

namespace D2012.Domain.Entities
{
         /// <summary>
        /// 订单管理
        /// </summary>
        [Serializable]
        [Table("OrdersDetail", null ,false, false)]
        public partial class ModelOrdersDetail : BaseEntity
        {
            public ModelOrdersDetail()
            { }
        #region OrdersDetail

        public static string STRTABLENAME = "OrdersDetail";

        /// <summary>
        /// 
        /// </summary>
        [Column("CardNo", DataType.Varchar, false, false)]
        public string CardNo { set; get; }

        /// <summary>
        /// 
        /// </summary>
        [Column("subNo", DataType.Int, false, false)]
        public int subNo { set; get; }

        /// <summary>
        /// 
        /// </summary>
        [Column("Itemname", DataType.Varchar, false, false)]
        public string Itemname { set; get; }



        /// <summary>
        /// 
        /// </summary>
        [Column("Qty", DataType.Int, false, false)]
        public int Qty { set; get; }
        /// <summary>
        /// 
        /// </summary>
        [Column("a_teeth", DataType.Varchar, false, false)]
        public string a_teeth { set; get; }

        /// <summary>
        /// 
        /// </summary>
        [Column("b_teeth", DataType.Varchar, false, false)]
        public string b_teeth { set; get; }


        /// <summary>
        /// 
        /// </summary>
        [Column("c_teeth", DataType.Varchar, false, false)]
        public string c_teeth { set; get; }


        /// <summary>
        /// 
        /// </summary>
        [Column("d_teeth", DataType.Varchar, false, false)]
        public string d_teeth { set; get; }


        /// <summary>
        /// 
        /// </summary>
        [Column("Color", DataType.Varchar, false, false)]
        public string Color { set; get; }

        /// <summary>
        /// 
        /// </summary>
        [Column("BatchNo", DataType.Varchar, false, false)]
        public string BatchNo { set; get; }


        /// <summary>
        /// 
        /// </summary>
        [Column("Valid", DataType.Varchar, false, false)]
        public string Valid { set; get; }

        #endregion OrdersDetail

    }


}
