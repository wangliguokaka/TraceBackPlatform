using D2012.Common.DbCommon;
using D2012.Domain.Common;
using System;
using System.Collections.Generic;

namespace D2012.Domain.Entities
{
    /// <summary>
    /// 客户管理
    /// </summary>
    [Serializable]
    [Table("Client", "ID", false, false)]
    public partial class Client : BaseEntity
    {
        public Client()
        { }
        #region Client

        public static string STRTABLENAME = "Client";
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
        [Column("Serial", DataType.Varchar, false, false)]
        public string Serial { set; get; }

        /// <summary>
        /// 
        /// </summary>
        [Column("Client", DataType.Varchar, false, false)]
        public string Client { set; get; }

        /// <summary>
        /// 
        /// </summary>
        [Column("Tel", DataType.Varchar, false, false)]
        public string Tel { set; get; }


        /// <summary>
        /// 
        /// </summary>
        [Column("Tel2", DataType.Numeric, false, false)]
        public string Tel2 { set; get; }


        /// <summary>
        /// 
        /// </summary>
        [Column("Country", DataType.Varchar, false, false)]
        public string Country { set; get; }


        /// <summary>
        /// 
        /// </summary>
        [Column("Province", DataType.Varchar, false, false)]
        public string Province { set; get; }



        /// <summary>
        /// 
        /// </summary>
        [Column("city", DataType.Varchar, false, false)]
        public string City { set; get; }


        /// <summary>
        /// 
        /// </summary>
        [Column("addr", DataType.Varchar, false, false)]
        public string Addr { set; get; }



        /// <summary>
        /// 
        /// </summary>
        [Column("Email", DataType.Varchar, false, false)]
        public string Email { set; get; }



        /// <summary>
        /// 
        /// </summary>
        [Column("UserName", DataType.Varchar, false, false)]
        public string UserName { set; get; }


        /// <summary>
        /// 
        /// </summary>
        [Column("Password", DataType.Varchar, false, false)]
        public string Password { set; get; }


        #endregion Client

    }
}
