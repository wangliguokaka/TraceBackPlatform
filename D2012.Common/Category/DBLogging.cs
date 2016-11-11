using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;

namespace D2012.Common
{
    public class DBLogging : LoggingCategory
    {
        public DBLogging()
        {
            base.Category = "DBLogCategory";
        }
    }
}
