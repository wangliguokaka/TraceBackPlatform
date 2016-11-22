using D2012.Common.DbCommon;
using D2012.Domain.Common;
using System;
using System.Collections.Generic;

namespace D2012.Domain.Entities
{
    /// <summary>
    /// 基础信息
    /// </summary>
    [Serializable]
    [Table("Base", "ID", false, false)]
    public partial class ModelBase : BaseEntity
    {
        public ModelBase()
        { }
        #region ModelBase

        public static string STRTABLENAME = "Base";
        public static string STRKEYNAME = "ID";


        /// <summary>
        /// 
        /// </summary>
        [Column("ID", DataType.Int, true, false)]
        public int ID { set; get; }


        /// <summary>
        /// 
        /// </summary>
        [Column("corp", DataType.Varchar, false, false)]
        public string corp { set; get; }


        /// <summary>
        /// 
        /// </summary>
        [Column("Ecorp", DataType.Varchar, false, false)]
        public string Ecorp { set; get; }

        /// <summary>
        /// 
        /// </summary>
        [Column("Address", DataType.Varchar, false, false)]
        public string Address { set; get; }

        /// <summary>
        /// 
        /// </summary>
        [Column("netname", DataType.Varchar, false, false)]
        public string netname { set; get; }


        /// <summary>
        /// 
        /// </summary>
        [Column("Email", DataType.Numeric, false, false)]
        public string Email { set; get; }


        /// <summary>
        /// 
        /// </summary>
        [Column("LinkMan", DataType.Varchar, false, false)]
        public string LinkMan { set; get; }


        /// <summary>
        /// 
        /// </summary>
        [Column("phone", DataType.Varchar, false, false)]
        public string phone { set; get; }



        /// <summary>
        /// 
        /// </summary>
        [Column("fax", DataType.Varchar, false, false)]
        public string fax { set; get; }


        /// <summary>
        /// 
        /// </summary>
        [Column("ServerIP", DataType.Varchar, false, false)]
        public string ServerIP { set; get; }

        /// <summary>
        /// 
        /// </summary>
        [Column("ProductID", DataType.Varchar, false, false)]
        public string ProductID { set; get; }


        /// <summary>
        /// 
        /// </summary>
        [Column("RoleA", DataType.Varchar, false, false)]
        public string RoleA { set; get; }


        /// <summary>
        /// 
        /// </summary>
        [Column("RoleB", DataType.Varchar, false, false)]
        public string RoleB { set; get; }


        /// <summary>
        /// 
        /// </summary>
        [Column("RoleC", DataType.Varchar, false, false)]
        public string RoleC { set; get; }


        /// <summary>
        /// 
        /// </summary>
        [Column("RoleD", DataType.Varchar, false, false)]
        public string RoleD { set; get; }

        #endregion ModelBase
    }
}