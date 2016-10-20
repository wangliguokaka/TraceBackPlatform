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
        [Table("Orders", null ,false, false)]
        public partial class Orders : BaseEntity
        {
            public Orders()
            { }
            #region Orders

            public static string STRTABLENAME = "Orders";


            /// <summary>
            /// 
            /// </summary>
            [Column("CardNo", DataType.Varchar, false, false)]
            public string CardNo { set; get; }


            /// <summary>
            /// 
            /// </summary>
            [Column("Serial", DataType.Varchar, false, false)]
            public string Serial { set; get; }

            /// <summary>
            /// 
            /// </summary>
            [Column("Order_ID", DataType.Varchar, false, false)]
            public string Order_ID { set; get; }

            /// <summary>
            /// 
            /// </summary>
            [Column("Hospital", DataType.Varchar, false, false)]
            public string Hospital { set; get; }


            /// <summary>
            /// 
            /// </summary>
            [Column("Doctor", DataType.Numeric, false, false)]
            public string Doctor { set; get; }


            /// <summary>
            /// 
            /// </summary>
            [Column("Patient", DataType.Varchar, false, false)]
            public string Patient { set; get; }


            /// <summary>
            /// 
            /// </summary>
            [Column("Age", DataType.Int, false, false)]
            public int Age { set; get; }



            /// <summary>
            /// 
            /// </summary>
            [Column("Sex", DataType.Varchar, false, false)]
            public string Sex { set; get; }


            /// <summary>
            /// 
            /// </summary>
            [Column("OutDate", DataType.Datetime, false, false)]
            public DateTime OutDate { set; get; }



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


            #endregion Orders

        }


}
