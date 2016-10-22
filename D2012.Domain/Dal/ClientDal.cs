using D2012.Common.DbCommon;
using D2012.DBUtility.Data.Core.SQLCore;
using D2012.Domain.Entities;
using System;
using System.Collections.Generic;
using System.Data;
using System.Data.SqlClient;
using System.Linq;
using System.Text;


namespace D2012.Domain.Dal
{
    public class ClientDal
    {
        #region  查询所有数据
        public DataSet SelectAll()
        {
            string allusers = "select Id,Class,Serial,	Client,	Tel,	Tel2,	Country,	province,	city,	addr,	Email,	UserName,Passwd from  dbo.Client";
            DataSet ds = new DataSet();
            ds = DbHelperSQL.Query(allusers);
            return ds;
        }
        #endregion  查询所有数据


        #region  按客户名查询
        public DataSet SelectByClient(string client)
        {
            string sql = "select Id,Class,Serial,Client,Tel,Tel2,Country,province,city,addr,Email,UserName,Passwd from  dbo.Client where client like '%@client%'";
            SqlParameter sqlparameter = new SqlParameter("@client", client);
            DataSet ds = new DataSet();
            ds = DbHelperSQL.Query(sql, sqlparameter);
            return ds;
        }
        #endregion  按客户名查询

        #region 按id查询
        public DataSet SelectById(string id)
        {
            string sql = "select Id,Class,Serial,	Client,	Tel,	Tel2,	Country,	province,	city,	addr,	Email,	UserName,Passwd from  dbo.Client where id=@id";
            SqlParameter sqlparameter = new SqlParameter("@id", id);
            DataSet ds = new DataSet();
            ds = DbHelperSQL.Query(sql, sqlparameter);
            return ds;
        }
        #endregion  按id查询



        #region 更新数据查询
        public void UpdateClient(string id)
        {
            string updateclient = "select id  from dbo.Client where id=@id";
            SqlParameter sqlparameter = new SqlParameter("@id", id);
            DbHelperSQL.GetSingle(updateclient, sqlparameter);
        }

        #endregion 更新数据查询


        #region 更新数据
        public void UpdateClientById(string Class, string Serial, string Client, string Tel, string Tel2, string Country, string province, string city, string addr, string Email, string UserName, string Passwd)
        {
            string updateclient = "update dbo.Client set Class='@Class',Serial='@Serial',Client='@Client',Tel='@Tel,' "
            + "Tel2='@Tel2',Country='@Country',province='@province',city='@city',addr='@addr',Email='@Email',UserName='@UserName',Passwd='@Passwd'  "
            +" where id=@id ";
            SqlParameter sqlparameter1 = new SqlParameter("@Class", Class);
            SqlParameter sqlparameter2 = new SqlParameter("@Serial", Serial);
            SqlParameter sqlparameter3 = new SqlParameter("@Client", Client);
            SqlParameter sqlparameter4 = new SqlParameter("@Tel", Tel);
            SqlParameter sqlparameter5 = new SqlParameter("@Tel2", Tel2);
            SqlParameter sqlparameter6 = new SqlParameter("@Country", Country);
            SqlParameter sqlparameter7 = new SqlParameter("@province", province);
            SqlParameter sqlparameter8 = new SqlParameter("@city", city);
            SqlParameter sqlparameter9 = new SqlParameter("@addr", addr);
            SqlParameter sqlparameter10 = new SqlParameter("@Email", Email);
            SqlParameter sqlparameter11 = new SqlParameter("@UserName", UserName);
            SqlParameter sqlparameter12 = new SqlParameter("@Passwd", Passwd);
            DbHelperSQL.ExecuteSql(updateclient, sqlparameter1, sqlparameter2, sqlparameter3, sqlparameter4,
                sqlparameter5, sqlparameter6, sqlparameter7, sqlparameter8, sqlparameter9, sqlparameter10, sqlparameter11, sqlparameter12); 
        }

        #endregion 更新数据

        #region 新增数据
        public void AddClient(string Class, string Serial, string Client, string Tel, string Tel2, string Country, string province, string city, string addr, string Email, string UserName, string Passwd)
        {
            string addclient = "insert into Client(Class,Serial,Client,Tel,Tel2,Country,province,city,addr,Email,UserName,Passwd) values"
                + "('@Class','@Serial','@Client','@Tel','@Tel2','@Country','@province','@city','@addr','@Email','@UserName','@Passwd')";
            SqlParameter sqlparameter1 = new SqlParameter("@Class", Class);
            SqlParameter sqlparameter2 = new SqlParameter("@Serial", Serial);
            SqlParameter sqlparameter3 = new SqlParameter("@Client", Client);
            SqlParameter sqlparameter4 = new SqlParameter("@Tel", Tel);
            SqlParameter sqlparameter5 = new SqlParameter("@Tel2", Tel2);
            SqlParameter sqlparameter6 = new SqlParameter("@Country", Country);
            SqlParameter sqlparameter7 = new SqlParameter("@province", province);
            SqlParameter sqlparameter8 = new SqlParameter("@city", city);
            SqlParameter sqlparameter9 = new SqlParameter("@addr", addr);
            SqlParameter sqlparameter10 = new SqlParameter("@Email", Email);
            SqlParameter sqlparameter11 = new SqlParameter("@UserName", UserName);
            SqlParameter sqlparameter12 = new SqlParameter("@Passwd", Passwd);
            DbHelperSQL.ExecuteSql(addclient, sqlparameter1, sqlparameter2, sqlparameter3, sqlparameter4,
                sqlparameter5, sqlparameter6, sqlparameter7, sqlparameter8, sqlparameter9, sqlparameter10, sqlparameter11, sqlparameter12); 

        }

        #endregion 新增数据

        #region 删除数据
        public void DeleteClient(string id)
        {
            string deleteclient = "delete from Client where id=@id";
            SqlParameter sqlparameter = new SqlParameter("@id", id);
            DbHelperSQL.ExecuteSql(deleteclient, sqlparameter); 
        }

        #endregion 删除数据

    }
}
