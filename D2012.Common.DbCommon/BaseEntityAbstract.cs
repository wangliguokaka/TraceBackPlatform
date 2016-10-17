﻿using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Reflection;

namespace D2012.Common.DbCommon
{
    /// <summary>
    /// Entiry 基类
    /// </summary>
    public abstract class BaseEntityAbstract
    {
        /// <summary>
        /// 根据实体的类型获得实体表信息
        /// </summary>
        /// <param name="type">实体类类型</param>
        /// <returns></returns>
        public abstract TableInfo GetTableInfo(Type type);

        /// <summary>
        /// 根据实体类的公共接口获得实体表信息
        /// </summary>
        /// <param name="entity">实体公共接口</param>
        /// <returns></returns>
        public abstract TableInfo GetTableInfo(IEntity entity);

        /// <summary>
        /// 根据实体泛型类型获得实体表信息
        /// </summary>
        /// <typeparam name="T">泛型类型</typeparam>
        /// <returns></returns>
        public abstract TableInfo GetTableInfo<T>() where T : IEntity;

        /// <summary>
        /// 根据实体的类型获得实体表列信息
        /// </summary>
        /// <param name="type">实体类类型</param>
        /// <returns></returns>
        public abstract ColumnAttribute[] GetColumnAttribute(Type type);

        /// <summary>
        /// 根据实体类的公共接口获得实体表列信息
        /// </summary>
        /// <param name="entity">实体公共接口</param>
        /// <returns></returns>
        public abstract ColumnAttribute[] GetColumnAttribute(IEntity entity);

        /// <summary>
        /// 根据实体泛型类型获得实体表列信息
        /// </summary>
        /// <typeparam name="T">泛型类型</typeparam>
        /// <returns></returns>
        public abstract ColumnAttribute[] GetColumnAttribute<T>() where T : IEntity;

        /// <summary>
        /// 根据实体的类型获得实体字段信息
        /// </summary>
        /// <param name="type">实体类类型</param>
        /// <returns></returns>
        public abstract FieldInfo[] GetFieldInfo(Type type);

        /// <summary>
        /// 根据实体类的公共接口获得实体字段信息
        /// </summary>
        /// <param name="entity">实体公共接口</param>
        /// <returns></returns>
        public abstract FieldInfo[] GetFieldInfo(IEntity entity);

        /// <summary>
        /// 根据实体泛型类型获得实体字段信息
        /// </summary>
        /// <typeparam name="T">泛型类型</typeparam>
        /// <returns></returns>
        public abstract FieldInfo[] GetFieldInfo<T>() where T : IEntity;

        /// <summary>
        /// 根据实体的类型获得实体属性信息
        /// </summary>
        /// <param name="type">实体类类型</param>
        /// <returns></returns>
        public abstract PropertyInfo[] GetPropertyInfo(Type type);

        /// <summary>
        /// 根据实体类的公共接口获得实体属性信息
        /// </summary>
        /// <param name="entity">实体公共接口</param>
        /// <returns></returns>
        public abstract PropertyInfo[] GetPropertyInfo(IEntity entity);

        /// <summary>
        /// 根据实体泛型类型获得实体属性信息
        /// </summary>
        /// <typeparam name="T">泛型类型</typeparam>
        /// <returns></returns>
        public abstract PropertyInfo[] GetPropertyInfo<T>() where T : IEntity;

        /// <summary>
        /// 根据实体的类型获得实体字段属性信息
        /// </summary>
        /// <param name="type">实体类类型</param>
        /// <returns></returns>
        public abstract LinkTableAttribute[] GetLinkTableAttribute(Type type);

        /// <summary>
        /// 根据实体类的公共接口获得实体字段属性信息
        /// </summary>
        /// <param name="entity">实体公共接口</param>
        /// <returns></returns>
        public abstract LinkTableAttribute[] GetLinkTableAttribute(IEntity entity);

        /// <summary>
        /// 根据实体泛型类型获得实体字段属性信息
        /// </summary>
        /// <typeparam name="T">泛型类型</typeparam>
        /// <returns></returns>
        public abstract LinkTableAttribute[] GetLinkTableAttribute<T>() where T : IEntity;

        /// <summary>
        /// 根据实体的类型获得实体字段集合属性信息
        /// </summary>
        /// <param name="type">实体类类型</param>
        /// <returns></returns>
        public abstract LinkTablesAttribute[] GetLinkTablesAttribute(Type type);

        /// <summary>
        /// 根据实体类的公共接口获得实体字段集合属性信息
        /// </summary>
        /// <param name="entity">实体公共接口</param>
        /// <returns></returns>
        public abstract LinkTablesAttribute[] GetLinkTablesAttribute(IEntity entity);

        /// <summary>
        /// 根据实体的类型获得实体字段集合属性信息
        /// </summary>
        /// <typeparam name="T">泛型类型</typeparam>
        /// <returns></returns>
        public abstract LinkTablesAttribute[] GetLinkTablesAttribute<T>() where T : IEntity;
    }
}
